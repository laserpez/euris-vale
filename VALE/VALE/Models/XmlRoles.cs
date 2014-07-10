using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    public class XmlRoles
    {
        public string Name { get; set; }
        public SourceVisibleOnly Amministrazione { get; set; }
        public SourceVisibleOnly DocumentiAssociazione { get; set; }
        public SourceVisibleOnly Home { get; set; }
        public Source Consiglio { get; set; }
        public Source Progetti { get; set; }
        public Source Attivita { get; set; }
        public Source Eventi { get; set; }
        public Source Articoli { get; set; }
        public Source ListaUtenti { get; set; }
    }

    public class Source
    {
        public bool Visible { get; set; }
        public bool Creation { get; set; }
    }

    public class SourceVisibleOnly
    {
        public bool Visible { get; set; }
    }
}