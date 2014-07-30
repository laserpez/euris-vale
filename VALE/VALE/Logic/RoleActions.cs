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

        public static bool checkPermission(string role, string source)
        {
            var xmlRole = findRole(role);
            switch (source)
            {
                case "Amministrazione":
                    return xmlRole.Amministrazione.Visible;
                case "DocumentiAssociazione":
                    return xmlRole.DocumentiAssociazione.Visible;
                case "Home":
                    return xmlRole.Home.Visible;
                case "ListaUtenti":
                    return xmlRole.ListaUtenti.Visible;
                case "Consiglio":
                    return xmlRole.Consiglio.Visible;
                case "CreazioneConsiglio":
                    return xmlRole.Consiglio.Creation;
                case "Progetti":
                    return xmlRole.Progetti.Visible;
                case "CreazioneProgetti":
                    return xmlRole.Progetti.Creation;
                case "Attivita":
                    return xmlRole.Attivita.Visible;
                case "CreazioneAttivita":
                    return xmlRole.Attivita.Creation;
                case "Eventi":
                    return xmlRole.Eventi.Visible;
                case "CreazioneEventi":
                    return xmlRole.Eventi.Creation;
                case "Articoli":
                    return xmlRole.Articoli.Visible;
                case "CreazioneArticoli":
                    return xmlRole.Articoli.Creation;
                default:
                    return false;

            }
        }

        public static void initializeRole()
        {
            var initRole = new List<XmlRoles>();
            var amministratore = new XmlRoles
            {
                Name = "Amministratore",
                Amministrazione = new SourceVisibleOnly() { Visible = true },

                Consiglio = new Source() { Visible = true, Creation = true },
                Progetti = new Source() { Visible = true, Creation = true },
                Attivita = new Source() { Visible = true, Creation = true },
                Eventi = new Source() { Visible = true, Creation = true },
                Articoli = new Source() { Visible = true, Creation = true },

                ListaUtenti = new SourceVisibleOnly() { Visible = false },
                Home = new SourceVisibleOnly() { Visible = true },
                DocumentiAssociazione = new SourceVisibleOnly() { Visible = true },
            };
            var membroConsiglio = new XmlRoles
            {
                Name = "Membro del consiglio",
                Amministrazione = new SourceVisibleOnly() { Visible = false },

                Consiglio = new Source() { Visible = true, Creation = true },
                Progetti = new Source() { Visible = true, Creation = true },
                Attivita = new Source() { Visible = true, Creation = true },
                Eventi = new Source() { Visible = true, Creation = true },
                Articoli = new Source() { Visible = true, Creation = true },

                ListaUtenti = new SourceVisibleOnly() { Visible = true },
                Home = new SourceVisibleOnly() { Visible = true },
                DocumentiAssociazione = new SourceVisibleOnly() { Visible = true },
            };
            var socio = new XmlRoles
            {
                Name = "Socio",
                Amministrazione = new SourceVisibleOnly() { Visible = false },

                Consiglio = new Source() { Visible = true, Creation = false },
                Progetti = new Source() { Visible = true, Creation = true },
                Attivita = new Source() { Visible = true, Creation = true },
                Eventi = new Source() { Visible = true, Creation = true },
                Articoli = new Source() { Visible = true, Creation = true },

                ListaUtenti = new SourceVisibleOnly() { Visible = true },
                Home = new SourceVisibleOnly() { Visible = true },
                DocumentiAssociazione = new SourceVisibleOnly() { Visible = true },
            };
            var collaboratore = new XmlRoles
            {
                Name = "Collaboratore",
                Amministrazione = new SourceVisibleOnly() { Visible = false },

                Consiglio = new Source() { Visible = false, Creation = false },
                Progetti = new Source() { Visible = true, Creation = false },
                Attivita = new Source() { Visible = true, Creation = true },
                Eventi = new Source() { Visible = true, Creation = true },
                Articoli = new Source() { Visible = true, Creation = true },

                ListaUtenti = new SourceVisibleOnly() { Visible = true },
                Home = new SourceVisibleOnly() { Visible = true },
                DocumentiAssociazione = new SourceVisibleOnly() { Visible = true },
            };
            var utente = new XmlRoles
            {
                Name = "Utente",
                Amministrazione = new SourceVisibleOnly() { Visible = false },

                Consiglio = new Source() { Visible = false, Creation = false },
                Progetti = new Source() { Visible = true, Creation = false },
                Attivita = new Source() { Visible = true, Creation = false },
                Eventi = new Source() { Visible = true, Creation = false },
                Articoli = new Source() { Visible = true, Creation = false },

                ListaUtenti = new SourceVisibleOnly() { Visible = true },
                Home = new SourceVisibleOnly() { Visible = true },
                DocumentiAssociazione = new SourceVisibleOnly() { Visible = true }
            };

            initRole.Add(amministratore);
            initRole.Add(membroConsiglio);
            initRole.Add(socio);
            initRole.Add(collaboratore);
            initRole.Add(utente);

            CreateRoles(initRole);
        }

        public static XmlRoles findRole(string role)
        {
            return ReadRoles().Where(o => o.Name == role).FirstOrDefault();
        }

       
        public static List<XmlRoles> ReadRoles()
        {
            var serializer = new XmlSerializable();
            var listaRuoli = serializer.ReadData<List<XmlRoles>>(File);
            return listaRuoli;
        }

        public static void CreateRoles(List<XmlRoles> dati)
        {
            foreach (var dato in dati)
            {
                CreateDBRole(dato.Name);
                CreateXmlRole(dato);
            }
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

        private static void CreateXmlRole(XmlRoles dato)
        {
            var serializer = new XmlSerializable();
            List<XmlRoles> newData = CheckDataAndRemoveIfExist(dato.Name);
            newData.Add(dato);
            serializer.CreateData<List<XmlRoles>>(newData, File);
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