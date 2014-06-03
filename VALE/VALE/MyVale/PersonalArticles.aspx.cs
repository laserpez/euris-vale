using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;

namespace VALE.MyVale
{
    public partial class PersonalArticles : System.Web.UI.Page
    {
        private string _currentUserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
        }

        protected void grdPersonalArticles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int articleId = Convert.ToInt32(grdPersonalArticles.Rows[index].Cells[0].Text);
                Response.Redirect("/MyVale/ViewArticle?articleId=" + articleId);
            }
        }

        public IQueryable<BlogArticle> GetPersonalArticles()
        {
            var db = new UserOperationsContext();
            return db.BlogArticles.Where(a => a.CreatorId == _currentUserId);
        }
    }
}