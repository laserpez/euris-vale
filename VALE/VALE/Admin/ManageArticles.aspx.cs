using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
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
            else if (e.CommandName == "DeleteArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var articleId = (int)grdArticleList.DataKeys[index].Value;
                var dbData = new UserOperationsContext();
                ArticleId.Text = articleId.ToString();
                var contentArticle = dbData.BlogArticles.Where(o => o.BlogArticleId == articleId).FirstOrDefault().Content;
                ArticleTitle.Text = contentArticle.Length >= 30 ? contentArticle.Substring(0, 30) + "..." : contentArticle;
                ModalPopup.Show();
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

                var dbData = new UserOperationsContext();
                int Id = Convert.ToInt32(ArticleId.Text);
                var article = dbData.BlogArticles.First(p => p.BlogArticleId == Id);
                var actions = new ArticleActions();

                actions.DeleteArticle(Id);

                //ProjectList.DataSource = (List<Project>)ViewState["lstProject"];
                grdArticleList.DataBind();
                Response.Redirect("/Admin/ManageArticles.aspx");
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