using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VALE
{
    public partial class MessagePage : System.Web.UI.Page
    {
        public string TitleMessage { get; set; }
        public string Message { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            string titleMessage = Request.QueryString["TitleMessage"];
            string message = Request.QueryString["Message"];
            if (titleMessage != null && message != null)
            {
                TitleMessage = titleMessage;
                Message = message;
            }
            else 
            {
                Response.Redirect("~/");
            }
           
        }
    }
}