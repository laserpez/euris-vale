using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    public class ArticleActions : IDisposable
    {
        UserOperationsContext _db = new UserOperationsContext();

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }

        public IQueryable<BlogArticle> GetArticles()
        {
            return _db.BlogArticles;
        }

        public IQueryable<BlogArticle> GetArticles(string userName)
        {
            return _db.BlogArticles.Where(a => a.CreatorUserName == userName);
        }

        public string GetTitle(int articleId)
        {
            return _db.BlogArticles.Where(o => o.BlogArticleId == articleId).FirstOrDefault().Title;
        }

        public bool ChangeStatus(int articleId, string newStatus)
        {
            var article = _db.BlogArticles.First(a => a.BlogArticleId == articleId);
            article.Status = newStatus;
            _db.SaveChanges();
            return true;
        }

        public bool AddComment(BlogComment comment)
        {
            try
            {
                var db = new UserOperationsContext();
                db.BlogComments.Add(comment);
                db.SaveChanges();

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public bool DeleteComment(int articleId, int BlogCommentId)
        {
            try
            {
                var db = new UserOperationsContext();
                var aCommentRelated = db.BlogComments.FirstOrDefault(c => c.BlogCommentId == BlogCommentId && c.BlogArticleId == articleId);
                var anArticle = db.BlogArticles.FirstOrDefault(a => a.BlogArticleId == articleId);
                anArticle.Comments.Remove(aCommentRelated);
                db.BlogComments.Remove(aCommentRelated);
                db.SaveChanges();

                return true;
            }
            catch
            {
                return false;
            }
        }

        public bool DeleteArticle(int articleId)
        {
            try
            {
                var article = _db.BlogArticles.First(a => a.BlogArticleId == articleId);
                _db.BlogComments.RemoveRange(article.Comments);
                _db.BlogArticles.Remove(article);
                _db.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}