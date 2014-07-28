using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic;
using VALE.Logic.Serializable;
using VALE.Models;

namespace VALE.Admin
{
    public partial class ManageRoles : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetDeleteButtonGrid();
        }

        private void SetDeleteButtonGrid()
        {
            int i;
            for (i = 0; i < grdRoles.Rows.Count; i++)
            {
                var deleteButton = (LinkButton)grdRoles.Rows[i].Cells[1].FindControl("deleteButton");
                var rolelabel = ((Label)grdRoles.Rows[i].Cells[0].FindControl("labelRole"));
                string role = rolelabel.Text;
                if (role != "Amministratore" && role != "Membro del consiglio" && role != "Socio" && role != "Collaboratore")
                {
                    deleteButton.Visible = true;
                }
            }
        }

        protected void btnAddRolesButton_Click(object sender, EventArgs e)
        {
            lblPopupName.Text = "Nuovo Ruolo";
            btnOkRoleButton.Text = "Crea";
            btnClosePopUpButton.Visible = true;
            NameTextBox.Enabled = true;
            NameTextBox.CssClass = "form-control input-sm";
            NameTextBox.Text = "";
            ModalPopup.Show();
        }

        protected void BtnModifyRole_Click(object sender, EventArgs e)
        {
            lblPopupName.Text = "Modifica Ruolo";
            LinkButton button = (LinkButton)sender;
            btnOkRoleButton.Text = "Modifica";
            btnClosePopUpButton.Visible = true;
            NameTextBox.Enabled = false;
            NameTextBox.CssClass = "form-control input-sm";
            NameTextBox.Text = button.CommandArgument;

            var list = grdRoles_GetData();
            var dato = list.Find(o => o.Name == button.CommandArgument);

            AmministrazioneVisibile.Checked = dato.Amministrazione.Visible;
            ConsiglioVisibile.Checked = dato.Consiglio.Visible;
            ConsiglioCreazione.Checked = dato.Consiglio.Creation;
            ProgettiVisibile.Checked = dato.Progetti.Visible;
            ProgettiCreazione.Checked = dato.Progetti.Creation;
            AttivitaVisibile.Checked = dato.Attivita.Visible;
            AttivitaCreazione.Checked = dato.Attivita.Creation;
            EventiVisibile.Checked = dato.Eventi.Visible;
            EventiCreazione.Checked = dato.Eventi.Creation;
            ArticoliVisibile.Checked = dato.Articoli.Visible;
            ArticoliCreazione.Checked = dato.Articoli.Creation;
            UtentiVisibile.Checked = dato.ListaUtenti.Visible;
            HomeVisibile.Checked = dato.Home.Visible;
            DocumentiAssociazioneVisibiile.Checked = dato.DocumentiAssociazione.Visible;

            ModalPopup.Show();
        }

        public List<XmlRoles> grdRoles_GetData()
        {
            String path = Server.MapPath("~/Logic/Serializable/Ruoli.xml");
            var serializer = new XmlSerializable();
            return serializer.ReadData<List<XmlRoles>>(path);
        }

        protected void Delete_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            RoleActions.DeleteRole(button.CommandArgument);

            grdRoles.DataBind();
            SetDeleteButtonGrid();
        }

        protected void btnOkForNewRoleButton_Click(object sender, EventArgs e)
        {
            var serializer = new XmlSerializable();

            bool condition = true;
            String path = Server.MapPath("~/Logic/Serializable/Ruoli.xml");
            var controlData = serializer.ReadData<List<XmlRoles>>(path);
            if (controlData != null && btnOkRoleButton.Text == "Crea")
            {
                foreach (var elem in controlData)
                {
                    if (elem.Name == NameTextBox.Text)
                    {
                        ErrorPopup.Text = "Ruolo  gia' esistente";
                        ModalPopup.Show();
                        condition = false;
                    }
                }
            }

            if (condition)
            {
                 
                var ruolo = new XmlRoles();
                ruolo.Name = NameTextBox.Text;

                ruolo.Amministrazione = new SourceVisibleOnly() { Visible = AmministrazioneVisibile.Checked };

                ruolo.Consiglio = new Source() { Visible = ConsiglioVisibile.Checked, Creation = ConsiglioCreazione.Checked };
                ruolo.Progetti = new Source() { Visible = ProgettiVisibile.Checked, Creation = ProgettiCreazione.Checked };
                ruolo.Attivita = new Source() { Visible = AttivitaVisibile.Checked, Creation = AttivitaCreazione.Checked };
                ruolo.Eventi = new Source() { Visible = EventiVisibile.Checked, Creation = EventiCreazione.Checked };
                ruolo.Articoli = new Source() { Visible = ArticoliVisibile.Checked, Creation = ArticoliCreazione.Checked };

                ruolo.ListaUtenti = new SourceVisibleOnly() { Visible = UtentiVisibile.Checked };
                ruolo.Home = new SourceVisibleOnly() { Visible = HomeVisibile.Checked };
                ruolo.DocumentiAssociazione = new SourceVisibleOnly() { Visible = DocumentiAssociazioneVisibiile.Checked };

                RoleActions.CreateRole(ruolo);
                ErrorPopup.Text = "";

            }

            grdRoles.DataBind();
            UnCheckAll();
            SetDeleteButtonGrid();
        }

        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
            ErrorPopup.Text = "";
            UnCheckAll();
            ModalPopup.Hide();
        }


        protected void AmministrazioneVisibile_CheckedChanged(object sender, EventArgs e)
        {
            if (AmministrazioneVisibile.Checked == true){
                ConsiglioVisibile.Checked = true;
                ConsiglioCreazione.Checked = true;
                Check();
            }
            else
            {
                ConsiglioVisibile.Checked = false;
                ConsiglioCreazione.Checked = false;
                UnCheck();
            }
        }

        protected void ConsiglioVisibile_CheckedChanged(object sender, EventArgs e)
        {
            if (ConsiglioVisibile.Checked == true)
            {
                Check();
            }
            else
            {
                AmministrazioneVisibile.Checked = false;
                ConsiglioCreazione.Checked = false;
                UnCheck();
            }
            
        }

        protected void ConsiglioCreazione_CheckedChanged(object sender, EventArgs e)
        {
            if (ConsiglioCreazione.Checked == true)
            {
                ConsiglioVisibile.Checked = true;
                Check();
            }
            else
            {
                ConsiglioVisibile.Checked = false;
                UnCheck();
            }

        }

        private void Check()
        {
            ProgettiVisibile.Checked = true;
            ProgettiCreazione.Checked = true;
            AttivitaVisibile.Checked = true;
            AttivitaCreazione.Checked = true;
            EventiVisibile.Checked = true;
            EventiCreazione.Checked = true;
            ArticoliVisibile.Checked = true;
            ArticoliCreazione.Checked = true;
            UtentiVisibile.Checked = true;
            HomeVisibile.Checked = true;
            DocumentiAssociazioneVisibiile.Checked = true;
            ModalPopup.Show();
        }

        private void UnCheck()
        {
            ProgettiVisibile.Checked = false;
            ProgettiCreazione.Checked = false;
            AttivitaVisibile.Checked = false;
            AttivitaCreazione.Checked = false;
            EventiVisibile.Checked = false;
            EventiCreazione.Checked = false;
            ArticoliVisibile.Checked = false;
            ArticoliCreazione.Checked = false;
            UtentiVisibile.Checked = false;
            HomeVisibile.Checked = false;
            DocumentiAssociazioneVisibiile.Checked = false;
            ModalPopup.Show();
        }

        private void UnCheckAll()
        {
            AmministrazioneVisibile.Checked = false;
            ConsiglioVisibile.Checked = false;
            ConsiglioCreazione.Checked = false;
            ProgettiVisibile.Checked = false;
            ProgettiCreazione.Checked = false;
            AttivitaVisibile.Checked = false;
            AttivitaCreazione.Checked = false;
            EventiVisibile.Checked = false;
            EventiCreazione.Checked = false;
            ArticoliVisibile.Checked = false;
            ArticoliCreazione.Checked = false;
            UtentiVisibile.Checked = false;
            HomeVisibile.Checked = false;
            DocumentiAssociazioneVisibiile.Checked = false;
        }
    }
}
