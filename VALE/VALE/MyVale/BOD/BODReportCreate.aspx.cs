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
    public partial class BODReportCreate : Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();
            _currentUserId = User.Identity.GetUserId();
            if (!IsPostBack)
            {
                ViewState["reportId"] = 0;
                CalendarPublishDate.StartDate = DateTime.Now;
                if (Request.QueryString["From"] != null)
                    Session["BODReportCreateRequestFrom"] = Request.QueryString["From"];
            }
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "CreazioneConsiglio"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina BODReportCreate.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
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
            if (Session["BODReportCreateRequestFrom"] != null)
            {
                Session["BODReportCreateRequestFrom"] = null;
                Response.Redirect(Session["BODReportCreateRequestFrom"].ToString());
            }
            Response.Redirect("~/MyVale/BOD/BODReports");
        }

        protected void txtMeetingDate_TextChanged(object sender, EventArgs e)
        {
            DateTime dData;
            if (DateTime.TryParse(txtMeetingDate.Text, out dData))
                CalendarPublishDate.StartDate = Convert.ToDateTime(txtMeetingDate.Text);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

            if (Session["BODReportCreateRequestFrom"] != null)
            {
                var url = Session["BODReportCreateRequestFrom"].ToString();
                Session["BODReportCreateRequestFrom"] = null;
                Response.Redirect(url);
            }
            Response.Redirect("~/MyVale/BOD/BODReports");
        }
    }
}