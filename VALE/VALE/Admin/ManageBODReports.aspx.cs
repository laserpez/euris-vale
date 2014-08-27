using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using VALE.Logic;

namespace VALE.Admin
{
    public partial class ManageBODReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<BODReport> GetBODReports()
        {
            var db = new UserOperationsContext();
            return db.BODReports.OrderByDescending(b => b.BODReportId).AsQueryable();
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
                Name.Text = dbData.BODReports.Where(br => br.BODReportId == BODReportID).FirstOrDefault().Name;
                ModalPopup.Show();
            }
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
                Response.Redirect("/Admin/ManageBODReports.aspx");
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