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
    public partial class Articles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PagePermission();

        }

        public IQueryable<BlogArticle> GetAllArticles()
        {
            using (var actions = new ArticleActions())
            {
                return actions.GetArticles();
            }
        }

        public void PagePermission()
        {
            var userAction = new UserActions();
            string role = userAction.GetRolebyUserName(HttpContext.Current.User.Identity.Name);
            if (!RoleActions.checkPermission(role, "Articoli"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina Articles.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
        }

        protected void grdAllArticles_RowCommand(object sender, GridViewCommandEventArgs e)
        {


            if (e.CommandName == "ViewArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                int articleId = Convert.ToInt32(grdAllArticles.DataKeys[index].Value);
                Response.Redirect("/MyVale/ViewArticle?articleId=" + articleId + "&From=~/MyVale/Articles");
            }
            else if (e.CommandName == "DeleteArticle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var articleId = (int)grdAllArticles.DataKeys[index].Value;
                DeleteThisArticle(articleId);
            }
        }

        private void DeleteThisArticle(int articleId)
        {
            if (articleId != 0)
            {

                var dbData = new UserOperationsContext();
                var article = dbData.BlogArticles.First(p => p.BlogArticleId == articleId);
                var actions = new ArticleActions();

                actions.DeleteArticle(articleId);

                grdAllArticles.DataBind();
                Response.Redirect("/MyVale/Articles.aspx");
            }
        }

        protected void btnAddArticle_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MyVale/Create/ArticleCreate?From=~/MyVale/Articles");
        }

        protected void grdAllArticles_RowCreated(object sender, GridViewRowEventArgs e)
        {
            var db = new UserOperationsContext();
            DataControlField dataControlField = grdAllArticles.Columns.Cast<DataControlField>().SingleOrDefault(x => x.HeaderText == "DELETE ROW");
            for (int i = 0; i < grdAllArticles.Rows.Count; i++)
            {
                int articleId = Convert.ToInt32(grdAllArticles.DataKeys[i].Value);
                var articleCreator = db.BlogArticles.First(art => art.BlogArticleId == articleId).CreatorUserName;
                if (HttpContext.Current.User.IsInRole("Amministratore") || HttpContext.Current.User.IsInRole("Membro del Consiglio") || articleCreator == HttpContext.Current.User.Identity.Name)
                {
                    dataControlField.Visible = true;
                    Button btnDeleteArticle = (Button)grdAllArticles.Rows[i].FindControl("btnDeleteArticle");
                    btnDeleteArticle.Visible = true;
                }
                else if (articleCreator != HttpContext.Current.User.Identity.Name)
                {
                    dataControlField.Visible = true;
                    Button btnDeleteArticle = (Button)grdAllArticles.Rows[i].FindControl("btnDeleteArticle");
                    btnDeleteArticle.Visible = true;
                    btnDeleteArticle.Enabled = false;
                }
            }
        }
    }
}