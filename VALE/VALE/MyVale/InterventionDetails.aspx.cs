using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Logic;
using VALE.Models;
using System.Web.UI.HtmlControls;

namespace VALE.MyVale
{
    public partial class InterventionDetails : Page
    {
        private string _currentUser;
        private int _currentInterventionId;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();
            _db = new UserOperationsContext();
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString["From"] != null)
                Session["InterventionDetailsRequestFrom"] = Request.QueryString["From"];
            if (Request.QueryString.HasKeys())
                _currentInterventionId = Convert.ToInt32(Request.QueryString["interventionId"]);

            FileUploader.DataActions = new InterventionActions();
            FileUploader.DataId = _currentInterventionId;
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "Progetti"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina InterventionDetails.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public Intervention GetIntervention([QueryString("interventionId")] int? interventionId)
        {
            if (interventionId.HasValue)
                return _db.Interventions.First(i => i.InterventionId == interventionId);
            else
                return null;
        }

        public bool AllowDelete(int attachedFileId)
        {
            var db = new UserOperationsContext();
            var attachedFile = db.AttachedFiles.First(a => a.AttachedFileID == attachedFileId);
            if (HttpContext.Current.User.IsInRole("Amministratore") || HttpContext.Current.User.IsInRole("Membro del consiglio"))
                return true;
            return false;
        }

        public IQueryable<AttachedFile> DocumentsGridView_GetData()
        {
            var actions = new InterventionActions();
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
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
                case "Cancella":
                    var actions = new InterventionActions();
                    actions.RemoveAttachment(id);
                    var DocumentsGridView = (GridView)InterventionDetail.FindControl("DocumentsGridView");
                    DocumentsGridView.PageIndex = 0;
                    DocumentsGridView.DataBind();
                    break;
            }
        }

        private void HideAttchmentBox(string name)
        {
            ListBox list = (ListBox)InterventionDetail.FindControl(name);
            list.Visible = false;
            Label labelAttachment = (Label)InterventionDetail.FindControl("labelAttachment");
            labelAttachment.Visible = false;
            Button btnViewAttchment = (Button)InterventionDetail.FindControl("btnViewDocument");
            btnViewAttchment.Visible = false;
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                var comment = new Comment
                {
                    Date = DateTime.Now,
                    CommentText = txtComment.InnerText,
                    CreatorUserName = _currentUser,
                    InterventionId = _currentInterventionId
                };
                _db.Comments.Add(comment);

                var interventionRelatedProject = _db.Interventions.FirstOrDefault(i => i.InterventionId == _currentInterventionId).RelatedProject;
                if (interventionRelatedProject != null)
                {
                    interventionRelatedProject.LastModified = DateTime.Now;

                    var actions = new ProjectActions();
                    var listHierarchyUp = actions.getHierarchyUp(interventionRelatedProject.ProjectId);
                    if (listHierarchyUp.Count != 0)
                        listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
                }

                _db.SaveChanges();

                grdComments.DataBind();
                txtComment.InnerText = "";
            }
        }

        protected void InterventionDetail_DataBound(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            string result = db.Interventions.First(i => i.InterventionId == _currentInterventionId).InterventionText;
            Label txtDescription = (Label)InterventionDetail.FindControl("txtDescription");
            if (String.IsNullOrEmpty(result))
                txtDescription.Text = "Nessun commento inserito";
            else
                txtDescription.Text = HttpUtility.HtmlDecode(result).ToString();
        }

        protected void deleteComment_Click(int commentId)
        {
            var db = new UserOperationsContext();
            var aCommentRelated = db.Comments.FirstOrDefault(c => c.CommentId == commentId && c.InterventionId == _currentInterventionId);
            var anIntervention = db.Interventions.FirstOrDefault(i => i.InterventionId == _currentInterventionId);
            anIntervention.Comments.Remove(aCommentRelated);
            db.Comments.Remove(aCommentRelated);

            if (anIntervention.RelatedProject != null)
            {
                anIntervention.RelatedProject.LastModified = DateTime.Now;

                var actions = new ProjectActions();
                var listHierarchyUp = actions.getHierarchyUp(anIntervention.ProjectId);
                if (listHierarchyUp.Count != 0)
                    listHierarchyUp.ForEach(p => p.LastModified = DateTime.Now);
            }

            db.SaveChanges();

            grdComments.DataBind();
        }

        protected void btnBack_ServerClick(object sender, EventArgs e)
        {
            string returnUrl = "";
            if (Session["InterventionDetailsRequestFrom"] != null)
            {
                returnUrl = Session["InterventionDetailsRequestFrom"].ToString();
                Session["InterventionDetailsRequestFrom"] = null;
            }
            Response.Redirect(returnUrl);
        }

        public IQueryable<Comment> grdComments_GetData()
        {
            if (_currentInterventionId != 0)
                return _db.Interventions.First(c => c.InterventionId == _currentInterventionId).Comments.OrderBy(o => o.Date).AsQueryable();
            else
                return null;
        }

        protected void grdComments_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i < grdComments.Rows.Count; i++)
            {
                var btnDelete = (LinkButton)grdComments.Rows[i].FindControl("deleteComment");
                var commentId = Convert.ToInt32(btnDelete.CommandArgument.ToString());
                var currentProject = _db.Interventions.FirstOrDefault(c => c.InterventionId == _currentInterventionId).RelatedProject;
                if (HttpContext.Current.User.IsInRole("Amministratore") || HttpContext.Current.User.IsInRole("Membro del Consiglio") || _db.Comments.FirstOrDefault(c => c.CommentId == commentId && c.InterventionId == _currentInterventionId).CreatorUserName == _currentUser || _db.Interventions.FirstOrDefault(co => co.InterventionId == _currentInterventionId).CreatorUserName == _currentUser)
                    btnDelete.Visible = true;
                else
                    btnDelete.Visible = false;
            }
        }

        protected void grdComments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteComment")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                deleteComment_Click(index);
            }
        }

        protected void OpenPopUp_Click(object sender, EventArgs e)
        {
            PopupAddComments.Show();
        }

        protected void ClosePopUp_Click(object sender, EventArgs e)
        {
            txtComment.InnerText = "";
            PopupAddComments.Hide();
        }
    }
}