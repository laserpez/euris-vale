using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VALE
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TreeCode.Text = "<asp:TreeView ID='TreeView1' runat='server'><Nodes><asp:TreeNode Text='My Computer'><asp:TreeNode Text='Favorites'></asp:TreeNode></asp:TreeNode></Nodes></asp:TreeView>";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }
}