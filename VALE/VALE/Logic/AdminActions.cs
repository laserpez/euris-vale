using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public static class AdminActions
    {
        public static void ConfirmUser(string userName)
        {
            var db = new ApplicationDbContext();
            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(db));
            var userToConfirm = userManager.FindByName(userName);
            if (userToConfirm != null)
            {
                userToConfirm.NeedsApproval = false;
                userManager.AddToRole(userToConfirm.Id, "AssociatedUser");
            }
            db.SaveChanges();
        }

        public static int GetWaitingUsers()
        {
            var db = new ApplicationDbContext();
            return db.Users.Where(u => u.NeedsApproval == true).Count();
        }

        public static int GetWaitingArticles()
        {
            var db = new UserOperationsContext();
            return db.BlogArticles.Where(b => b.Status == "pending").Count();
        }

    }
}