using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Serialization;

namespace VALE.Logic.Serializable
{
    public class XmlSerializable : ISerializable
    {
        public void SaveData<T>(T dati, string nomeFile)
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

        public void ModifyData<T>(T dati, string nomeFile)
        {
            XmlDocument xml = new XmlDocument();

            XmlNodeList nodeList;

            xml.Load("C:\\Users\\Federico\\Desktop\\EURIS\\ValeProject\\VALE\\VALE\\Logic\\Serializable\\" + nomeFile + ".xml");

            nodeList = xml.DocumentElement.SelectNodes("/Commander"); //DA RIVEDERE

            nodeList.Item(1).ParentNode.RemoveChild(nodeList.Item(1)); //DA RIVEDERE

            xml.Save("C:\\Users\\Federico\\Desktop\\EURIS\\ValeProject\\VALE\\VALE\\Logic\\Serializable\\" + nomeFile + ".xml");
        }
    }
}