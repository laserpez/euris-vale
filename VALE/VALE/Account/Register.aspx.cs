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
using System.Text.RegularExpressions;

namespace VALE.Account
{
    public partial class Register : Page
    {
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
                SetRegionDropDownList();
        }

        private void ClearDropDownList()
        {
            List<string> init = new List<string> { "Seleziona" };
            DropDownProvince.DataSource = init;
            DropDownProvince.DataBind();
            DropDownCity.DataSource = init;
            DropDownCity.DataBind();
        }

        private void SetRegionDropDownList()
        {
            ClearDropDownList();
            String path = Server.MapPath("~/StateInfo/regioni_province_comuni.xml");
            StateInfoXML.GetInstance().FileName = path;
            var list = StateInfoXML.GetInstance().LoadData();
            var regions = (from r in list where r.depth == "0" orderby r.name select r.name).ToList();
            regions.Insert(0, "Seleziona");
            DropDownRegion.DataSource = regions;
            DropDownRegion.DataBind();
        }

        protected void Region_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownRegion.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                DropDownProvince.DataSource = init;
                DropDownProvince.DataBind();
                DropDownCity.DataSource = init;
                DropDownCity.DataBind();
            }
            else
            {
                ClearDropDownList();

                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "0" && r.name == DropDownRegion.SelectedValue select r.tid).FirstOrDefault();
                var provinces = (from r in list where r.depth == "1" && r.parent == tid orderby r.name select r.name).ToList();
                provinces.Insert(0, "Seleziona");
                DropDownProvince.DataSource = provinces;
                DropDownProvince.DataBind();
            }
        }

        protected void State_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownProvince.SelectedIndex == 0)
            {
                List<string> init = new List<string> { "Seleziona" };
                DropDownCity.DataSource = init;
                DropDownCity.DataBind();
            }
            else
            {
                var list = StateInfoXML.GetInstance().LoadData();
                var tid = (from r in list where r.depth == "1" && r.name == DropDownProvince.SelectedValue select r.tid).FirstOrDefault();
                var citys = (from r in list where r.depth == "2" && r.parent == tid orderby r.name select r.name).ToList();
                citys.Insert(0, "Seleziona");
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
                Telephone = TextTelephone.Text,
                CellPhone = TextCellPhone.Text,
                Region = DropDownRegion.SelectedValue,
                Province = DropDownProvince.SelectedValue,
                City = DropDownCity.SelectedValue,
                CF = TextCF.Text,
                NeedsApproval = checkAssociated.Checked,
                Email = Email.Text
            };
            var passwordValidator = new PasswordValidator();
            //per la password sono richiesti solo sei caratteri
            passwordValidator.RequiredLength = 6;
            manager.PasswordValidator = passwordValidator;

            IdentityResult result = manager.Create(user, Password.Text);
            if (result.Succeeded)
            {
                db.UserDatas.Add(new UserData
                {
                    UserName = user.UserName,
                    Email = user.Email,
                    FullName = user.FirstName + " " + user.LastName
                });
                db.SaveChanges();
                //IdentityHelper.SignIn(manager, user, isPersistent: false);

                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                //string code = manager.GenerateEmailConfirmationToken(user.Id);
                //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id);
                //manager.SendEmail(user.Id, "Conferma il tuo account", "Per favore conferma il tuo account cliccando <a href=\"" + callbackUrl + "\">qui</a>.");

                //IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);

                string titleMessage = string.Format("Grazie {0} {1},", user.FirstName, user.LastName);
                string message = string.Format("Abbiamo registrato la Sua richiesta, una mail di conferma viene mandato all'indirizzo {0} appena viene accettata", user.Email);
                string url = string.Format("~/MessagePage.aspx?TitleMessage={0}&Message={1}", titleMessage, message);
                Response.Redirect(url);
            }
            else
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}