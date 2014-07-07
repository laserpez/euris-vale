<%@ Page Title="Menage Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MenageProfile.aspx.cs" Inherits="VALE.MenageProfile" %>
<%@ Register Src="~/MyVale/FileUploader.ascx" TagPrefix="uc" TagName="FileUploader" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Modifica il tuo profilo"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div class="col-md-12 form-group">
                                        <legend class="h4"><b>Foto profilo</b></legend>
                                        <div class="col-md-12">
                                            <br />
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group col-lg-5">
                                                    <div class="input-group">
                                                        <span class="input-group-addon input-sm"><span class="glyphicon glyphicon-file"></span></span>
                                                        <div runat="server" id="FileTextBox">
                                                            <asp:FileUpload ID="FileUploadPhoto" runat="server" CssClass="form-control input-sm" />
                                                        </div>
                                                        <span class="input-group-btn">
                                                            <asp:Button runat="server" ID="AddFileNameButton" ValidationGroup="UploadFile" CssClass="btn btn-default btn-sm" Text="Aggiungi" OnClick="AddFileNameButton_Click" />
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div id="photoEdit" class="col-md-2">
                                            <div style="border: ridge; height: 122px; width: 112px">
                                                <div id="photo" style="border: thin; height: 114px; width: 104px">
                                                    <img id="picProfile" runat="server" height="114" width="104" />
                                                </div>
                                            </div>
                                        </div>
                                        <div id="groupBtn" class="col-md-10">
                                            <asp:Button runat="server" ID="RemovePhoto" CausesValidation="false" CssClass="btn btn-danger btn-xs" Text="Cancella" OnClick="RemovePhoto_Click" />
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="AddFileNameButton" />
                                </Triggers>
                            </asp:UpdatePanel>
                            
                            <div class="col-md-12 form-group">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-danger" ShowMessageBox="true" ShowSummary="false" ValidationGroup="Submit" />
                                <div id="PersonalData">
                                    <legend class="h4" ><b>Dati personali</b></legend>
                                    <div class="col-md-12"><br /></div>
                                    <asp:FormView runat="server" ID="PersonalDataFormView" CssClass="col-md-12" ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun dato presente." SelectMethod="GetUserData">
                                        <ItemTemplate>
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Nome utente:\t{0}", Item.UserName) %></asp:Label><br />
                                            <p></p>
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Nome:\t{0}", Item.FirstName) %></asp:Label><br />
                                            <p></p>
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Cognome:\t{0}", Item.LastName) %></asp:Label><br />
                                            <p></p>
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Codice fiscale:\t{0}", Item.CF) %></asp:Label><br />
                                            <div class="col-md-12"><br /></div>
                                            <legend class="h5" ><b>Contatti</b></legend>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="E-mail: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditEmail" CssClass="form-control" runat="server" Text="<%#: Item.Email %>"></asp:TextBox></div><br />
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="EditEmail"
                                                CssClass="text-danger" ErrorMessage="Il campo Email è obbligatorio."  /><br />
                                            <asp:RegularExpressionValidator id="EmailToValidate" runat="server" ErrorMessage="Formato non corretto." CssClass="text-danger"
                                                ControlToValidate="EditEmail" ValidationExpression="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                            <div class="col-md-12"><br /></div>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Telefono: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditTelephone" CssClass="form-control" runat="server" Text="<%#: Item.Telephone %>"></asp:TextBox></div><br />
                                            <asp:RegularExpressionValidator runat="server" ControlToValidate="EditTelephone" CssClass="text-danger" 
                                                ValidationExpression="[0-9]{8,11}" ErrorMessage="Numero non valido." ></asp:RegularExpressionValidator>
                                            <div class="col-md-12"><br /></div>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Cellulare: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditCellPhone" CssClass="form-control" runat="server" Text="<%#: Item.CellPhone %>"></asp:TextBox></div><br />
                                            <asp:RegularExpressionValidator runat="server" ControlToValidate="EditCellPhone" CssClass="text-danger" 
                                                ValidationExpression="[0-9]{8,11}" ErrorMessage="Numero non valido." ></asp:RegularExpressionValidator>
                                            <div class="col-md-12"><br /></div>
                                            <legend class="h5" ><b>Recapito</b></legend>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Residenza: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditAdress" CssClass="form-control" runat="server" Text="<%#: Item.Address %>"></asp:TextBox></div><br />
                                            <div class="col-md-12"><br /></div>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Regione: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditRegion" CssClass="form-control" runat="server" Text="<%#: Item.Region %>"></asp:TextBox></div><br />
                                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="EditRegion"
                                                CssClass="text-danger" ErrorMessage="Il campo Regione è obbligatorio." />
                                            <div class="col-md-12"><br /></div>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Provincia: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditProvince" CssClass="form-control" runat="server" Text="<%#: Item.Province %>"></asp:TextBox></div><br />
                                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="EditProvince"
                                                CssClass="text-danger" ErrorMessage="Il campo Provincia è obbligatorio." />
                                            <div class="col-md-12"><br /></div>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Città: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditCity" runat="server" CssClass="form-control" Text="<%#: Item.City %>"></asp:TextBox></div><br />
                                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="EditCity"
                                                CssClass="text-danger" ErrorMessage="Il campo Città è obbligatorio." />
                                            <div class="col-md-12"><br /></div>
                                            <legend class="h5" ><b>Descrizione</b></legend>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Descrizione: "></asp:Label><div class="col-md-7"><asp:TextBox ID="EditDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Width="280px" Height="300px" Text="<%#: Item.Description %>"></asp:TextBox></div><br />
                                            <asp:RequiredFieldValidator runat="server" Display="Dynamic" ControlToValidate="EditDescription"
                                                CssClass="text-danger" ErrorMessage="Il campo Descrizione è obbligatorio." />
                                            <div class="col-md-12"><br /></div>
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <legend class="h5" ><b>Curriculum Vitae</b></legend>
                                            <asp:Label runat="server" CssClass="col-md-12" ID="CVEdit"></asp:Label><br />
                                            <div class="col-md-12"><br /></div>
                                            <div class="row">
                                            <div class="col-lg-12">
                                                <div class="form-group col-lg-5">
                                                    <div class="input-group">
                                                        <span class="input-group-addon input-sm"><span class="glyphicon glyphicon-file"></span></span>
                                                        <div runat="server" id="Div1">
                                                            <asp:FileUpload ID="FileUploadDocument" runat="server" CssClass="form-control input-sm" />
                                                        </div>
                                                        <span class="input-group-btn">
                                                            <asp:Button runat="server" ID="AddCVButton" ValidationGroup="UploadFile" CssClass="btn btn-default btn-sm" Text="Aggiungi" OnClick="AddCVButton_Click" />
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="AddCVButton" />
                                        </Triggers>
                                    </asp:UpdatePanel>

                                    <div class="col-md-12"><br /></div>

                                    <legend class="h5" ><b>Cambia la password</b></legend>
                                    <div class="form-group">
                                        <asp:Label runat="server" ID="CurrentPasswordLabel" CssClass="col-md-1 control-label">Password corrente: </asp:Label>
                                        <div class="col-md-11">
                                            <asp:TextBox runat="server" ID="CurrentPassword" TextMode="Password" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                                CssClass="text-danger" ErrorMessage="Il campo password corrente è richiesto."
                                                ValidationGroup="ChangePassword" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    <asp:Label runat="server" ID="NewPasswordLabel" CssClass="col-md-1 control-label">Nuova password: </asp:Label>
                                    <div class="col-md-11">
                                        <asp:TextBox runat="server" ID="NewPassword" TextMode="Password" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                            CssClass="text-danger" ErrorMessage="Il campo nuova password è richiesto."
                                            ValidationGroup="ChangePassword" />
                                    </div>
                                </div>
                                    <div class="form-group">
                                        <asp:Label runat="server" ID="ConfirmNewPasswordLabel" CssClass="col-md-1 control-label">Conferma nuova password: </asp:Label>
                                        <div class="col-md-11">
                                            <asp:TextBox runat="server" ID="ConfirmNewPassword" TextMode="Password" CssClass="form-control" />
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                                CssClass="text-danger" Display="Dynamic" ErrorMessage="Il campo conferma nuova password è richiesto."
                                                ValidationGroup="ChangePassword" />
                                            <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                                CssClass="text-danger" Display="Dynamic" ErrorMessage="I campi nuova password e conferma nuova password non sono uguali."
                                                ValidationGroup="ChangePassword" />
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-12"><br /></div>
                            <asp:Panel  runat="server" ID="requestAssociation">
                                <legend class="h4" ><b>Richiesta socio</b></legend>
                                <asp:Label runat="server">Qui puoi inviare una richiesta all'amministratore per diventare un utente socio. </asp:Label><br />
                                <asp:Label runat="server">Un utente socio può creare progetti, eventi ed attività personali. </asp:Label><br />
                                <asp:Button runat="server" ID="btnRequestAssociation" CausesValidation="false" CssClass="btn btn-info btn-xs" OnClick="btnRequestAssociation_Click" Text="Richiesta socio" /><br />
                            </asp:Panel>
                            <div class="col-md-12"><br /></div>
                            <section id="externalLoginsForm">
                                <legend class="h4"><b>Altri login</b></legend>
                                <asp:ListView runat="server"
                                    ItemType="Microsoft.AspNet.Identity.UserLoginInfo"
                                    SelectMethod="GetLogins" DeleteMethod="RemoveLogin" DataKeyNames="LoginProvider,ProviderKey">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%#: Item.LoginProvider %></td>
                                            <td>
                                                <asp:Button runat="server" Text="Remove" CommandName="Delete" CausesValidation="false"
                                                    ToolTip='<%# "Rimuovi questo login " + Item.LoginProvider + " dal tuo account" %>'
                                                    Visible="<%# CanRemoveExternalLogins %>" CssClass="btn btn-danger btn-xs" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:ListView>
                                <div class="col-md-12"><br /></div>
                                <uc:OpenAuthProviders runat="server" ReturnUrl="~/Account/MenageProfile" />
                            </section>

                            <br />
                            <br />
                            <br />
                            <br />
                            <div class="col-md-12 form-group">
                                <div id="SaveChanges">
                                    <asp:Button runat="server" ID="SaveChangesProfile" CssClass="btn btn-info btn-sm" Text="Salva" Visible="true" OnClick="SaveChangesProfile_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
