using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace VALE.MyVale
{
    public partial class PersonalArticles : System.Web.UI.Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            _currentUser = User.Identity.GetUserName();
        }

        protected void grdPersonalArticles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int articleId = (int)grdPersonalArticles.DataKeys[index].Value;
                Response.Redirect("/MyVale/ViewArticle?articleId=" + articleId);
            }
            if (e.CommandName == "DeleteArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var articleId = (int)grdPersonalArticles.DataKeys[index].Value;
                var dbData = new UserOperationsContext();
                ArticleID.Text = articleId.ToString();
                ArticleName.Text = dbData.BlogArticles.Where(o => o.BlogArticleId == articleId).FirstOrDefault().Title;
                ModalPopup.Show();
            }
        }

        public IQueryable<BlogArticle> GetPersonalArticles()
        {
            var db = new UserOperationsContext();
            return db.BlogArticles.Where(a => a.CreatorUserName == _currentUser);
        }

        protected void CloseButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = manager.Find(User.Identity.Name, PassTextBox.Text);
            if (user != null)
            {

                var dbData = new UserOperationsContext();
                int Id = Convert.ToInt32(ArticleID.Text);
                var article = dbData.BlogArticles.First(a => a.BlogArticleId == Id);
                dbData.BlogArticles.Remove(article);
                dbData.SaveChanges();
                Response.Redirect("/MyVale/PersonalArticles.aspx");
            }
            else
            {
                ErrorDeleteLabel.Visible = true;
                ErrorDeleteLabel.Text = "Password sbagliata";
                ModalPopup.Show();
            }
        }
    }
}