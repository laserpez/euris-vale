using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VALE.Logic.Serializable;
using VALE.Models;

namespace VALE.Admin
{
    public partial class ManageRoles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddRolesButton_Click(object sender, EventArgs e)
        {
            btnOkRoleButton.Text = "Crea";
            btnClosePopUpButton.Visible = true;
            NameTextBox.Enabled = true;
            NameTextBox.CssClass = "form-control input-sm";
            NameTextBox.Text = "";
            ModalPopup.Show();
        }

        public List<XmlRoles> grdRoles_GetData()
        {
            var prova = new XmlSerializable();
            return prova.ReadData<List<XmlRoles>>("Ruoli");
        }

        protected void btnOkForNewRoleButton_Click(object sender, EventArgs e)
        {
            var prova = new XmlSerializable();
            var ruolo = new XmlRoles();
            var lista = new List<XmlRoles>();

            ruolo.Name = NameTextBox.Text;

            ruolo.Amministrazione = new SourceVisibleOnly() { Visible = AmministrazioneVisibile.Checked };

            ruolo.Consiglio = new Source(){Visible = ConsiglioVisibile.Checked, Creation = ConsiglioCreazione.Checked};
            ruoo.Progetti.Visible = ProgettiVisibile.Checked;
            //ruolo.Progetti.Creation = ProgettiCreazione.Checked;
            //ruolo.Attivita.Visible = AttivitaVisibile.Checked;
            //ruolo.Attivita.Creation = AttivitaCreazione.Checked;
            //ruolo.Eventi.Visible = EventiVisibile.Checked;
            //ruolo.Eventi.Creation = EventiCreazione.Checked;
            //ruolo.Articoli.Visible = ArticoliVisibile.Checked;
            //ruolo.Articoli.Creation = ArticoliCreazione.Checked;

            //ruolo.ListaUtenti.Visible = UtentiVisibile.Checked;
            //ruolo.Home.Visible = HomeVisibile.Checked;
            //ruolo.DocumentiAssociazione.Visible = DocumentiAssociazioneVisibiile.Checked;

            lista.Add(ruolo);
            prova.SaveData<List<XmlRoles>>(lista,"Ruoli");
            grdRoles.DataBind();
        }

        protected void btnClosePopUpButton_Click(object sender, EventArgs e)
        {
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
    }
}
