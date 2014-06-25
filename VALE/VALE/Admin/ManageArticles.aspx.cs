using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Admin
{
    public partial class ManageArticles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<BlogArticle> GetArticles()
        {
            var db = new UserOperationsContext();
            return db.BlogArticles;
        }

        protected void grdArticleList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
            if(e.CommandName == "ViewArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int articleId = (int)grdArticleList.DataKeys[index].Value;
                Response.Redirect("/MyVale/ViewArticle?articleId=" + articleId);
            }
            else if(e.CommandName == "AcceptArticle" || e.CommandName == "RejectArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int articleId = (int)grdArticleList.DataKeys[index].Value;
                string newStatus = e.CommandName == "AcceptArticle" ? "accepted" : "rejected";
                var db = new UserOperationsContext();
                var article = db.BlogArticles.First(a => a.BlogArticleId == articleId);
                article.Status = newStatus;
                db.SaveChanges();
                grdArticleList.DataBind();
                // Reload the page.
                string pageUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.Count() - Request.Url.Query.Count());
                Response.Redirect(pageUrl);
            }
        }
    }
}