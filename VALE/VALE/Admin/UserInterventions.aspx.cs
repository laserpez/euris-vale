using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
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

        public IQueryable<string> GetDocuments([Control("ItemId")] int interventionId)
        {
            var db = new UserOperationsContext();
            var path = db.Interventions.First(i => i.InterventionId == interventionId).DocumentsPath;
            DirectoryInfo dir = new DirectoryInfo(Server.MapPath(path));
            return dir.GetFiles().Select(f => f.Name).AsQueryable();
        }

        protected void lstInterventions_DataBound(object sender, EventArgs e)
        {
            var title = String.Format(HeaderName.Text, GetWorkerName(), GetProject());
            HeaderName.Text = title;
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