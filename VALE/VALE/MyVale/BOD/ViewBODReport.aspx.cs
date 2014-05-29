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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.HasKeys())
                _currentReportId = Convert.ToInt32(Request.QueryString.GetValues("reportId").First());
        }

        public BODReport GetBODReport([QueryString("reportId")] int? reportId)
        {
            var db = new UserOperationsContext();
            return db.BODReports.First(r => r.BODReportId == reportId);
        }

        public List<String> GetRelatedDocuments([QueryString("reportId")] int? reportId)
        {
            if (reportId.HasValue)
            {
                var db = new UserOperationsContext();
                var report = db.BODReports.First(p => p.BODReportId == reportId);
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
            var db = new UserOperationsContext();
            var project = db.BODReports.First(r => r.BODReportId == _currentReportId);
            var lstDocument = (ListBox)BODReportDetail.FindControl("lstDocuments");
            if (lstDocument.SelectedIndex > -1)
            {
                var file = project.DocumentsPath + lstDocument.SelectedValue;
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.ClearContent();
                response.Clear();
                response.ContentType = "application/octet-stream";
                string serverPath = Server.MapPath(file);
                if (File.Exists(serverPath))
                {
                    Response.Redirect(file);
                }
            }
        }
    }
}