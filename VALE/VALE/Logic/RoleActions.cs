﻿using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using VALE.Models;

namespace VALE.Logic
{
    public static class RoleActions
    {
        private static void CreateRole(string roleName)
        {
            var db = new ApplicationDbContext();

            var roleStore = new RoleStore<IdentityRole>(db);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            if (!roleManager.RoleExists(roleName))
            {
                roleManager.Create(new IdentityRole(roleName));
            }
        }

        private static void CreateAdministratorRole()
        {
            CreateRole("Amministratore");
        }

        private static void CreateAssociatedUserRole()
        {
            CreateRole("Socio");
        }

        private static void CreateBoardMemberRole()
        {
            CreateRole("Membro del consiglio");
        }

        public static void CreateRoles()
        {
            CreateAdministratorRole();
            CreateAssociatedUserRole();
            CreateBoardMemberRole();
        }
    }
}