<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageRoles.aspx.cs" Inherits="VALE.Admin.ManageRoles" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-10">
                                                <ul class="nav nav-pills">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Gestione Ruoli"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="navbar-right">
                                                <asp:Button ID="btnAddRolesButton" CssClass="btn btn-success" runat="server" Text="Aggiungi" OnClick="btnAddRolesButton_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row" runat="server" id="pnlRoleList">
                                        <div class="col-md-12">
                                            <asp:GridView ID="grdRoles" runat="server" AutoGenerateColumns="False"
                                                ItemType="VALE.Models.XmlRoles"
                                                CssClass="table table-striped table-bordered"
                                                SelectMethod="grdRoles_GetData"
                                                AllowSorting="true">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label CssClass="text-center" runat="server" id="labelRole" Text="<%#: Item.Name %>"></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <center><div><asp:Linkbutton runat="server" id="labelname" ><span  class="glyphicon glyphicon-credit-card"></span> Ruolo</asp:Linkbutton></div></center>
                                                        </HeaderTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center>
                                                                <div>
                                                                    <asp:LinkButton runat="server" CommandName="EditRole" CommandArgument="<%#: Item.Name %>" OnClick="BtnModifyRole_Click"><span class="label label-success">Modifica</span></asp:LinkButton>
                                                                    <asp:LinkButton runat="server" ID="deleteButton"  CommandName="DeleteRole" Visible="false" CommandArgument="<%#: Item.Name %>" OnClick="Delete_Click"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                                                </div>
                                                            </center>
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton runat="server" ID="labelBtnRole" Width="150px"><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <HeaderStyle Width="100px"></HeaderStyle>
                                                        <ItemStyle Width="100px"></ItemStyle>
                                                    </asp:TemplateField>

                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Non ci sono Ruoli</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopup" runat="server"
                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopup" style="width: 50%; height:80%">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />

                        <div class="form-group">

                            <legend> <asp:Label runat="server" ID="lblPopupName" Text="" ></asp:Label> </legend>
                            <div class="form-group">

                                <label class="col-lg-12 control-label">Nome Ruolo *</label>
                                <div class="col-lg-12">
                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="NameTextBox" />
                                    <asp:Label runat="server" CssClass="text-danger" ID="ErrorPopup" Text=""></asp:Label>
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="AddRole" ControlToValidate="NameTextBox" CssClass="text-danger" ErrorMessage="Il campo Nome Ruolo è richiesto." />
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <div class="col-lg-6"></div>
                                    <label class="col-lg-3 control-label">Puo' vedere</label>
                                    <label class="col-lg-3 control-label">Puo' creare</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Amministrazione</label>
                                    <div class="col-lg-6">
                                        <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="AmministrazioneVisibile_CheckedChanged" ID="AmministrazioneVisibile" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Consiglio</label>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="ConsiglioVisibile_CheckedChanged" ID="ConsiglioVisibile" />
                                    </div>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="ConsiglioCreazione_CheckedChanged" ID="ConsiglioCreazione" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Progetti</label>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="ProgettiVisibile" />
                                    </div>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="ProgettiCreazione" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Attivita'</label>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="AttivitaVisibile" />
                                    </div>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="AttivitaCreazione" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Eventi</label>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="EventiVisibile" />
                                    </div>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="EventiCreazione" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Articoli</label>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="ArticoliVisibile" />
                                    </div>
                                    <div class="col-lg-3">
                                        <asp:CheckBox runat="server" ID="ArticoliCreazione" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">ListaUtenti</label>
                                    <div class="col-lg-6">
                                        <asp:CheckBox runat="server" ID="UtentiVisibile" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Home</label>
                                    <div class="col-lg-6">
                                        <asp:CheckBox runat="server" ID="HomeVisibile" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <br />
                                    <label class="col-lg-6 control-label">Documenti dell'associazione</label>
                                    <div class="col-lg-6">
                                        <asp:CheckBox runat="server" ID="DocumentiAssociazioneVisibiile" />
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="Crea" ID="btnOkRoleButton" CssClass="btn btn-success btn-sm" CausesValidation="true" ValidationGroup="AddRole" OnClick="btnOkForNewRoleButton_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" OnClick="btnClosePopUpButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
     <asp:UpdatePanel ID="UpdatePanelPasswordPopUp" runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPasswordPopup" runat="server"
                PopupControlID="pnlPasswordPopup" TargetControlID="lnkPasswordDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkPasswordDummy" runat="server"></asp:LinkButton>
            <div class="alert alert-dismissable alert-info" id="pnlPasswordPopup" style="width: 25%;">
                <asp:LinkButton runat="server" CssClass="close" OnClick="CloseButton_Click">×</asp:LinkButton>
                <div class="row">

                    <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Vuoi cancellare questo ruolo?</strong></asp:Label>
                    <div class="col-md-12">
                        <br />
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox runat="server" ID="RoleConfirm" Enabled="false" CssClass="form-control input-sm" Text="" />
                    </div>

                </div>
                <br />
                <div class="row">

                    <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Inserisci Password</strong></asp:Label>
                    <div class="col-md-12">
                        <br />
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox runat="server" ID="Password" CausesValidation="true" TextMode="Password" CssClass="form-control input-sm" />
                    </div>

                </div>
                <div class="row">

                    <asp:Label runat="server" ID="popupPasswordError" CssClass="col-md-12 control-label text-danger" Text=""></asp:Label>
                    
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-8 col-md-10">
                            <asp:Button runat="server" Text="Ok" ID="btnFilterProjects" CssClass="btn btn-success btn-xs" OnClick="OkButton_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClearFilters" CssClass="btn btn-danger btn-xs" OnClick="CloseButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
