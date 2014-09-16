using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

namespace VALE.Models
{
    public class ValeFile
    {
        public int ValeFileID { get; set; }
        public string FileName { get; set; }
        public string FileDescription { get; set; }
        public string FileExtension { get; set; }
        public int Size { get; set; }
        public byte[] FileData { set; get; }
    }
}
