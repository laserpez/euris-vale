using System;
using System.Collections.Generic;
using System.Configuration;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;
using System.Linq;

namespace VALE
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.LogoImageTitle.ImageUrl = ConfigurationManager.AppSettings["LogoVALETitle"];
            if (!HttpContext.Current.User.Identity.IsAuthenticated) 
            {
                adminLink.Visible = false;
                boardLink.Visible = false;
                projectsLink.Visible = false;
                eventsLink.Visible = false;
                activitiesLink.Visible = false;
                //blogsLink.Visible = false;
                UserList.Visible = false;
                loginLink.Visible = false;
                homeLink.Visible = false;
            }
            else
            {
                SetLink();
            }
        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Session.RemoveAll();
            Context.GetOwinContext().Authentication.SignOut();
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            SetNotification();
        }

        private void SetLink()
        {
            var db = new ApplicationDbContext();
            XmlRoles xmlRoles = null;
            var user = db.Users.Where(u => u.UserName == HttpContext.Current.User.Identity.Name).FirstOrDefault();
            if (user != null)
            {
                using (var actions = new UserActions())
                {
                    var roleName = actions.GetRole(user.Id);
                    xmlRoles = RoleActions.findRole(roleName);
                }
            }
            if (xmlRoles != null)
            {
                UserList.Visible = xmlRoles.ListaUtenti.Visible;

                //createBlogArticle.Visible = xmlRoles.Articoli.Creation;
                //blogsLink.Visible = xmlRoles.Articoli.Visible;

                //createEventLink.Visible = xmlRoles.Eventi.Creation;
                eventsLink.Visible = xmlRoles.Eventi.Visible;

                //createActivityLink.Visible = xmlRoles.Attivita.Creation;
                activitiesLink.Visible = xmlRoles.Attivita.Visible;

                //createProjectLink.Visible = xmlRoles.Progetti.Creation;
                projectsLink.Visible = xmlRoles.Progetti.Visible;

                //createBODLink.Visible = xmlRoles.Consiglio.Creation;
                boardLink.Visible = xmlRoles.Consiglio.Visible;

                associationDocuments.Visible = xmlRoles.DocumentiAssociazione.Visible;
                adminLink.Visible = xmlRoles.Amministrazione.Visible;
            }
        }

        public void UpdateNavbar()
        {
            OnPreRender(null);
        }


        private void SetNotification()
        {
            int waitingUsersNotifications = AdminActions.GetWaitingUsers();
            int waitingArticlesNotifications = AdminActions.GetWaitingArticles();
            int totalNotifications = waitingUsersNotifications + waitingArticlesNotifications;
            if (totalNotifications > 0)
                NotificationsAllRequests.InnerText = totalNotifications.ToString();
            else
                NotificationsAllRequests.Visible = false;
            if (waitingUsersNotifications > 0)
                NotificationUsersRequest.InnerText = waitingUsersNotifications.ToString();
            else
                NotificationUsersRequest.Visible = false;
            //if (waitingArticlesNotifications > 0)
            //    NotificationArticlesRequest.InnerText = waitingArticlesNotifications.ToString();
            //else
            //    NotificationArticlesRequest.Visible = false;
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                ActivityActions activityActions = new ActivityActions();
                    int activitiesRequestNotifications = activityActions.GetActivitiesRequest(HttpContext.Current.User.Identity.Name);
                    if (activitiesRequestNotifications > 0)
                        NotificationActivitiesRequest.InnerText = activitiesRequestNotifications.ToString();
                    else
                        NotificationActivitiesRequest.Visible = false;
            }
        }
    }
}