using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace VALE.MyVale.BOD
{
    public partial class BODReports : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Consiglio"))
            {
                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina BODReports.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
                grdBODReport.Columns[5].Visible = false;
        }

        public IQueryable<BODReport> GetBODReports()
        {
            var db = new UserOperationsContext();
            return db.BODReports.OrderBy(b => b.BODReportId).OrderByDescending(br => br.MeetingDate).AsQueryable();
        }

        protected void grdBODReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewReport")
                Response.Redirect("/MyVale/BOD/ViewBODReport?reportId=" + e.CommandArgument);
            else if (e.CommandName == "DeleteBODReport")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var BODReportID = (int)grdBODReport.DataKeys[index].Value;
                var dbData = new UserOperationsContext();
                BODReportId.Text = BODReportID.ToString();
                ModalPopup.Show();
            }
        }

        protected void btnAddBODReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/BOD/BODReportCreate?From=~/MyVale/BOD/BODReports");
        }

        protected void CloseButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = manager.Find(User.Identity.Name, PassTextBox.Text);
            if (user != null)
            {
                var dbData = new UserOperationsContext();
                int Id = Convert.ToInt32(BODReportId.Text);
                var BODReport = dbData.BODReports.First(br => br.BODReportId == Id);
                var actions = new BODReportActions();

                actions.RemoveAllAttachments(Id);

                dbData.BODReports.Remove(BODReport);
                dbData.SaveChanges();
                grdBODReport.PageIndex = 0;
                grdBODReport.DataBind();
            }
            else
            {
                ErrorDeleteLabel.Visible = true;
                ErrorDeleteLabel.Text = "Password sbagliata";
                ModalPopup.Show();
            }
        }
    }
}