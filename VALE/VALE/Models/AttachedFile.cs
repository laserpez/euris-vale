using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class AttachedFile
    {
        public int AttachedFileID { get; set; }
        public string FileName { get; set; }
        public string FileExtension { get; set; }
        public DateTime CreationDate { get; set; }
        public string Owner { get; set; }
        public byte[] FileData { set; get; }
    }
}