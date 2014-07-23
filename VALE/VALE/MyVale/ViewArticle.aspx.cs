using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class ViewArticle : System.Web.UI.Page
    {
        private string _currentUser;
        private int _articleId;
        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString.HasKeys())
                _articleId = Convert.ToInt32(Request.QueryString.GetValues("articleId").First());
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
                CommentText = txtComment.Text,
                CreatorUserName = _currentUser,
                BlogArticleId = _articleId
            };
            var db = new UserOperationsContext();
            db.BlogComments.Add(comment);
            db.SaveChanges();
            lstComments.DataBind();
            if (!String.IsNullOrEmpty(txtComment.Text))
                txtComment.Text = "";
        }

        public List<BlogComment> GetComments([QueryString("articleId")] int? articleId)
        {
            if (articleId.HasValue)
            {
                var db = new UserOperationsContext();
                return db.BlogComments.Where(c => c.BlogArticleId == articleId).ToList();
            }
            else
                return null;
        }

        protected void deleteComment_Click(object sender, EventArgs e)
        {
            var btnDelete = (Button)sender;
            var blogCommentId = Convert.ToInt32(btnDelete.CommandArgument.ToString());
            var db = new UserOperationsContext();
            var aCommentRelated = db.BlogComments.FirstOrDefault(c => c.BlogCommentId == blogCommentId && c.BlogArticleId == _articleId);
            var anArticle = db.BlogArticles.FirstOrDefault(a => a.BlogArticleId == _articleId);
            anArticle.Comments.Remove(aCommentRelated);
            db.BlogComments.Remove(aCommentRelated);
            db.SaveChanges();

            lstComments.DataBind();
        }

        protected void lstComments_DataBound(object sender, EventArgs e)
        {
            for (int i = 0; i < lstComments.Items.Count; i++)
            {
                var btnDelete = (Button)lstComments.Items[i].FindControl("deleteComment");
                var labelDeleteBtn = (Label)lstComments.Items[i].FindControl("labelDeleteBtn");
                var _blogCommentId = Convert.ToInt32(btnDelete.CommandArgument.ToString());

                var db = new UserOperationsContext();
                var currentArticle = db.BlogArticles.FirstOrDefault(a => a.BlogArticleId == _articleId);
                if (HttpContext.Current.User.IsInRole("Amministratore") || db.BlogComments.FirstOrDefault(c => c.BlogCommentId == _blogCommentId && c.BlogArticleId == _articleId).CreatorUserName == _currentUser || currentArticle.CreatorUserName == _currentUser)
                {
                    labelDeleteBtn.Visible = true;
                    btnDelete.Visible = true;
                }

                var commentText = db.BlogComments.FirstOrDefault(cc => cc.BlogCommentId == _blogCommentId).CommentText;

                var txtCommentDescription = (Label)lstComments.Items[i].FindControl("txtCommentDescription");
                if (String.IsNullOrEmpty(commentText))
                    txtCommentDescription.Text = "Nessun commento inserito";
                else
                    txtCommentDescription.Text = commentText;
            }
        }

    }
}