using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class Articles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public IQueryable<BlogArticle> GetAllArticles()
        {
            var db = new UserOperationsContext();
            return db.BlogArticles;
        }

        public string GetCreatorName(string userId)
        {
            var db = new UserOperationsContext();
            return db.UsersData.First(u => u.UserDataId == userId).FullName;
        }

        protected void grdAllArticles_RowCommand(object sender, GridViewCommandEventArgs e)
        {


            if (e.CommandName == "ViewArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int articleId = Convert.ToInt32(grdAllArticles.Rows[index].Cells[0].Text);
                Response.Redirect("/MyVale/ViewArticle?articleId=" + articleId);
            }
        }
    }
}