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
                    UserDataId = adminUser.Id, 
                    Email = adminUser.Email, 
                    FullName = adminUser.FirstName + " " + adminUser.LastName 
                });
                dbData.SaveChanges();
            }
        }

        //public static string GetUserFullName(string userId)
        //{
        //    var db = new ApplicationDbContext();
        //    var user = db.Users.First(u => u.Id == userId);
        //    return user.FirstName + " " + user.LastName;
        //}
    }
}