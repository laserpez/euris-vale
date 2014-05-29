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

        public string GetCreatorName(string userId)
        {
            var db = new UserOperationsContext();
            return db.UsersData.First(u => u.UserDataId == userId).FullName;

        }

        public IQueryable<BlogArticle> GetArticles()
        {
            var db = new UserOperationsContext();
            return db.BlogArticles;
        }

        protected void grdArticleList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int articleId = Convert.ToInt32(grdArticleList.Rows[index].Cells[0].Text);
            if(e.CommandName == "ViewArticle")
            {
                Response.Redirect("/MyVale/ViewArticle?articleId=" + articleId);
            }
            else if(e.CommandName == "AcceptArticle" || e.CommandName == "RejectArticle")
            {
                string newStatus = e.CommandName == "AcceptArticle" ? "accepted" : "rejected";
                var db = new UserOperationsContext();
                var article = db.BlogArticles.First(a => a.BlogArticleId == articleId);
                article.Status = newStatus;
                db.SaveChanges();
                grdArticleList.DataBind();
            }
        }
    }
}