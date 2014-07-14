using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Serialization;
using VALE.Models;

namespace VALE.Logic.Serializable
{
    public class XmlSerializable : ISerializable
    {

        public void CreateData<T>(T dati, string nomeFile)
        {
            XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
            xmlWriterSettings.Indent = true;
            using (FileStream file = new FileStream("C:\\Users\\Federico\\Desktop\\EURIS\\ValeProject\\VALE\\VALE\\Logic\\Serializable\\"+nomeFile + ".xml", FileMode.Create))
            {
                XmlSerializer serializer = new XmlSerializer(typeof(T));
                using (XmlWriter xmlWriter = XmlWriter.Create(file, xmlWriterSettings))
                {
                    serializer.Serialize(xmlWriter, dati);
                }
            }
        }

        public T ReadData<T>(string nomeFile)
        {
            T data = default(T);
            try
            {
                using (FileStream stream = new FileStream("C:\\Users\\Federico\\Desktop\\EURIS\\ValeProject\\VALE\\VALE\\Logic\\Serializable\\" + nomeFile + ".xml", FileMode.OpenOrCreate))
                {
                    XmlSerializer serializer = new XmlSerializer(typeof(T));
                    data = (T)serializer.Deserialize(stream);
                }
            }
            catch
            {
                return data;
            }
            return data;
        }

        public void AddRoleData(XmlRoles dato, string nomeFile)
        {
            RoleActions.CreateRole(dato.Name);
            List<XmlRoles> dati = CheckDataAndRemoveIfExist(dato.Name, nomeFile);
            dati.Add(dato);

            CreateData<List<XmlRoles>>(dati, nomeFile);
        }

        public void RemoveRoleFromData(string nomeDato, string nomeFile)
        {
            RoleActions.DeleteRole(nomeDato);
            List<XmlRoles> dati = CheckDataAndRemoveIfExist(nomeDato, nomeFile);

            CreateData<List<XmlRoles>>(dati, nomeFile);
        }

        private List<XmlRoles> CheckDataAndRemoveIfExist(string nomeDato, string nomeFile)
        {
            List<XmlRoles> dati = ReadData<List<XmlRoles>>(nomeFile);
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