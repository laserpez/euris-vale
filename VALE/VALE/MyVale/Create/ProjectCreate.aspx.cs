using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class ProjectCreate : Page
    {
        private string _currentUser;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                chkPublic.Checked = true;
                if (Request.QueryString["From"] != null)
                    Session["ProjectCreateRequestFrom"] = Request.QueryString["From"];
            }
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneProgetti"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ProjectCreate.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        private int getMinutes(int days, int hours, int min) 
        {
            return days * (8 * 60) + hours * 60 + min;
        }
        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();

            if (dbData.Projects.Where(o => o.ProjectName == txtName.Text).FirstOrDefault() != null)
            {
                ModelState.AddModelError("", "Nome Progetto già esistente");
            }
            else
            {
                int days = 0;
                int.TryParse(TextDay.Text, out days);
                int hours = 0;
                int.TryParse(txtHour.Text, out hours);
                int min = 0;
                int.TryParse(txtMin.Text, out min);
                var project = new Project
                {
                    CreationDate = Convert.ToDateTime(txtStartDate.Text),
                    OrganizerUserName = _currentUser,
                    Description = txtDescription.Text,
                    Type = ddlSelectType.SelectedValue,
                    ProjectName = txtName.Text,
                    LastModified = Convert.ToDateTime(txtStartDate.Text),
                    Status = "Aperto",
                    Budget = getMinutes(days, hours, min),
                    Public = chkPublic.Checked,
                    Activities = new List<Activity>(),
                    Events = new List<Event>(),
                    InvolvedUsers = new List<UserData>(),
                };

                var projectActions = new ProjectActions();
                projectActions.SaveData(project, dbData);
                Response.Redirect("~/MyVale/Projects");
            }
        }

        public List<ProjectType> GetTypes()
        {
            var db = new UserOperationsContext();
            return db.ProjectTypes.ToList();
        }

        protected void btnAddUsers_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();

            
            if (dbData.Projects.Where(o => o.ProjectName == txtName.Text).FirstOrDefault() != null)
            {
                ModelState.AddModelError("", "Nome Progetto già esistente");
            }
            else
            {
                int days = 0;
                int.TryParse(TextDay.Text, out days);
                int hours = 0;
                int.TryParse(txtHour.Text, out hours);
                int min = 0;
                int.TryParse(txtMin.Text, out min);
                var project = new Project
                {
                    Type = ddlSelectType.SelectedValue,
                    CreationDate = Convert.ToDateTime(txtStartDate.Text),
                    OrganizerUserName = _currentUser,
                    Description = txtDescription.Text,
                    ProjectName = txtName.Text,
                    LastModified = Convert.ToDateTime(txtStartDate.Text),
                    Status = "Aperto",
                    Budget = getMinutes(days, hours, min),
                    Public = chkPublic.Checked,
                    Activities = new List<Activity>(),
                    Events = new List<Event>(),
                    InvolvedUsers = new List<UserData>(),
                };

                var projectActions = new ProjectActions();
                projectActions.SaveData(project, dbData);
                Response.Redirect("/MyVale/UserSelector.aspx?dataId=" + project.ProjectId + "&dataType=project&returnUrl=/MyVale/Projects");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Session["ProjectCreateRequestFrom"] != null) 
            {
                var url = Session["ProjectCreateRequestFrom"].ToString();
                Session["ProjectCreateRequestFrom"] = null;
                Response.Redirect(url);
            }
            Response.Redirect("~/MyVale/Projects");
        }
    }
}