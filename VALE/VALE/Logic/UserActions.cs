using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public static class UserActions
    {
        public static void CreateAdministrator()
        {
            var db = new ApplicationDbContext();
            var dbData = new UserOperationsContext();

            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(db));
            var adminUser = new ApplicationUser
            {
                UserName = "Admin",
                FirstName = "Amministratore",
                LastName = "Capo",
                Email = "admin@vale.org"
            };
            if (userManager.Find("Admin", "Pa$$word") == null)
            {
                userManager.Create(adminUser, "Pa$$word");
                userManager.AddToRole(adminUser.Id, "Administrator");
                userManager.AddToRole(adminUser.Id, "AssociatedUser");
                dbData.UsersData.Add(new UserData 
                { 
                    UserName = adminUser.UserName, 
                    Email = adminUser.Email, 
                    FullName = adminUser.FirstName + " " + adminUser.LastName 
                });
                dbData.SaveChanges();
            }
        }

        public static string ChangeUserRole(string userName, string role)
        {
            IdentityResult IdUserResult;
            ApplicationDbContext db = new ApplicationDbContext();
            string oldRoleName = "";

            var userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var appUser = userManager.FindByName(userName);
            var oldRole = appUser.Roles.Select(o => o.RoleId).FirstOrDefault();


            if (oldRole != null)
            {
                oldRoleName = db.Roles.Where(o => o.Id == oldRole).FirstOrDefault().Name;
                IdUserResult = userManager.RemoveFromRole(appUser.Id, oldRoleName);
                if (!IdUserResult.Succeeded)
                    return "Impossibile eliminarlo dal vecchio ruolo.";
            }

            IdUserResult = userManager.AddToRole(appUser.Id, role);
            if (IdUserResult.Succeeded)
               return "Ruolo di " + appUser.UserName + " modificato in " + role + ".";
            else
                return "Errore nella modifica dell'utente " + appUser.UserName + ".";

        }

        //public static string GetUserFullName(string userId)
        //{
        //    var db = new ApplicationDbContext();
        //    var user = db.Users.First(u => u.Id == userId);
        //    return user.FirstName + " " + user.LastName;
        //}
    }
}