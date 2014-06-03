using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;

namespace VALE.MyVale.Create
{
    public partial class ArticleCreate : System.Web.UI.Page
    {
        private string _currentUserId;
        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUserId = User.Identity.GetUserId();
            CalendarReleaseDate.StartDate = DateTime.Now;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var article = new BlogArticle
            {
                Title = txtArticleTitle.Text,
                Content = txtArticleContent.Text,
                Status = "pending",
                ReleaseDate = Convert.ToDateTime(txtReleaseDate.Text),
                CreatorId = _currentUserId
            };
            db.BlogArticles.Add(article);
            db.SaveChanges();
            Response.Redirect("/MyVale/Articles");
        }
    }
}