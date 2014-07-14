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

        public static void LoadRoles()
        {
            var serializer = new XmlSerializable();
            var listaRuoli = serializer.ReadData<List<XmlRoles>>("Ruoli");
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
            CreateXmlRoles(dato, File);
        }


        public static void DeleteRole(string nomeDato)
        {
            DeleteDBRole(nomeDato);
            DeleteXmlRole(nomeDato, File);
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

        private static void CreateXmlRoles(XmlRoles dato, string nomeFile)
        {
            var serializer = new XmlSerializable();
            List<XmlRoles> dati = CheckDataAndRemoveIfExist(dato.Name, nomeFile);
            dati.Add(dato);

            serializer.CreateData<List<XmlRoles>>(dati, nomeFile);
        }

        private static void DeleteDBRole(string roleName)
        {
            var db = new ApplicationDbContext();

            var roleStore = new RoleStore<IdentityRole>(db);
            var roleManager = new RoleManager<IdentityRole>(roleStore);

            if (roleManager.RoleExists(roleName))
            {
                
                roleManager.Delete(db.Roles.Where(o => o.Name == roleName).FirstOrDefault());
            }
        }

        private static void DeleteXmlRole(string nomeDato, string nomeFile)
        {
            var serializer = new XmlSerializable();
            List<XmlRoles> dati = CheckDataAndRemoveIfExist(nomeDato, nomeFile);

            serializer.CreateData<List<XmlRoles>>(dati, nomeFile);
        }

        private static List<XmlRoles> CheckDataAndRemoveIfExist(string nomeDato, string nomeFile)
        {
            var serializer = new XmlSerializable();
            List<XmlRoles> dati = serializer.ReadData<List<XmlRoles>>(nomeFile);
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