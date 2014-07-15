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
using VALE.Logic;

namespace VALE.Admin
{
    public partial class ManageEvents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            grdEventList.AllowSorting = true;
        }

        protected void grdEventList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProject")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int eventId = Convert.ToInt32(grdEventList.DataKeys[index].Value);

                var dbData = new UserOperationsContext();
                EventID.Text = eventId.ToString();
                EventName.Text = dbData.Events.Where(o => o.EventId == eventId).FirstOrDefault().Name;
                ModalPopup.Show();
            }
            else if (e.CommandName == "ViewReport")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int eventId = Convert.ToInt32(grdEventList.DataKeys[index].Value);

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
                int eventId = Convert.ToInt32(EventID.Text);

                var thisEvent = dbData.Events.First(ev => ev.EventId == eventId);
                var eventActions = new EventActions();
                eventActions.RemoveAllAttachments(eventId);

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
            return db.Events.AsQueryable();
        }

        public string GetDescription(string description)
        {
            HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
            doc.LoadHtml(description);
            description = doc.DocumentNode.InnerText;
            return doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
        }
    }
}