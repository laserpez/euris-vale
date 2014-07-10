using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using VALE.Logic;

namespace VALE.MyVale.BOD
{
    public partial class BODReportCreate : System.Web.UI.Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
            if (!IsPostBack)
            {
                ViewState["reportId"] = 0;
                CalendarPublishDate.StartDate = DateTime.Now;
            }
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

            var actions = new BODReportActions();
            actions.SaveData(report, db);

            ViewState["reportId"] = report.BODReportId;
            Response.Redirect("~/MyVale/BOD/BODReports");
        }

        protected void txtMeetingDate_TextChanged(object sender, EventArgs e)
        {
            CalendarPublishDate.StartDate = Convert.ToDateTime(txtMeetingDate.Text);
        }

    }
}