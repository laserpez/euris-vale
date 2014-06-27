using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;

namespace VALE.MyVale.BOD
{
    public partial class BODReportCreate : System.Web.UI.Page
    {
        private string _currentUserId;
        private int _currentProjectId;
        private string _temporaryPath;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
            _temporaryPath = "/MyVale/Documents/Temp/" + _currentUserId + "/";
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
            if (!IsPostBack)
            {
                if (!String.IsNullOrEmpty(_temporaryPath))
                {
                    if (Directory.Exists(Server.MapPath(_temporaryPath)))
                        Directory.Delete(Server.MapPath(_temporaryPath), true);
                    Directory.CreateDirectory(Server.MapPath(_temporaryPath));
                }
                CalendarMeetingDate.StartDate = DateTime.Now;
                CalendarPublishDate.StartDate = DateTime.Now;
            }
        }


        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView grid = (GridView)sender;
            int index = Convert.ToInt32(e.CommandArgument);
            string fileToRemove = grid.Rows[index].Cells[1].Text;
            File.Delete(Server.MapPath(_temporaryPath) + fileToRemove);
        }

        
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var report = new BODReport
            {
                Name = txtReportName.Text, 
                MeetingDate = Convert.ToDateTime(txtMeetingDate.Text), 
                PublishingDate = Convert.ToDateTime(txtPublishDate.Text),
                Location = txtLocation.Text,
                Text= txtReportText.Text
            };
            db.BODReports.Add(report);
            db.SaveChanges();
            lblUploadFile.Visible = true;
            FileUploader.Visible = true;

        }

        protected void txtMeetingDate_TextChanged(object sender, EventArgs e)
        {
            CalendarPublishDate.StartDate = Convert.ToDateTime(txtMeetingDate.Text).AddDays(1);
        }

    }
}