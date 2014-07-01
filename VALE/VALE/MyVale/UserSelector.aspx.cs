using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Models;

namespace VALE.MyVale
{
    public partial class UserSelector : System.Web.UI.Page
    {
        int _dataId;
        string _dataType;
        private IActions _dataActions;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataId = Convert.ToInt32(Request.QueryString["dataId"]);
            _dataType = Request.QueryString["dataType"];

            //Inizializza IActions
            if (_dataType == "project")
                _dataActions = new ProjectActions();
            else
                _dataActions = new EventActions();
        }

        public IQueryable<UserData> UsersGridView_GetData()
        {
            var db = new UserOperationsContext();
            var listUsers = _dataActions.GetRelatedUsers(_dataId);
            var resultList = db.UsersData.ToList().Except(listUsers);
            return resultList.AsQueryable();
        }

        protected void btnAddUsers_Click(object sender, EventArgs e)
        {
            var btn = (Button)sender;
            _dataActions.AddOrRemoveUserData(_dataId, btn.CommandName);

            UsersGridView.DataBind();
        }
    }
}