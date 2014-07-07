using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace VALE.StateInfo
{
    public class StateInfoXML
    {
        private static StateInfoXML _instance = null;
        private StateInfo _stateInfo = null;
        public string FileName { get; set; }
        private StateInfoXML()
        {
        }
        public List<Item> LoadData()
        {
            if(_stateInfo != null)
                return _stateInfo.Items.ToList();
            try
            {
                using (FileStream stream = new FileStream(FileName, FileMode.OpenOrCreate))
                {
                    XmlSerializer serializer = new XmlSerializer(typeof(StateInfo));
                    _stateInfo = (StateInfo)serializer.Deserialize(stream);
                }
            }
            catch
            {
                return null;
            }
            return _stateInfo.Items.ToList();
        }

        public static StateInfoXML GetInstance() 
        {
            if(_instance == null)
                _instance = new StateInfoXML();
            return _instance;
           
        }
    }

    public class StateInfo
    {
        public Item[] Items { get; set; }
    }

    public class Item
    {
        public string tid { get; set; }
        public string vid { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public string weight { get; set; }
        public string language { get; set; }
        public string trid { get; set; }
        public string depth { get; set; }
        public string parent { get; set; }
    }
}