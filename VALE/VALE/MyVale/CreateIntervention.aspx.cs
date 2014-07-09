using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using System.IO;
using VALE.Models;
using System.Data.Entity.Validation;

namespace VALE.MyVale
{
    public partial class CreateIntervention : System.Web.UI.Page
    {
        private string _currentUser;
        private int _currentProjectId;
        private string _temporaryPath;

        protected void Page_Load(object sender, EventArgs e)
        {
            //_currentUser = User.Identity.GetUserName();
            //_temporaryPath = "/MyVale/Documents/Temp/" + _currentUser + "/";
            //if (Request.QueryString.HasKeys())
            //    _currentProjectId = Convert.ToInt32(Request.QueryString.GetValues("projectId").First());
            //if (!IsPostBack)
            //{
            //    if (!String.IsNullOrEmpty(_temporaryPath))
            //    {
            //        if (Directory.Exists(Server.MapPath(_temporaryPath)))
            //            Directory.Delete(Server.MapPath(_temporaryPath), true);
            //        Directory.CreateDirectory(Server.MapPath(_temporaryPath));
            //    }

            //    PopulateGridView();
            //}
        }

        protected void btnSaveIntervention_Click(object sender, EventArgs e)
        {
            //var db = new UserOperationsContext();
            //var intervention = new Intervention
            //{
            //    CreatorUserName = _currentUser,
            //    ProjectId = _currentProjectId,
            //    InterventionText = txtComment.Text,
            //    Date = DateTime.Today
            //};
            //db.Interventions.Add(intervention);
            //db.SaveChanges();
            //intervention.DocumentsPath = "/MyVale/Documents/Interventions/" + intervention.InterventionId + "/";
            //string serverPath = Server.MapPath(intervention.DocumentsPath);
            //string tempPath = Server.MapPath(_temporaryPath);
            //if (!Directory.Exists(Server.MapPath("/MyVale/Documents/Interventions/")))
            //    Directory.CreateDirectory(Server.MapPath("/MyVale/Documents/Interventions/"));
            //Directory.Move(tempPath, serverPath);
            //db.SaveChanges();

            //Response.Redirect("/MyVale/ProjectDetails?projectId=" + _currentProjectId);
        }

        protected void btnUploadFile_Click(object sender, EventArgs e)
        {
            //if (FileUploadControl.HasFiles)
            //{
            //    FileUploadControl.SaveAs(Server.MapPath(_temporaryPath + Path.GetFileName(FileUploadControl.PostedFile.FileName)));
            //}
            //PopulateGridView();
        }

        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            GridView grid = (GridView)sender;
            int index = Convert.ToInt32(e.CommandArgument);
            string fileToRemove = grid.Rows[index].Cells[1].Text;
            File.Delete(Server.MapPath(_temporaryPath) + fileToRemove);
            PopulateGridView();
        }

        private void PopulateGridView()
        {
            DirectoryInfo dirInfo = new DirectoryInfo(Server.MapPath(_temporaryPath));
            if (dirInfo.Exists)
                grdFilesUploaded.DataSource = dirInfo.GetFiles().Select(o => new { Filename = o.Name });
            else
                grdFilesUploaded.DataSource = null;
            grdFilesUploaded.DataBind();
        }
    }
}