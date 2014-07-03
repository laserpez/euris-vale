using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.Logic
{
    public class UserActions : IDisposable
    {
        ApplicationDbContext _db = new ApplicationDbContext();


        public List<ApplicationUser> GetUsers()
        {
            var users = _db.Users.ToList();
            return users;
        }

        public string GetRole(string userId)
        {
            var user = _db.Users.First(u => u.Id == userId);
            if (user.Roles.Count != 0)
            {
                var roleId = user.Roles.First().RoleId;
                var roleName = _db.Roles.FirstOrDefault(o => o.Id == roleId).Name;
                return roleName;
            }
            else
                return "Utente";
        }

        public List<ApplicationUser> GetSortedData(string property, SortDirection direction)
        {
            var result = GetUsers();
            if (property != "Ruolo")
            {
                var param = Expression.Parameter(typeof(ApplicationUser), property);
                var sortBy = Expression.Lambda<Func<ApplicationUser, object>>(Expression.Convert(Expression.Property(param, property), typeof(object)), param);

                if (direction == SortDirection.Descending)
                    result = result.AsQueryable<ApplicationUser>().OrderByDescending(sortBy).ToList();
                else
                    result = result.AsQueryable<ApplicationUser>().OrderBy(sortBy).ToList();
            }
            else
            {
                if (direction == SortDirection.Descending)
                    result = result.AsQueryable<ApplicationUser>().OrderByDescending(u => GetRole(u.Id)).ToList();
                else
                    result = result.AsQueryable<ApplicationUser>().OrderBy(u => GetRole(u.Id)).ToList();
            }

            return result;
        }

        public List<ApplicationUser> GetFilteredData(string ListUsersType)
        {
            List<ApplicationUser> list = new List<ApplicationUser>();
            switch (ListUsersType)
            {
                case "Amministratori":
                    var rolesA = _db.Roles.Where(p => p.Name == "Amministratore").Select(k => k.Id).FirstOrDefault();
                    list = _db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesA).ToList();
                    break;
                case "Soci":
                    var rolesS = _db.Roles.Where(p => p.Name == "Socio").Select(k => k.Id).FirstOrDefault();
                    list = _db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesS).ToList();
                    break;
                case "Membri":
                    var rolesM = _db.Roles.Where(p => p.Name == "Membro del consiglio").Select(k => k.Id).FirstOrDefault();
                    list = _db.Users.Where(o => o.Roles.Select(k => k.RoleId).FirstOrDefault() == rolesM).ToList();
                    break;
                case "Richieste":
                    list = _db.Users.Where(u => u.NeedsApproval == true).ToList();
                    break;
                default:
                    list = _db.Users.ToList();
                    break;
            }
            return list;
        }

        public void CreateAdministrator()
        {
            //var db = new ApplicationDbContext();
            var dbData = new UserOperationsContext();

            var userManager = new ApplicationUserManager(new UserStore<ApplicationUser>(_db));
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
                userManager.AddToRole(adminUser.Id, "Amministratore");
                dbData.UsersData.Add(new UserData 
                { 
                    UserName = adminUser.UserName, 
                    Email = adminUser.Email, 
                    FullName = adminUser.FirstName + " " + adminUser.LastName 
                });
                dbData.SaveChanges();
            }
        }

        public bool ChangeUserRole(string userName, string role)
        {
            IdentityResult IdUserResult;
            //ApplicationDbContext db = new ApplicationDbContext();
            string oldRoleName = "";

            var userManager = new UserManager<ApplicationUser>(new UserStore<ApplicationUser>(new ApplicationDbContext()));
            var appUser = userManager.FindByName(userName);
            var oldRole = appUser.Roles.Select(o => o.RoleId).FirstOrDefault();


            if (oldRole != null)
            {
                oldRoleName = _db.Roles.Where(o => o.Id == oldRole).FirstOrDefault().Name;
                IdUserResult = userManager.RemoveFromRole(appUser.Id, oldRoleName);
                if (!IdUserResult.Succeeded)
                    return false;
            }

            IdUserResult = userManager.AddToRole(appUser.Id, role);
            if (IdUserResult.Succeeded)
                return true;
            else
                return false;
        }

        public void Dispose()
        {
            if (_db != null)
                _db = null;
        }
    }
}