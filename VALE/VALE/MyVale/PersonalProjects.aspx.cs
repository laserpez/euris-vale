using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class PersonalProjects : Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                ShowHideControls();
            }
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "Progetti"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina PersonalProjects.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        private void ShowHideControls()
        {
            var db = new UserOperationsContext();
            var organizedPrj = db.UserDatas.Where(u => u.UserName == _currentUser).First().OrganizedProjects;
            var attendingPrj = db.UserDatas.Where(u => u.UserName == _currentUser).First().AttendingProjects;

            if (organizedPrj.Count() != 0 || attendingPrj.Count() != 0)
            {
                btnCurrentView.Visible = true;
            }
            else
            {
                btnCurrentView.Visible = false;
            }
        }

        public IQueryable<Project> GetPersonalProjects()
        {
            IQueryable<Project> result = null;

            if (btnCurrentView.Attributes.Count != 0)
            {
                var keys = btnCurrentView.Attributes.Keys;

                var aValue = btnCurrentView.Attributes["btnPressed"];

                if (!string.IsNullOrEmpty(aValue))
                {
                    if (aValue == "btnAttending")
                        result = GetAttendingProjects();
                    else
                        result = GetOrganizedProjects();
                }
                else
                {
                    result = GetAllPersonalProjects();
                }
            }
            
            return result;
        }

        public IQueryable<Project> GetAllPersonalProjects()
        {
            var db = new UserOperationsContext();
            List<Project> listOrganizedProjects = GetOrganizedProjects().ToList();
            List<Project> listAttendingProjects = GetAttendingProjects().ToList();
            List<Project> tempList = new List<Project>();
            List<Project> allPersonalProjects = new List<Project>();
            if (listOrganizedProjects.Count > listAttendingProjects.Count)
            {
                foreach (var project in listOrganizedProjects)
                {
                    if (!listAttendingProjects.Contains(project))
                        tempList.Add(project);
                }

                allPersonalProjects = listOrganizedProjects.Union(tempList).ToList();
            }
            else
            {
                foreach (var project in listAttendingProjects)
                {
                    if (!listOrganizedProjects.Contains(project))
                        tempList.Add(project);
                }
                allPersonalProjects = listAttendingProjects.Union(tempList).ToList();
            }

            return allPersonalProjects.AsQueryable();
        }

        public IQueryable<Project> GetOrganizedProjects()
        {
            var db = new UserOperationsContext();
            return db.UserDatas.Where(u => u.UserName == _currentUser).First().OrganizedProjects.AsQueryable();
        }

        public IQueryable<Project> GetAttendingProjects()
        {
            var db = new UserOperationsContext();
            return db.UserDatas.Where(u => u.UserName == _currentUser).First().AttendingProjects.AsQueryable();
        }

        protected void grid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch(e.CommandName)
            {
                case "ViewDetails":
                    int projectId = Convert.ToInt32(e.CommandArgument);
                    Response.Redirect("/MyVale/ProjectDetails?projectId=" + projectId + "&From=/MyVale/PersonalProjects");
                    break;
                default:
                    break;
            }
        }

        protected void btnViewProjects_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            var buttonId = button.ID;

            btnCurrentView.InnerText = "Progetti" + " " + button.Text;
            btnCurrentView.Attributes.Remove("btnPressed");
            btnCurrentView.Attributes.Add("btnPressed", buttonId);
            
            grdProjectList.DataBind();

        }

        public string GetDescription(string description)
        {
            if (!String.IsNullOrEmpty(description))
            {
                HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                doc.LoadHtml(description);
                description = doc.DocumentNode.InnerText;
                return doc.DocumentNode.InnerText.Length >= 30 ? doc.DocumentNode.InnerText.Substring(0, 30) + "..." : doc.DocumentNode.InnerText;
            }
            else
            {
                return "Nessuna descrizione presente";
            }
        }
    }
}