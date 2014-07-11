using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE.MyVale.Create
{
    public partial class SelectProject : System.Web.UI.UserControl
    {
        public TextBox ProjectNameTextBox 
        {
            get { return txtProjectName; }  
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSearchProject_Click(object sender, EventArgs e)
        {
            var dbData = new UserOperationsContext();
            string projectName = txtProjectName.Text;
            Project project = dbData.Projects.FirstOrDefault(p => p.ProjectName == projectName);
            if (project != null)
            {
                //lblResultSearchProject.Text = String.Format("Questo evento è correlato al progetto {0}", txtProjectName.Text);
                //btnSearchProject.CssClass = "btn btn-success";
            }
            else
            {
                //lblResultSearchProject.Text = "Il progetto non esiste";
                //btnSearchProject.CssClass = "btn btn-warning";
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void btnShowPopup_Click(object sender, EventArgs e)
        {
            ModalPopup.Show();
        }

        public IQueryable<Project> GetProjects()
        {
            var _db = new UserOperationsContext();
            return _db.Projects.Where(pr => pr.Status != "Chiuso").OrderBy(p => p.ProjectName);
        }

        protected void btnChooseProject_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            txtProjectName.Text = btn.CommandArgument;
            //DisableControl(txtProjectName.Text);
        }

        public void DisableControl(string projectName)
        {
            txtProjectName.Text = projectName;
            txtProjectName.Enabled = false;
            btnShowPopup.Enabled = false;
        }

        protected void OpenedProjectList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            for (int i = 0; i < OpenedProjectList.Rows.Count; i++)
            {
                int projectId = (int)OpenedProjectList.DataKeys[i].Value;
                var db = new UserOperationsContext();

                Label lblContent = (Label)OpenedProjectList.Rows[i].FindControl("lblContent");
                string projectDescription = db.Projects.FirstOrDefault(p => p.ProjectId == projectId).Description;
                var textToSee = projectDescription.Length >= 65 ? projectDescription.Substring(0, 65) + "..." : projectDescription;
                lblContent.Text = textToSee;
            }
        }
    }
}