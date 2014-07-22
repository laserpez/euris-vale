using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale.BOD
{
    public partial class BODReports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<BODReport> GetBODReports()
        {
            var db = new UserOperationsContext();
            return db.BODReports;
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