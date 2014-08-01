using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using VALE.Logic;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace VALE.MyVale
{
    public partial class PersonalArticles : Page
    {
        private string _currentUser;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUser = User.Identity.GetUserName();
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "Articoli"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina PersonalArticles.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
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
                ArticleID.Text = articleId.ToString();
                using (var actions = new ArticleActions())
                {
                    ArticleName.Text = actions.GetTitle(articleId);
                }
                ModalPopup.Show();
            }
        }

        public IQueryable<BlogArticle> GetPersonalArticles()
        {
            using (var actions = new ArticleActions())
            {
                return actions.GetArticles(_currentUser);
            }
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
                using (var actions = new ArticleActions())
                {
                    if (actions.DeleteArticle(Convert.ToInt32(ArticleID.Text)))
                        grdPersonalArticles.DataBind();
                }
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