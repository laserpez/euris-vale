using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Logic.Serializable;
using VALE.Models;

namespace VALE.Logic
{
    public static class RoleActions
    {

        public static void CreateRole(string roleName)
        {
            var db = new ApplicationDbContext();

            var roleStore = new RoleStore<IdentityRole>(db);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            if (!roleManager.RoleExists(roleName))
            {
                roleManager.Create(new IdentityRole(roleName));
            }
        }

        public static void LoadRoles()
        {
            var serializer = new XmlSerializable();
            var listaRuoli = serializer.ReadData<List<XmlRoles>>("Ruoli");
            if (listaRuoli != null)
            {
                foreach (var ruolo in listaRuoli)
                {
                    CreateRole(ruolo.Name);
                }
            }
        }

        public static void DeleteRole(string roleName)
        {
            var db = new ApplicationDbContext();

            var roleStore = new RoleStore<IdentityRole>(db);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            if (roleManager.RoleExists(roleName))
            {
                
                roleManager.Delete(db.Roles.Where(o => o.Name == roleName).FirstOrDefault());
            }
        }
    }
}