using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using VALE.Logic;

namespace VALE.Admin
{
    public partial class ManageArticles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public IQueryable<BlogArticle> GetArticles()
        {
            using (var actions = new ArticleActions())
            {
                return actions.GetArticles();
            }
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

                using (var actions = new ArticleActions())
                {
                    if (actions.ChangeStatus(articleId, newStatus))
                        grdArticleList.DataBind();
                }
            }
        }
    }
}