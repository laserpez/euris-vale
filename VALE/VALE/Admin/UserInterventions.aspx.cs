using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.Admin
{
    public partial class UserInterventions : System.Web.UI.Page
    {
        private int _projectId;
        private string _userEmail;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString.HasKeys())
            {
                _projectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
                _userEmail = Request.QueryString.GetValues("userId").First();
            }
        }

        public IQueryable<AttachedFile> DocumentsGridView_GetData()
        {
            var actions = new InterventionActions();
            var _db = new UserOperationsContext();
            var _currentInterventionId = _db.Interventions.FirstOrDefault(i => i.Creator.Email == _userEmail && i.ProjectId == _projectId).InterventionId;
            var list = actions.GetAttachments(_currentInterventionId);
            return list.AsQueryable();
        }

        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var db = new UserOperationsContext();
            int id = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "DOWNLOAD":
                default:
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
            }
        }

        public IQueryable<Intervention> GetInterventions([QueryString("userId")] string userEmail, [QueryString("projectId")] int? projectId)
        {
            if (!String.IsNullOrEmpty(userEmail) && projectId.HasValue)
            {
                var db = new UserOperationsContext();
                return db.Interventions.Where(i => i.Creator.Email == userEmail && i.ProjectId == projectId);
            }
            else
                return null;
        }

        protected void lstInterventions_DataBound(object sender, EventArgs e)
        {
            var title = String.Format(HeaderName.Text, GetWorkerName(), GetProject());
            HeaderName.Text = title;

            for (int i = 0; i < lstInterventions.Items.Count; i++)
            {
                var db = new UserOperationsContext();
                string result = db.Interventions.FirstOrDefault(c => c.Creator.Email == _userEmail && c.ProjectId == _projectId).InterventionText;
                Label txtDescription = (Label)lstInterventions.Items[i].FindControl("txtDescription");
                if (String.IsNullOrEmpty(result))
                    txtDescription.Text = "Nessun commento inserito";
                else
                    txtDescription.Text = result;
            }
        }

        public string GetWorkerName()
        {
            var db = new UserOperationsContext();
            return db.UserDatas.First(u => u.Email == _userEmail).FullName;
        }

        public string GetProject()
        {
            var db = new UserOperationsContext();
            return db.Projects.First(p => p.ProjectId == _projectId).ProjectName;
        }
    }
}