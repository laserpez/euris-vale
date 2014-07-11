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

            
            //List<XmlRoles> list = ReadData<List<XmlRoles>>(nomeFile);
            //bool condition = false;

            //foreach (var elem in list)
            //    if (elem.Name == dati.Name)
            //        condition = true;

            //if (condition)
            //{
            //    SaveData<XmlRoles>(dati,nomeFile);
            //}
            //else
            //{
            //    list.Add(dati);

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

        public void AddRoleData(XmlRoles dati, string nomeFile)
        {
            List<XmlRoles> list = ReadData<List<XmlRoles>>(nomeFile);
            if (list == null)
                list = new List<XmlRoles>();
            list.Add(dati);

            XmlWriterSettings xmlWriterSettings = new XmlWriterSettings();
            xmlWriterSettings.Indent = true;
            using (FileStream file = new FileStream("C:\\Users\\Federico\\Desktop\\EURIS\\ValeProject\\VALE\\VALE\\Logic\\Serializable\\" + nomeFile + ".xml", FileMode.Create))
            {
                XmlSerializer serializer = new XmlSerializer(typeof(List<XmlRoles>));
                using (XmlWriter xmlWriter = XmlWriter.Create(file, xmlWriterSettings))
                {
                    serializer.Serialize(xmlWriter, list);
                }
            }

        }

        public void SaveData<T>(T dati, string nomeFile)
        {
            XmlDocument xml = new XmlDocument();

            XmlNodeList nodeList;

            XmlNode unicNode;

            nodeList = xml.DocumentElement.SelectNodes("/Commander"); //DA RIVEDERE

            xml.Load("C:\\Users\\Federico\\Desktop\\EURIS\\ValeProject\\VALE\\VALE\\Logic\\Serializable\\" + nomeFile + ".xml");

            //foreach (XmlNode node1 in nodeList.ChildNodes)
            //    foreach (XmlNode node2 in node1.ChildNodes)
            //        if (node2.Name == "price")
            //        {
            //            Decimal price = Decimal.Parse(node2.InnerText);
            //            // Increase all the book prices by 20%
            //            String newprice = ((Decimal)price * (new Decimal(1.20))).ToString("#.00");
            //            Console.WriteLine("Old Price = " + node2.InnerText + "\tNew price = " + newprice);
            //            node2.InnerText = newprice;
            //        }



            //nodeList.Item(1).ParentNode.RemoveChild(nodeList.Item(1)); //DA RIVEDERE

            //unicNode.AppendChild()

            xml.Save("C:\\Users\\Federico\\Desktop\\EURIS\\ValeProject\\VALE\\VALE\\Logic\\Serializable\\" + nomeFile + ".xml");
        }
    }
}