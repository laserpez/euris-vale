using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VALE
{
    public partial class ProvaDrag : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable dt = new DataTable();
                dt.Columns.AddRange(new DataColumn[2] { new DataColumn("Item"), new DataColumn("Price") });
                dt.Rows.Add("Shirt", 450);
                dt.Rows.Add("Jeans", 3200);
                dt.Rows.Add("Trousers", 1900);
                dt.Rows.Add("Tie", 185);
                dt.Rows.Add("Cap", 100);
                dt.Rows.Add("Hat", 120);
                dt.Rows.Add("Scarf", 290);
                dt.Rows.Add("Belt", 150);
                gv1.UseAccessibleHeader = true;
                gv1.DataSource = dt;
                gv1.DataBind();

                dt.Rows.Clear();
                dt.Rows.Add();
                gv2.DataSource = dt;
                gv2.DataBind();


            }
        }
    }
}