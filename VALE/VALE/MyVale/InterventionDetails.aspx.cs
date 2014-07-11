﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using VALE.Logic;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class InterventionDetails : System.Web.UI.Page
    {
        private string _currentUser;
        private int _currentInterventionId;
        private UserOperationsContext _db;

        protected void Page_Load(object sender, EventArgs e)
        {
            _db = new UserOperationsContext();
            _currentUser = User.Identity.GetUserName();
            if (Request.QueryString.HasKeys())
                _currentInterventionId = Convert.ToInt32(Request.QueryString["interventionId"]);
        }

        public Intervention GetIntervention([QueryString("interventionId")] int? interventionId)
        {
            if (interventionId.HasValue)
                return _db.Interventions.First(i => i.InterventionId == interventionId);
            else
                return null;
        }

        public IQueryable<AttachedFile> DocumentsGridView_GetData()
        {
            var actions = new InterventionActions();
            var list = actions.GetAttachments(_currentInterventionId);
            return list.AsQueryable();
        }

        protected void grdFilesUploaded_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var db = new UserOperationsContext();
            int id = Convert.ToInt32(e.CommandArgument);
            switch (e.CommandName)
            {
                case "DOWNLOAD":
                default:
                    Response.Redirect("/DownloadFile.ashx?fileId=" + id);
                    break;
            }
        }

        private void HideAttchmentBox(string name)
        {
            ListBox list = (ListBox)InterventionDetail.FindControl(name);
            list.Visible = false;
            Label labelAttachment = (Label)InterventionDetail.FindControl("labelAttachment");
            labelAttachment.Visible = false;
            Button btnViewAttchment = (Button)InterventionDetail.FindControl("btnViewDocument");
            btnViewAttchment.Visible = false;
        }

        protected void btnAddComment_Click(object sender, EventArgs e)
        {
            var comment = new Comment
            {
                Date = DateTime.Now,
                CommentText = txtComment.Text,
                CreatorUserName = _currentUser,
                InterventionId = _currentInterventionId
            };
            _db.Comments.Add(comment);
            _db.SaveChanges();
            lstComments.DataBind();
            txtComment.Text = "";
        }

        public List<Comment> GetComments([QueryString("interventionId")] int? interventionId)
        {
            if (interventionId.HasValue)
            {
                var comments = _db.Comments.Where(c => c.InterventionId == interventionId).ToList();
                return comments;
            }
            else
                return null;
        }

    }
}