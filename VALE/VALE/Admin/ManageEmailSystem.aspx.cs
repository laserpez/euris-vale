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
    public partial class ManageEmailSystem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
        }

        private void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ManageProject.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public IQueryable<LogEntryEmail> grdLogEmail_GetData()
        {
            var _db = new UserOperationsContext();
            return _db.LogEntriesEmail.Take(1000).OrderByDescending(e => e.Date).AsQueryable();
        }

        public string GetStatus(LogEntryEmail logEmail)
        {
            ILoggerEmail logger = LogFactoryEmail.GetCurrentLoggerEmail();
            return logger.GetStatus(logEmail);
        }

        public string GetBody(string body)
        {
            HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
            doc.LoadHtml(body);
            body = doc.DocumentNode.InnerText;
            return doc.DocumentNode.InnerText;
        }

        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var logsToExport = db.LogEntriesEmail.ToList();
            using (var exportToCSV = new ExportToCSV())
            {
                Response.AddHeader("content-disposition", string.Format("attachment; filename=LogsEmail({0}).csv", DateTime.Now.ToShortDateString()));
                Response.ContentType = "application/text";
                StringBuilder strbldr = exportToCSV.ExportLogEntryEmail(logsToExport);
                Response.Write(strbldr.ToString());
                Response.End();
            }
        }

        protected void btnDeleteAllLogs_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            List<LogEntryEmail> logsEmail = db.LogEntriesEmail.ToList();
            List<MailQueue> emailQueue = db.MailQueues.ToList();
            
            if (logsEmail.Count != 0)
                db.LogEntriesEmail.RemoveRange(logsEmail);

            db.SaveChanges();

            Response.Redirect("~/Admin/ManageEmailSystem");
        }
    } 
}