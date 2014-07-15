using System;
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
        private bool _canRemove = true;

        public bool CanRemove
        {
            get { return _canRemove; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataId = Convert.ToInt32(Request.QueryString["dataId"]);
            _dataType = Request.QueryString["dataType"];
            _returnUrl = Request.QueryString["returnUrl"];

            if (!String.IsNullOrEmpty(Request.QueryString["canRemove"]))
                _canRemove = Convert.ToBoolean(Request.QueryString["canRemove"]);

            //Inizializza IActions
            if (_dataType == "project")
                _dataActions = new ProjectActions();
            else if (_dataType == "event")
                _dataActions = new EventActions();
            else
                _dataActions = new ActivityActions();

            if (!IsPostBack)
                SetGridViewsVisibility("Users");
        }


        public IQueryable<UserData> UsersGridView_GetData([Control]string txtSearchByName, [Control]string ddlFilterGrids)
        {
            var db = new UserOperationsContext();
            IQueryable<UserData> resultList = null;

            switch(ddlFilterGrids)
            {
                case "unrelated":
                    var listUsers = _dataActions.GetRelatedUsers(_dataId);
                    resultList = db.UserDatas.ToList().Except(listUsers).AsQueryable();
                    break;
                case "related":
                    resultList = _dataActions.GetRelatedUsers(_dataId);
                    break;
                case "all":
                    resultList = db.UserDatas;
                    break;
                default:
                    break;
            }

            if (!String.IsNullOrEmpty(txtSearchByName))
                resultList = resultList.Where(u => u.FullName.ToLower().Contains(txtSearchByName.ToLower()));

            return resultList;
        }

        protected void btnSearchUsers_Click(object sender, EventArgs e)
        {
            DataBindGridViews();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect(_returnUrl);
        }

        protected void btnSelectUsers_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;

            btnCurrentView.InnerHtml = button.Text + " <span class=\"caret\"></span>";

            SetGridViewsVisibility(button.CommandArgument);
            txtSearchByName.Text = "";
            DataBindGridViews();
        }

        private void SetGridViewsVisibility(string commandArgument)
        {
            UsersGridView.Visible = commandArgument == "Users";
            GroupsGridView.Visible = commandArgument == "Groups";
        }

        protected void btnAddOrRemoveUsers_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            _dataActions.AddOrRemoveUserData(_dataId, btn.CommandName);
            DataBindGridViews();
        }

        private void DataBindGridViews()
        {
            UsersGridView.DataBind();
            GroupsGridView.DataBind();
        }

        public bool IsUserRelated(string username)
        {
            return _dataActions.IsUserRelated(_dataId, username);
        }

        public bool IsGroupRelated(int groupId)
        {
            return _dataActions.IsGroupRelated(_dataId, groupId);
        }

        public IQueryable<Group> GroupsGridView_GetData([Control]string txtSearchByName, [Control]string ddlFilterGrids)
        {
            var db = new UserOperationsContext();
            
            IQueryable<Group> resultList = null;
            switch (ddlFilterGrids)
            {
                case "unrelated":
                    var listGroups = _dataActions.GetRelatedGroups(_dataId);
                    resultList = db.Groups.ToList().Except(listGroups).AsQueryable();
                    break;
                case "related":
                    resultList = _dataActions.GetRelatedGroups(_dataId);
                    break;
                case "all":
                    resultList = db.Groups;
                    break;
                default:
                    break;
            }
            resultList = resultList.Where(g => g.Users.Count != 0);
            if (!String.IsNullOrEmpty(txtSearchByName))
                resultList = resultList.Where(g => g.GroupName.ToLower().Contains(txtSearchByName.ToLower()));
            return resultList;
        }

        protected void btnAddGroup_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            var groupId = Convert.ToInt32(btn.CommandArgument);

            var db = new UserOperationsContext();
            var group = db.Groups.First(g => g.GroupId == groupId);

            foreach(var user in group.Users)
            {
                if( (btn.CommandName == "Add" &&  !_dataActions.IsUserRelated(_dataId, user.UserName)) ||
                    (btn.CommandName == "Remove" && _dataActions.IsUserRelated(_dataId, user.UserName)) )
                {
                    _dataActions.AddOrRemoveUserData(_dataId, user.UserName);
                }
            }
            DataBindGridViews();
        }

        protected void ddlFilterGrids_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtSearchByName.Text = "";
            DataBindGridViews();
        }
    }
}