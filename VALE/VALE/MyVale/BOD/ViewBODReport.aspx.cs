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
    }
}