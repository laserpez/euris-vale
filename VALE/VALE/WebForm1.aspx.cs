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
                TreeView1.Nodes.Clear();
                TreeView1.Nodes.Add(PopulateProjectNode(project));
            }
        }

        private TreeNode PopulateActivityNode(Activity activity)
        {
            return new TreeNode { Text = activity.ActivityName };
        }

        private TreeNode PopulateEventNode(Event Event)
        {
            return new TreeNode { Text = Event.Name };
        }

        private TreeNode PopulateProjectNode(Project project) 
        {
            var projectNode = new TreeNode { Text = project.ProjectName };
            var relatedProjectNode = new TreeNode { Text = "Progetto Correlato" };
            if (project.RelatedProject != null)
                relatedProjectNode.ChildNodes.Add(PopulateProjectNode(project.RelatedProject));
            var activitiesNode = new TreeNode { Text = "Attività" };
            project.Activities.ForEach(a => activitiesNode.ChildNodes.Add(PopulateActivityNode(a)));
            var eventsNode = new TreeNode { Text = "Eventi" };
            project.Events.ForEach(ev => eventsNode.ChildNodes.Add(PopulateEventNode(ev)));
            projectNode.ChildNodes.Add(activitiesNode);
            projectNode.ChildNodes.Add(eventsNode);
            projectNode.ChildNodes.Add(relatedProjectNode);
            return projectNode;
            
        }

    }
}