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
        string _dataId;
        string _dataType;
        private IActions dataActions;

        protected void Page_Load(object sender, EventArgs e)
        {
            _dataId = Request.QueryString["dataId"];
            _dataType = Request.QueryString["dataType"];

            //Inizializza IActions
        }

        public IQueryable UsersGridView_GetData()
        {
            var db = new UserOperationsContext();
            var listUsers = dataActions.GetRelatedUsers(_dataId);
            return db.UsersData.Except(listUsers);
        }
    }
}