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

    }
}