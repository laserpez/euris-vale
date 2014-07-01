﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;
using System.Web.ModelBinding;

namespace VALE.MyVale
{
    public partial class UserSelector : System.Web.UI.Page
    {
        private int _dataId;
        private string _dataType;
        private string _returnUrl;
        private IActions _dataActions;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataId = Convert.ToInt32(Request.QueryString["dataId"]);
            _dataType = Request.QueryString["dataType"];
            _returnUrl = Request.QueryString["returnUrl"];

            //Inizializza IActions
            if (_dataType == "project")
                _dataActions = new ProjectActions();
            else
                _dataActions = new EventActions();
        }


        public IQueryable<UserData> UsersGridView_GetData([Control]string txtSearchUsers, [Control]string lblCurrentSelection)
        {
            var db = new UserOperationsContext();
            IQueryable<UserData> resultList = null;

            switch(lblCurrentSelection)
            {
                case "UnrelatedUsers":
                    var listUsers = _dataActions.GetRelatedUsers(_dataId);
                    resultList = db.UsersData.ToList().Except(listUsers).AsQueryable();
                    break;
                case "RelatedUsers":
                    resultList = _dataActions.GetRelatedUsers(_dataId);
                    break;
                default:
                    break;
            }
             
            if (!String.IsNullOrEmpty(txtSearchUsers))
                resultList = resultList.Where(u => u.FullName.ToLower().Contains(txtSearchUsers.ToLower()));

            return resultList;
        }

        protected void btnSearchUsers_Click(object sender, EventArgs e)
        {
            UsersGridView.DataBind();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect(_returnUrl);
        }

        protected void btnSelectUsers_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;

            btnCurrentView.InnerHtml = button.Text + " <span class=\"caret\"></span>";
            lblCurrentSelection.Text = button.CommandArgument;
            UsersGridView.DataBind();
        }

        protected void btnAddUsers_Click(object sender, EventArgs e)
        {

        }
    }
}