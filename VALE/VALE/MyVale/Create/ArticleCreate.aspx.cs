using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Models;
using VALE.Logic;

namespace VALE.MyVale.Create
{
    public partial class ArticleCreate : Page
    {
        private string _currentUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
                PagePermission();
            _currentUser = User.Identity.GetUserName();
            CalendarReleaseDate.StartDate = DateTime.Now;
            if (!IsPostBack) 
            {
                if (Request.QueryString["From"] != null)
                    Session["ArticleCreateRequestFrom"] = Request.QueryString["From"];
            }
        }

        public void PagePermission()
        {
            if (!RoleActions.checkPermission(HttpContext.Current.User.Identity.Name, "CreazioneArticoli"))
            {

                string titleMessage = "PERMESSO NEGATO";
                string message = "Non hai i poteri necessari per poter visualizzare la pagina ArticleCreate.";
                Response.Redirect("~/MessagePage.aspx?TitleMessage=" + titleMessage + "&Message=" + message);
            }
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
                CreatorUserName = _currentUser
            };
            db.BlogArticles.Add(article);
            db.SaveChanges();
            if (Session["ArticleCreateRequestFrom"] != null)
            {
                var url = Session["ArticleCreateRequestFrom"].ToString();
                Session["ArticleCreateRequestFrom"] = null;
                Response.Redirect(url);
            }
            Response.Redirect("~/MyVale/Articles");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

            if (Session["ArticleCreateRequestFrom"] != null)
            {
                var url = Session["ArticleCreateRequestFrom"].ToString();
                Session["ArticleCreateRequestFrom"] = null;
                Response.Redirect(url);
            }
            Response.Redirect("~/MyVale/Articles");
        }
    }
}