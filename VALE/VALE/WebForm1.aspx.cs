using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private UserOperationsContext _db = new UserOperationsContext();
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            var project = _db.Projects.FirstOrDefault(p => p.ProjectId == 1);
            if (project != null)
            {
                TreeView1.Nodes.Add(new TreeNode { Text = "Progetto Correlato" });
            }
        }

        protected void TreeView1_TreeNodePopulate(object sender, TreeNodeEventArgs e)
        {
            
        }

        private TreeNode PopulateNode(Project project) 
        {
            TreeNode projectNode = new TreeNode();
            projectNode.Text = project.ProjectName;
            return null;
            
        }

    }
}