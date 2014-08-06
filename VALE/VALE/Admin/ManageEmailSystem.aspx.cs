using System;
using System.Collections.Generic;
using System.Linq;
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
            var listAllLog = _db.LogEntriesEmail.ToList();
            if (listAllLog.Count > 1000)
            {
                if (CleanLog(listAllLog))
                    return _db.LogEntriesEmail.OrderByDescending(e => e.Date).AsQueryable();
                else
                    return null;
            }
            else
                return _db.LogEntriesEmail.Take(1000).OrderByDescending(e => e.Date).AsQueryable();
        }

        private bool CleanLog(List<LogEntryEmail> listLog)
        {
            try
            {
                var _db = new UserOperationsContext();
                _db.LogEntriesEmail.RemoveRange(listLog.GetRange(1001, listLog.Count - 1000));
                _db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}