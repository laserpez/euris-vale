using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

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

        public IQueryable<BODReport> GetBODReports()
        {
            var db = new UserOperationsContext();
            return db.BODReports.OrderBy(b => b.BODReportId).AsQueryable();
        }

        protected void grdBODReport_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewReport")
                Response.Redirect("/MyVale/BOD/ViewBODReport?reportId=" + e.CommandArgument);
        }

        protected void btnAddBODReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/BOD/BODReportCreate?From=~/MyVale/BOD/BODReports");
        }
    }
}