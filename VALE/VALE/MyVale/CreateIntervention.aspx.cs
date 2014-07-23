using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using System.IO;
using VALE.Models;
using VALE.Logic;
using System.Data.Entity.Validation;

namespace VALE.MyVale
{
    public partial class CreateIntervention : System.Web.UI.Page
    {
        private string _currentUser;
        private int _currentProjectId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
        }

        protected void btnSaveIntervention_Click(object sender, EventArgs e)
        {
            if (btnSaveInterventionWithAttachment.Attributes.Count != 0)
            {
                var actions = new InterventionActions();
                var listAttachments = actions.GetAttachments(FileUploader.DataId);
                if (listAttachments.Count == 0)
                {
                    btnSaveInterventionWithAttachment.Attributes.Remove("btnPressed");
                    Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
                }
                else
                {
                    var keys = btnSaveInterventionWithAttachment.Attributes.Keys;
                    var aValue = btnSaveInterventionWithAttachment.Attributes["btnPressed"];
                    if (!string.IsNullOrEmpty(aValue))
                        Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
                }
            }
            else
            {
                var db = new UserOperationsContext();
                var intervention = new Intervention
                {
                    CreatorUserName = _currentUser,
                    ProjectId = _currentProjectId,
                    InterventionText = txtComment.Text,
                    Date = DateTime.Today
                };
                var actions = new InterventionActions();
                actions.SaveData(intervention, db);

                Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
            }
        }

        protected void btnSaveInterventionWithAttachment_Click(object sender, EventArgs e)
        {
            btnSaveInterventionWithAttachment.Attributes.Remove("btnPressed");
            btnSaveInterventionWithAttachment.Attributes.Add("btnPressed", btnSaveInterventionWithAttachment.ID);

            var db = new UserOperationsContext();
            var intervention = new Intervention
            {
                CreatorUserName = _currentUser,
                ProjectId = _currentProjectId,
                InterventionText = txtComment.Text,
                Date = DateTime.Today
            };

            var actions = new InterventionActions();
            actions.SaveData(intervention, db);

            FileUploader.Visible = true;
            FileUploader.DataActions = new InterventionActions();
            FileUploader.DataId = intervention.InterventionId;
        }
    }
}