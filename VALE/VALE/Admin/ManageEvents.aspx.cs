using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Admin
{
    public partial class ManageEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void grdEventList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int eventId = Convert.ToInt32(grdEventList.Rows[index].Cells[0].Text);

            if (e.CommandName == "DeleteProject")
            {
                var dbData = new UserOperationsContext();
                var thisEvent = dbData.Events.First(ev => ev.EventId == eventId);
                if (!String.IsNullOrEmpty(thisEvent.DocumentsPath))
                {
                    if (Directory.Exists(Server.MapPath(thisEvent.DocumentsPath)))
                        Directory.Delete(Server.MapPath(thisEvent.DocumentsPath), true);
                }
                dbData.Events.Remove(thisEvent);
                dbData.SaveChanges();
                grdEventList.DataBind();
            }
            else
            {
                Response.Redirect("/Admin/EventReport?eventId=" + eventId);
            }
        }

        public string GetOrganizerName(string userName)
        {
            var db = new UserOperationsContext();
            return db.UsersData.First(u => u.UserName == userName).FullName;

        }

        public IQueryable<Event> GetEvents()
        {
            var db = new UserOperationsContext();
            return db.Events;
        }
    }
}