using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

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

            var dbData = new UserOperationsContext();

            if (e.CommandName == "DeleteProject")
            {
                EventID.Text = eventId.ToString();
                EventName.Text = dbData.Events.Where(o => o.EventId == eventId).FirstOrDefault().Name;
                ModalPopup.Show();
            }
            else
            {
                Response.Redirect("/Admin/EventReport?eventId=" + eventId);
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
                int Id = Convert.ToInt32(EventID.Text);
                var thisEvent = dbData.Events.First(ev => ev.EventId == Id);
                if (!String.IsNullOrEmpty(thisEvent.DocumentsPath))
                {
                    if (Directory.Exists(Server.MapPath(thisEvent.DocumentsPath)))
                        Directory.Delete(Server.MapPath(thisEvent.DocumentsPath), true);
                }
                dbData.Events.Remove(thisEvent);
                dbData.SaveChanges();
                grdEventList.DataBind();
                Response.Redirect("/Admin/ManageEvents.aspx");
            }
            else
            {
                ErrorDeleteLabel.Visible = true;
                ErrorDeleteLabel.Text = "Wrong password";
                ModalPopup.Show();
            }
        }



        public IQueryable<Event> GetEvents()
        {
            var db = new UserOperationsContext();
            return db.Events;
        }
    }
}