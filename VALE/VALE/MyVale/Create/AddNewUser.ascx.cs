using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Models;
using VALE.StateInfo;
using VALE.Logic;

namespace VALE.MyVale.Create
{
    public partial class AddNewUser : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetRegionDropDownList();
                SetRoleDropDownList();
            }
        }

        private void SetRoleDropDownList()
        {
            List<string> init = new List<string> { "Seleziona", "Amministratore", "Membro del Consiglio", "Socio"};
            DropDownSelectRole.DataSource = init;
            DropDownSelectRole.DataBind();
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
            ModalPopup.Show();
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
            ModalPopup.Show();
        }

        protected void CloseButton_Click(object sender, EventArgs e)
        {
            ModalPopup.Hide();
        }

        protected void AddNewUser_Click(object sender, EventArgs e)
        {
            ModalPopup.Show();
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
                NeedsApproval= false,
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

                var actions = new UserActions();

                if (actions.ChangeUserRole(user.UserName, DropDownSelectRole.SelectedValue))
                {
                    //string code = manager.GenerateEmailConfirmationToken(user.Id);
                    //string callbackUrl = IdentityHelper.GetUserConfirmationRedirectUrl(code, user.Id);
                    string body = "Benvenuto in VALE! La password di default con cui effettuare il Log In è:" + Password.Text + ". <br/> Potrai cambiarla una volta confermato l'account cliccando <a href=\"http://localhost:59959/Admin/ResetPassword.aspx" + "\"> qui <a/>";
                    //MailHelper.SendMail(user.Email, "Conferma account", body);
                    Response.Redirect("~/Admin/ManageUsers");
                }
                else
                {
                    SelectRole.Text = "Errore nella modifica dell'utente " + user.UserName + ".";
                    SelectRole.ForeColor = System.Drawing.Color.Red;
                    SelectRole.Visible = true;
                }
            }
            else
            {
                ErrorMessage.Text = result.Errors.FirstOrDefault();
            }
        }
    }
}