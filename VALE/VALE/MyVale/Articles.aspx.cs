using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale
{
    public partial class Articles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<BlogArticle> GetAllArticles()
        {
            using (var actions = new ArticleActions())
            {
                return actions.GetArticles();
            }
        }

        protected void grdAllArticles_RowCommand(object sender, GridViewCommandEventArgs e)
        {


            if (e.CommandName == "ViewArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int articleId = Convert.ToInt32(grdAllArticles.DataKeys[index].Value);
                Response.Redirect("/MyVale/ViewArticle?articleId=" + articleId);
            }
        }

        protected void btnAddArticle_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ArticleCreate?From=~/MyVale/Articles");
        }
    }
}