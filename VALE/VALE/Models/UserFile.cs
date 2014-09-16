using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class UserFile
    {
        public int UserFileID { get; set; }
        public string UserName { get; set; }
        public string FileName { get; set; }
        public string FileDescription { get; set; }
        public string FileExtension { get; set; }
        public int Size { get; set; }
        public bool IsPublic { get; set; }
        public byte[] FileData { set; get; }
    }
}