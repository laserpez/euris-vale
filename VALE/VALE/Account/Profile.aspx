<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="VALE.Account.Profile" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="col-lg-12">
                                <ul class="nav nav-pills">
                                    <li>
                                        <h4>
                                            <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Profilo Utente
                                        </h4>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-md-12" runat="server" id="pnlInfo" visible="false">
                                    <div class="alert alert-dismissable alert-success">
                                        <asp:LinkButton id="btnClosePanelInfo" runat="server" class="close" OnClick="btnClosePanelInfo_Click">×</asp:LinkButton>
                                        <asp:Label ID="lblInfo" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="row">
                            <div class="col-md-9">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="well bs-component col-md-12">
                                            <div class="row">
                                                <div class="col-md-7">
                                                    <legend>
                                                        <asp:Label runat="server" ID="LabelFullName"></asp:Label></legend>
                                                </div>
                                                <div class="col-md-5">
                                                    <center>
                                                            <div>
                                                                <asp:Button CausesValidation="false" ID="btnModifyPassword" CssClass="btn btn-info btn-sm" runat="server" Text="Modifica Password" OnClick="btnModifyPassword_Click"/>
                                                                <asp:Button CausesValidation="false" ID="btnModifyPersonalData" CssClass="btn btn-primary btn-sm" runat="server" Text="Aggiorna Dati Personali" OnClick="btnModifyPersonalData_Click" />
                                                            </div>
                                                        </center>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label runat="server" Font-Bold="true">Nome: </asp:Label>
                                                            <asp:Label runat="server" ID="LabelFirstName"></asp:Label>
                                                        </div>
                                                        
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label runat="server" Font-Bold="true">Cognome: </asp:Label>
                                                            <asp:Label runat="server" ID="LabelLastName"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label Visible="false" ID="lblLabelCF" runat="server" Font-Bold="true">Codice Fiscale: </asp:Label>
                                                            <asp:Label Visible="false" runat="server" ID="LabelCF"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label  ID="lblLabelRole" runat="server" Font-Bold="true">Ruolo: </asp:Label>
                                                            <asp:Label runat="server" ID="LabelRole"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label runat="server" Font-Bold="true">Socio: </asp:Label>
                                                            <asp:Label runat="server" ID="LabelPartner"></asp:Label>
                                                        </div>
                                                    </div>
                                                     <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label Visible="false" ID="lblLabelPartnerType" runat="server" Font-Bold="true">Tipo di Socio: </asp:Label>
                                                            <asp:Label Visible="false" runat="server" ID="LabelPartnerType"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label runat="server" Font-Bold="true">Email: </asp:Label>
                                                            <asp:Label runat="server" ID="LabelEmail"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label Visible="false" ID="lblLabelTelephone" runat="server" Font-Bold="true">Telefono: </asp:Label>
                                                            <asp:Label runat="server" Visible="false" ID="LabelTelephone"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label runat="server" Font-Bold="true">Cellulare: </asp:Label>
                                                            <asp:Label runat="server" ID="LabelCellPhone"></asp:Label>
                                                        </div>
                                                    </div>
                                                     <div class="row">
                                                        <div class="col-md-12">
                                                            <asp:Label runat="server" Visible="false" ID="lblLabelAddress" Font-Bold="true">Indirizzo:</asp:Label>
                                                            <asp:Label runat="server" Visible="false" ID="LabelAddress"></asp:Label>
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="panel panel-default" style="width: 260px;">
                                            <div class="panel-body">
                                                <asp:ImageButton ID="picProfile" runat="server" ImageUrl="~/default_profile.jpg" Width="230" Height="230" OnClick="ImageButton_Click" />
                                            </div>
                                            <div class="panel-footer" runat="server" id="pnlEditImageButtons" visible="false">
                                                <center>
                                                    <div>
                                                            <asp:Button runat="server" id="btnAddImage" Text="Aggiungi" CssClass="btn btn-success btn-xs" OnClick="btnAddImage_Click" />
                                                            <asp:Button runat="server" id="btnEditImage" Text="Modifica" CssClass="btn btn-primary btn-xs" OnClick="btnEditImage_Click" />
                                                            <asp:Button runat="server" id="btnDeleteImage" Text="Cancella" CssClass="btn btn-danger btn-xs" OnClick="btnDeleteImage_Click" />
                                                    </div>
                                                </center>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                    </div>
                    <div class="row">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="col-md-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="col-md-8">
                                                        <ul class="nav nav-pills">
                                                            <li>
                                                                <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Presentazione</li>
                                                        </ul>
                                                    </div>
                                                    <div class="navbar-right">
                                                        <asp:Button runat="server" Text="Modifica" ID="btnModifyDescription" CssClass="btn btn-primary btn-xs" CausesValidation="false" OnClick="btnModifyDescription_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body">
                                            <div class="well well-sm">
                                                <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="row">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <div class="col-md-12">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="col-md-8">
                                                        <ul class="nav nav-pills">
                                                            <li>
                                                                <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</li>
                                                        </ul>
                                                    </div>
                                                    <div class="navbar-right">
                                                        <asp:Button runat="server" ID="btnAddDocument" Text="Aggiungi" CssClass="btn btn-success btn-xs" CausesValidation="false" OnClick="btnAddDocument_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel-body" style="max-height: 300px; overflow: auto;">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                        ItemType="VALE.Models.UserFile" AllowPaging="true" PageSize="10" EmptyDataText="Non ci sono documenti allegati."
                                                        CssClass="table table-striped table-bordered"
                                                        OnRowCommand="DocumentsGridView_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="FileName" HeaderStyle-Width="25%">
                                                                <ItemTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.UserFileID %>" CommandName="DOWNLOAD" CausesValidation="false"><%#: Item.FileName %></asp:LinkButton></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="300px"></HeaderStyle>
                                                                <ItemStyle Width="300px"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="FileDescription" HeaderText="Descrizione" />
                                                            <asp:TemplateField HeaderText="Azione" HeaderStyle-Width="50px" ItemStyle-Width="50px">
                                                                <ItemTemplate>
                                                                    <center><div><asp:Button  runat="server" Text="Cancella" CssClass="btn btn-danger btn-xs" CommandArgument="<%# Item.UserFileID %>" CommandName="Cancella" CausesValidation="false" /></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="50px"></HeaderStyle>
                                                                <ItemStyle Width="50px"></ItemStyle>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerSettings Position="Bottom" />
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupAddImage" runat="server"
                PopupControlID="pnlPopupAddImage" TargetControlID="lnkDummyAddImage" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyAddImage" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupAddImage" style="width: 30%;">
                <div class="row">
                    <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Saleziona la foto</strong></asp:Label>
                    <div class="col-md-12">
                        <br />
                    </div>
                    <div class="col-md-12">
                        <asp:FileUpload ID="FileUploadAddImage" runat="server" CssClass="well well-sm"></asp:FileUpload>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-7 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpAddImage" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="btnPopUpAddImage_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpAddImageClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpAddImageClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnPopUpAddImage" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupModifyDescription" runat="server"
                PopupControlID="pnlPopupModifyDescription" TargetControlID="lnkDummyModifyDescription" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyModifyDescription" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupModifyDescription" style="width: 60%;">
                <div class="row">
                    <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Presentazione </strong></asp:Label>
                    <div class="col-md-12">
                        <br />
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtDescription" runat="server"></asp:TextBox>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpModifyDescription" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="btnPopUpModifyDescription_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpModifyDescriptionClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpModifyDescriptionClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupAddDocument" runat="server"
                PopupControlID="pnlPopupAddDocument" TargetControlID="lnkDummyPopupAddDocument" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupAddDocument" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupAddDocument" style="width: 60%;">
                <div class="row">
                    <div class="col-md-12">
                        <legend>Allega un documento</legend>
                    </div>
                    <div class="col-md-12">
                        <br />
                        <asp:ValidationSummary runat="server"></asp:ValidationSummary>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">File *</label>
                        <div class="col-md-10">
                            <asp:FileUpload ID="FileUploadAddDocument" runat="server" CssClass="well well-sm"></asp:FileUpload>
                            <asp:Label ID="LabelPopUpAddDocumentError" CssClass="text-danger" runat="server" visible="false"></asp:Label>
                        </div>
                    </div>

                        <div class="form-group">
                            <label class="col-md-2 control-label">File pubblico?</label>
                            <div class="col-md-10">
                                <asp:CheckBox runat="server" ID="chkPublic" />
                            </div>
                    </div>
                    <div class="col-md-12">
                        <br />
                    </div>
                    <div class="form-group">
                        <br />
                        <label class="col-md-2 control-label">Descrizione *</label>
                        <div class="col-md-10">
                            <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtFileDescription" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFileDescription" CssClass="text-danger" ValidationGroup="AddDocumentPopUp" ErrorMessage="Il campo Descrizione è obbligatorio." />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpAddDocument" CssClass="btn btn-success btn-sm" ValidationGroup="AddDocumentPopUp" OnClick="btnPopUpAddDocument_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpAddDocumentClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpAddDocumentClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnPopUpAddDocument" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupChangePassword" runat="server"
                PopupControlID="pnlPopupChangePassword" TargetControlID="lnkDummyPopupChangePassword" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupChangePassword" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupChangePassword" style="width: 50%;">
                <div class="row">
                    <div class="col-md-12">
                        <legend>Modifica Password</legend>
                    </div>
                    <div class="col-md-12">
                        <asp:Label ID="lblChangePasswordError" CssClass="text-danger" runat="server" visible="false"></asp:Label>
                        <br />
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="CurrentPassword" CssClass="col-md-4 control-label">Password Attuale *</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" Width="227px" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword" ValidationGroup="ModifyPassword" 
                                CssClass="text-danger" ErrorMessage="Il campo Password è obbligatorio." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="NewPassword" CssClass="col-md-4 control-label">Nuova Password *</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" Width="227px" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword" ValidationGroup="ModifyPassword"
                                CssClass="text-danger" ErrorMessage="Il campo Password è obbligatorio." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-4 control-label">Conferma Nuova Password *</asp:Label>
                        <div class="col-md-8">
                            <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" Width="227px" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword" ValidationGroup="ModifyPassword"
                                CssClass="text-danger col-md-12" ErrorMessage="Il campo Conferma Password è obbligatorio" />
                            <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmPassword" ValidationGroup="ModifyPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="La password e la password di conferma non coincidonno." />
                        </div>
                    </div>
                    <div class="col-md-12">
                        <br />
                    </div>
                    
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpModifyPassword" CssClass="btn btn-success btn-sm" ValidationGroup="ModifyPassword" OnClick="btnPopUpModifyPassword_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpModifyPasswordClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpModifyPasswordClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupModifyPersonalData" runat="server"
                PopupControlID="pnlPopupModifyPersonalData" TargetControlID="lnkDummyPopupModifyPersonalData" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupModifyPersonalData" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupModifyPersonalData" style="width: 50%; height: 80%; overflow-y: scroll; overflow-x: hidden">
                <div class="row">
                    <div class="col-md-12">
                        <legend>Aggiorna Dati Personali</legend>
                    </div>
                    <div class="col-md-12">
                        <asp:Label ID="Label1" CssClass="text-danger" runat="server" Visible="false"></asp:Label>
                        <br />
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextFirstName" CssClass="col-md-12 control-label">Nome *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextFirstName" CssClass="form-control" Width="300px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName" ValidationGroup="ModifyPersonalData"
                                    CssClass="text-danger" ErrorMessage="Il campo Nome è obbligatorio." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextLastName" CssClass="col-md-12 control-label">Cognome *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextLastName" CssClass="form-control" Width="300px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLastName" ValidationGroup="ModifyPersonalData"
                                    CssClass="text-danger" ErrorMessage="Il campo Cognome è obbligatorio." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextCF" ID="lblCF" CssClass="col-md-12 control-label">Codice Fiscale</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextCF" CssClass="form-control" Width="240px" MaxLength="16" />
                                <asp:RegularExpressionValidator Enabled="false" ID="FiscalCodeToValidate" ControlToValidate="TextCF" runat="server" ErrorMessage="Formato del Codice Fiscale non corretto."
                                    CssClass="text-danger" ValidationExpression="^[a-zA-Z0-9]{16}$" Display="Dynamic" ValidationGroup="ModifyPersonalData"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-12 control-label">E-mail *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" ValidationGroup="ModifyPersonalData"
                                    CssClass="text-danger col-md-12" ErrorMessage="Il campo E-mail è obbligatorio." />
                                <asp:RegularExpressionValidator
                                    runat="server" CssClass="text-danger"
                                    ErrorMessage="Formato non corretto." ControlToValidate="Email"
                                    SetFocusOnError="True" Display="Dynamic" ValidationGroup="ModifyPersonalData"
                                    ValidationExpression="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextCellPhone" CssClass="col-md-12 control-label">Cellulare *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextCellPhone" CssClass="form-control" Width="173px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextCellPhone" ValidationGroup="ModifyPersonalData"
                                    CssClass="text-danger" ErrorMessage="Il campo Cellulare è obbligatorio." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextTelephone" CssClass="col-md-12 control-label">Telefono</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextTelephone" CssClass="form-control" Width="147px" />
                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Region" CssClass="col-md-12 control-label">Regione</asp:Label>
                            <div class="col-md-8">
                                <asp:DropDownList runat="server" class="form-control" ID="Region" AutoPostBack="True" OnSelectedIndexChanged="Region_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Province" CssClass="col-md-12 control-label">Provincia</asp:Label>
                            <div class="col-md-8">
                                <asp:DropDownList runat="server" class="form-control" ID="Province" AutoPostBack="True" OnSelectedIndexChanged="Province_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="City" CssClass="col-md-12 control-label">Comune</asp:Label>
                            <div class="col-md-8">
                                <asp:DropDownList runat="server" class="form-control" ID="City">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextAddress" CssClass="col-md-12 control-label">Indirizzo</asp:Label>
                            <div class="col-md-12">
                                <asp:TextBox runat="server" ID="TextAddress" CssClass="form-control" />
                            </div>
                        </div>
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div runat="server" id="pnlPartner">
                            <legend>Dati Sociazione</legend>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <asp:Label runat="server" AssociatedControlID="checkAssociated" CssClass="col-md-2 control-label">Socio  </asp:Label>
                                        <asp:CheckBox runat="server" ID="checkAssociated" CssClass="col-md-2" AutoPostBack="true" OnCheckedChanged="checkAssociated_CheckedChanged" />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <br />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group" runat="server" id="pnlPartnerType">
                                        <asp:Label runat="server" AssociatedControlID="ddlPartnerType" CssClass="col-md-12 control-label">Tipo di Socio </asp:Label>
                                        <div class="col-md-8">
                                            <asp:DropDownList runat="server" CssClass="form-control" ID="ddlPartnerType" SelectMethod="ddlPartnerType_GetData" DataTextField="PartnerTypeName" DataValueField="PartnerTypeName"></asp:DropDownList>
                                        </div>
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
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopupModifyPersonalData" CssClass="btn btn-success btn-sm" ValidationGroup="ModifyPersonalData" OnClick="btnPopupModifyPersonalData_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopupModifyPersonalDataClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopupModifyPersonalDataClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
