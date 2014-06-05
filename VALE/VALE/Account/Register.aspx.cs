using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using VALE.Models;
using System.Collections.Generic;
using VALE.StateInfo;

namespace VALE.Account
{
    public partial class Register : Page
    {
        protected void Page_PreRender(object sender, EventArgs e)
        {
            Email.Text = "domenico.moreschini@gmail.com";
            TextFirstName.Text = "Domenico";
            TextLastName.Text = "Moreschini";
            TextAddress.Text = "Via Galvoni 35";
            //TextCity.Text = "Castignano";
            //TextProv.Text = "AP";
            TextCF.Text = "MRSDNC87P25H769L";
            Password.Text = "Pa$$word1";

            if (!IsPostBack)
                SetRegionDropDownList();
        }

        private void SetRegionDropDownList()
        {
            List<string> init = new List<string> { "Select" };
            DropDownProvince.DataSource = init;
            DropDownProvince.DataBind();
            DropDownCity.DataSource = init;
            DropDownCity.DataBind();
            String path = Server.MapPath("~/StateInfo/regioni_province_comuni.xml");
            StateInfoXML.GetInstance().FileName = path;
            var list = StateInfoXML.GetInstance().LoadData();
            var regions = (from r in list where r.depth == "0" orderby r.name select r.name).ToList();
            regions.Insert(0, "Select");
            DropDownRegion.DataSource = regions;
            DropDownRegion.DataBind();
        }

        protected void Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownRegion.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Select" };
                DropDownProvince.DataSource = init;
                DropDownProvince.DataBind();
                DropDownCity.DataSource = init;
                DropDownCity.DataBind();
            }
            else
            {
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "0" && r.name == DropDownRegion.SelectedValue select r.tid).FirstOrDefault();
                var provinces = (from r in list where r.depth == "1" && r.parent == tid orderby r.name select r.name).ToList();
                provinces.Insert(0, "Select");
                DropDownProvince.DataSource = provinces;
                DropDownProvince.DataBind();
            }
        }

        protected void State_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownProvince.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Select" };
                DropDownCity.DataSource = init;
                DropDownCity.DataBind();
            }
            else
            {
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "1" && r.name == DropDownProvince.SelectedValue select r.tid).FirstOrDefault();
                var citys = (from r in list where r.depth == "2" && r.parent == tid orderby r.name select r.name).ToList();
                citys.Insert(0, "Select");
                DropDownCity.DataSource = citys;
                DropDownCity.DataBind();
            }
        }

        protected void CreateUser_Click(object sender, EventArgs e)
        {
            var db = new UserOperationsContext();
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var user = new ApplicationUser() 
            {
                UserName = TextUserName.Text,
                FirstName = TextFirstName.Text,
                LastName = TextLastName.Text,
                Address = TextAddress.Text,
                Region = DropDownRegion.SelectedValue,
                Province = DropDownProvince.SelectedValue,
                City = DropDownCity.SelectedValue,
                CF = TextCF.Text,
                NeedsApproval = checkAssociated.Checked,
                Email = Email.Text 
            };
            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                db.UsersData.Add(new UserData 
                { 
                    UserName = user.UserName,
                    Email = user.Email,
                    FullName = user.FirstName + " " + user.LastName
                });
                db.SaveChanges();
                IdentityHelper.SignIn(manager, user, isPersistent: false);

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                //string code = manager.GenerateEmailConfirmationToken(user.Id);
                //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id);
                //manager.SendEmail(user.Id, "Confirm your account", "Please confirm your account by clicking <a href=\"" + callbackUrl + "\">here</a>.");

                IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
            }
            else 
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}