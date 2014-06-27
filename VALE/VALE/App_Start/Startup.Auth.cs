using System;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.DataProtection;
using Owin;
using VALE.Models;
using Owin.Security.Providers.LinkedIn;

namespace VALE
{
    public partial class Startup {

        // For more information on configuring authentication, please visit http://go.microsoft.com/fwlink/?LinkId=301883
        public void ConfigureAuth(IAppBuilder app)
        {
            // Configure the db context and user manager to use a single instance per request
            app.CreatePerOwinContext(ApplicationDbContext.Create);
            app.CreatePerOwinContext<ApplicationUserManager>(ApplicationUserManager.Create);

            // Enable the application to use a cookie to store information for the signed in user
            // and to use a cookie to temporarily store information about a user logging in with a third party login provider
            // Configure the sign in cookie
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Account/Login"),
                Provider = new CookieAuthenticationProvider
                {
                    OnValidateIdentity = SecurityStampValidator.OnValidateIdentity<ApplicationUserManager, ApplicationUser>(
                        validateInterval: TimeSpan.FromMinutes(20),
                        regenerateIdentity: (manager, user) => user.GenerateUserIdentityAsync(manager))
                }
            });
            // Use a cookie to temporarily store information about a user logging in with a third party login provider
            app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

            // Uncomment the following lines to enable logging in with third party login providers
            //app.UseMicrosoftAccountAuthentication(
            //    clientId: "",
            //    clientSecret: "");

            app.UseTwitterAuthentication(
               consumerKey: "sLEyuwaGlmXM8RUHS89CZRfT7",
               consumerSecret: "pNWVxCO1czPNZMqm0SrWBJMm1DLKbcCnfN4BSN8MKOosjJYU8l");

            app.UseFacebookAuthentication(
               appId: "118117908209695",
               appSecret: "a2e4118519467d2c2b71f2463ee66e46");

            //todo non funziona perchè correntemente linkedin ha cambiato la modalità interna di autenticazione
            //app.UseLinkedInAuthentication("77g75e4c2jf81d", "3pBhpjoaXTgB9xSa");

            app.UseGoogleAuthentication();
        }
    }
}
