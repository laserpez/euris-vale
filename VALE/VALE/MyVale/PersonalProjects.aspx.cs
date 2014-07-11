﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class PersonalProjects : System.Web.UI.Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if (!IsPostBack)
            {
                ShowHideControls();
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
            var listOrganizedProjects = GetOrganizedProjects().ToList();
            var listAttendingProjects = GetAttendingProjects().ToList();
            var concatProjects = listAttendingProjects.Concat(listOrganizedProjects);
            return concatProjects.AsQueryable();
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
                    Response.Redirect("/MyVale/ProjectDetails?projectId=" + projectId);
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

        protected void grdProjectList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            for (int i = 0; i < grdProjectList.Rows.Count; i++)
            {
                int projectId = (int)grdProjectList.DataKeys[i].Value;
                var db = new UserOperationsContext();

                Label lblContent = (Label)grdProjectList.Rows[i].FindControl("lblContent");
                string projectDescription = db.Projects.FirstOrDefault(p => p.ProjectId == projectId).Description;
                var textToSee = projectDescription.Length >= 65 ? projectDescription.Substring(0, 65) + "..." : projectDescription;
                lblContent.Text = textToSee;
            }
        }
    }
}