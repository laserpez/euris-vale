using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;

namespace VALE
{
    public partial class UploadFile : System.Web.UI.Page
    {
        UserOperationsContext _db = new UserOperationsContext();
        public bool RelatedTo
        {
            get
            {
                if (allowDelete.Text == "true")
                    return true;
                else
                    return false;
            }
            set { allowDelete.Text = value.ToString(); }
        }

        
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) 
            {
                
            }
        }

        protected void AddFileNameButton_Click(object sender, EventArgs e)
        {
            AttachedFile attachedFile = new AttachedFile();
            if (FileUpload.HasFile) 
            {
                attachedFile.FileName = FileUpload.PostedFile.FileName;
                attachedFile.FileExtension = Path.GetExtension(FileUpload.PostedFile.FileName);
                attachedFile.FileData = FileUpload.FileBytes;
                attachedFile.Owner = User.Identity.Name;
                attachedFile.CreationDate = DateTime.Now;
                using(var _db = new UserOperationsContext())
                {
                        
                     _db.SaveChanges();
                }
                DocumentsGridView.DataBind();
            }
        }

        //public string IsDeleteAllowed(AttachedFile attachedFile) 
        //{
        //    if (!attachedFile.IsTemp && !AllawDelete)
        //        return "";
        //    else
        //        return "style"; 
        //}


        public IQueryable<AttachedFile> DocumentsGridView_GetData()
        {
            
            return null;
        }

        protected void DeleteDocumentFromProject_Click(object sender, EventArgs e)
        {
            
        }
    }
}