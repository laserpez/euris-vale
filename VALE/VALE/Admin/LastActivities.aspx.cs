using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.Admin
{
    public partial class LastActivities : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<LogEntry> GetLogEntry()
        {
            var db = new UserOperationsContext();
            return db.LogEntries.OrderByDescending(e => e.Date);
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var logsToExport = db.LogEntries.ToList();
            using (var exportToCSV = new ExportToCSV())
            {
                Response.AddHeader("content-disposition", string.Format("attachment; filename=LogUltimeAttività({0}).csv", DateTime.Now.ToShortDateString()));
                Response.ContentType = "application/text";
                StringBuilder strbldr = exportToCSV.ExportLogLastActivity(logsToExport);
                Response.Write(strbldr.ToString());
                Response.End();
            }
        }

        protected void btnDeleteAllLogs_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            List<LogEntry> logs = db.LogEntries.ToList();

            if (logs.Count != 0)
                db.LogEntries.RemoveRange(logs);

            db.SaveChanges();

            Response.Redirect("~/Admin/LastActivities");
        }
    }
}