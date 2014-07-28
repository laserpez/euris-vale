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
        public static string File { get; set; }

        public static bool checkPermission(string role, string page)
        {
            switch (page)
            {
                case "":
                    break;
                default:
                    break;

            }
            return false;
        }

        public static XmlRoles findRole(string role, string nomeFile)
        {
            return ReadRoles().Where(o => o.Name == role).FirstOrDefault();
        }

       
        public static List<XmlRoles> ReadRoles()
        {
            var serializer = new XmlSerializable();
            var listaRuoli = serializer.ReadData<List<XmlRoles>>(File);
            return listaRuoli;
        }

       
        public static void LoadRoles()
        {
            var listaRuoli = ReadRoles();
            if (listaRuoli != null)
            {
                foreach (var ruolo in listaRuoli)
                {
                    CreateDBRole(ruolo.Name);
                }
            }
        }

        public static void CreateRole(XmlRoles dato)
        {
            CreateDBRole(dato.Name);
            CreateXmlRoles(dato);
        }


        public static void DeleteRole(string nomeDato)
        {
            DeleteDBRole(nomeDato);
            DeleteXmlRole(nomeDato);
        }

        private static void CreateDBRole(string roleName)
        {
            var db = new ApplicationDbContext();

            var roleStore = new RoleStore<IdentityRole>(db);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            if (!roleManager.RoleExists(roleName))
            {
                roleManager.Create(new IdentityRole(roleName));
            }
        }


        private static void CreateXmlRoles(XmlRoles dato)
        {
            var serializer = new XmlSerializable();
            List<XmlRoles> dati = CheckDataAndRemoveIfExist(dato.Name);
            dati.Add(dato);
            serializer.CreateData<List<XmlRoles>>(dati, File);
        }

        private static void DeleteDBRole(string roleName)
        {
            var db = new ApplicationDbContext();

            var userAction= new UserActions();
            var roleStore = new RoleStore<IdentityRole>(db);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            var users = db.Users.Where(u => u.Roles.Select(ro => ro.RoleId).FirstOrDefault() == db.Roles.Where(r => r.Name == roleName).Select(i => i.Id).FirstOrDefault());

            foreach (var user in users)
            {
                userAction.ChangeUserRole(user.UserName, "Utente");
            }
            if (roleManager.RoleExists(roleName))
            {
                roleManager.Delete(db.Roles.Where(o => o.Name == roleName).FirstOrDefault());
            }
        }


        private static void DeleteXmlRole(string nomeDato)
        {
            var serializer = new XmlSerializable();
            List<XmlRoles> dati = CheckDataAndRemoveIfExist(nomeDato);

            serializer.CreateData<List<XmlRoles>>(dati, File);
        }

        private static List<XmlRoles> CheckDataAndRemoveIfExist(string nomeDato)
        {

            List<XmlRoles> dati = ReadRoles();
            if (dati == null)
                dati = new List<XmlRoles>();
            else
            {
                var dataInXmlFile = dati.Find(o => o.Name == nomeDato);
                if (dataInXmlFile != null)
                    dati.Remove(dataInXmlFile);
            }

            return dati;
        }
    }
}