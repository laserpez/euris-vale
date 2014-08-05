using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class ViewArticle : System.Web.UI.Page
    {
        private string _currentUser;
        private int _articleId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString.HasKeys())
                _articleId = Convert.ToInt32(Request.QueryString.GetValues("articleId").First());
            if (Request.QueryString["From"] != null)
                Session["ArticlesDetailsRequestFrom"] = Request.QueryString["From"];
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Articoli"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ActivityCreate.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        public BlogArticle GetArticle([QueryString("articleId")] int? articleId)
        {
            var db = new UserOperationsContext();
            return db.BlogArticles.First(b => b.BlogArticleId == articleId);
        }

        protected void Unnamed_DataBound(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            string result = db.BlogArticles.First(b => b.BlogArticleId == _articleId).Content;
            Label lblContent = (Label)frmArticle.FindControl("lblContent");
            lblContent.Text = result;
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            var comment = new BlogComment
            {
                Date = DateTime.Now,
                CommentText = txtComment.InnerText,
                CreatorUserName = _currentUser,
                BlogArticleId = _articleId
            };

            var actions = new ArticleActions();
            if (actions.AddComment(comment))
            {
                grdBlogComments.DataBind();
                if (!String.IsNullOrEmpty(txtComment.InnerText))
                    txtComment.InnerText = "";

                Response.Redirect("/MyVale/ViewArticle?articleId=" + _articleId);
            }
        }

        protected void deleteComment_Click(int blogCommentId)
        {
            var actions = new ArticleActions();
            if (actions.DeleteComment(_articleId, blogCommentId))
            {
                grdBlogComments.PageIndex = 0;
                grdBlogComments.DataBind();
            }
        }

        public IQueryable<BlogComment> grdBlogComments_GetData()
        {
            if (_articleId != 0)
            {
                var db = new UserOperationsContext();
                return db.BlogComments.Where(c => c.BlogArticleId == _articleId).OrderBy(b => b.Date).AsQueryable();
            }
            else
                return null;
        }

        protected void grdBlogComments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteComment")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                deleteComment_Click(index);
            }
        }

        protected void grdBlogComments_DataBound(object sender, EventArgs e)
        {
            var _db = new UserOperationsContext();

            for (int i = 0; i < grdBlogComments.Rows.Count; i++)
            {
                var btnDelete = (LinkButton)grdBlogComments.Rows[i].FindControl("deleteComment");
                var blogCommentId = Convert.ToInt32(btnDelete.CommandArgument.ToString());
                if (RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Amministrazione") || RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneConsiglio") || _db.BlogComments.FirstOrDefault(c => c.BlogCommentId == blogCommentId && c.RelatedArticle.BlogArticleId == _articleId).CreatorUserName == _currentUser || _db.BlogComments.FirstOrDefault(co => co.BlogCommentId == blogCommentId).CreatorUserName == _currentUser)
                    btnDelete.Visible = true;
                else
                    btnDelete.Visible = false;
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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            string returnUrl = "";
            if (Session["ArticlesDetailsRequestFrom"] != null)
            {
                returnUrl = Session["ArticlesDetailsRequestFrom"].ToString();
                Session["ArticlesDetailsRequestFrom"] = null;
            }
            Response.Redirect(returnUrl);
        }

    }
}