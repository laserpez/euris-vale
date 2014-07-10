using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace VALE.Models
{
    [Serializable]
    public class ProjectType
    {
        public int ProjectTypeId { get; set; }
        public string ProjectTypeName { get; set; }
        public string Description { get; set; }
        public DateTime CreationDate { get; set; }
        
        public override bool Equals(object obj)
        {
            var projectType = (ProjectType)obj;
            return this.ProjectTypeId == projectType.ProjectTypeId;
        }

        public override int GetHashCode()
        {
            return ProjectTypeId.GetHashCode();
        }
    }
}