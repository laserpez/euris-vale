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
        public static void ConfirmUser(string userId)
        {
            var db = new ApplicationDbContext();
            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(db));
            var userToConfirm = userManager.FindById(userId);
            if (userToConfirm != null)
            {
                userToConfirm.NeedsApproval = false;
                userManager.AddToRole(userToConfirm.Id, "AssociatedUser");
            }
            db.SaveChanges();
        }

    }
}