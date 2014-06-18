using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale.BOD
{
    public partial class ViewBODReport : System.Web.UI.Page
    {
        private int _currentReportId;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            if (Request.QueryString.HasKeys())
                _currentReportId = Convert.ToInt32(Request.QueryString["reportId"]);
        }

        public BODReport GetBODReport([QueryString("reportId")] int? reportId)
        {
            return _db.BODReports.First(r => r.BODReportId == reportId);
        }

        public List<String> GetRelatedDocuments([QueryString("reportId")] int? reportId)
        {
            if (reportId.HasValue)
            {
                var report = _db.BODReports.First(p => p.BODReportId == reportId);
                if (!String.IsNullOrEmpty(report.DocumentsPath))
                {
                    var dir = new DirectoryInfo(Server.MapPath(report.DocumentsPath));
                    var files = dir.GetFiles().Select(f => f.Name).ToList();
                    if (files.Count == 0)
                        HideListBox("lstDocuments");
                    return files;
                }
                else
                {
                    HideListBox("lstDocuments");
                    return null;
                }
            }
            else
            {
                HideListBox("lstDocuments");
                return null;
            }
        }

        private void HideListBox(string name)
        {
            ListBox list = (ListBox)BODReportDetail.FindControl(name);
            list.Visible = false;
        }

        protected void btnViewDocuments_Click(object sender, EventArgs e)
        {
            var report = _db.BODReports.First(r => r.BODReportId == _currentReportId);
            var lstDocument = (ListBox)BODReportDetail.FindControl("lstDocuments");
            if (lstDocument.SelectedIndex > -1)
            {
                var file = report.DocumentsPath + lstDocument.SelectedValue;
                Response.Redirect("/DownloadFile.ashx?filePath=" + file + "&fileName=" + lstDocument.SelectedValue);
            }
        }
    }
}