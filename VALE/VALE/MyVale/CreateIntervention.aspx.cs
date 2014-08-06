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
    public partial class CreateIntervention : Page
    {
        private string _currentUser;
        private int _currentProjectId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString["projectId"] != null)
                Session["InterventionCreateCallingProjectId"] = Request.QueryString["projectId"];
            if (Request.QueryString.HasKeys())
                _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Progetti"))
            {
                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina CreateIntervention.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
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
                var intervention = SaveData();

                Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
            }
        }

        protected void btnSaveInterventionWithAttachment_Click(object sender, EventArgs e)
        {
            btnSaveInterventionWithAttachment.Attributes.Remove("btnPressed");
            btnSaveInterventionWithAttachment.Attributes.Add("btnPressed", btnSaveInterventionWithAttachment.ID);

            var intervention = SaveData();

            FileUploader.Visible = true;
            FileUploader.DataActions = new InterventionActions();
            FileUploader.DataId = intervention.InterventionId;
        }

        private Intervention SaveData()
        {
            var db = new UserOperationsContext();
            var newIntervention = new Intervention
            {
                CreatorUserName = _currentUser,
                ProjectId = _currentProjectId,
                InterventionText = txtComment.Text,
                Date = DateTime.Today
            };

            var actionsIntervention = new InterventionActions();
            actionsIntervention.SaveData(newIntervention, db);

            return newIntervention;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (btnSaveInterventionWithAttachment.Attributes.Count != 0)
            {
                var _db = new UserOperationsContext();
                var lstInterventions = _db.Interventions.Where(i => i.ProjectId == _currentProjectId).ToList();
                foreach (var intervention in lstInterventions)
                {
                    if (String.IsNullOrEmpty(intervention.InterventionText) && intervention.AttachedFiles.Count == 0)
                    {
                        _db.Interventions.Remove(intervention);
                        _db.SaveChanges();
                    }
                }

                btnSaveInterventionWithAttachment.Attributes.Remove("btnPressed");
            }

            var redirectURL = "";
            if (Session["InterventionCreateCallingProjectId"] != null)
            {
                redirectURL = "/MyVale/ProjectDetails?projectId=" + Session["InterventionCreateCallingProjectId"].ToString();
                Session["InterventionCreateCallingProjectId"] = null;
            }
            else
                redirectURL = "/MyVale/ProjectDetail?" + _currentProjectId;
            Response.Redirect(redirectURL);
        }
    }
}