<%@ Page Title="Registrazione con login esterno" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterExternalLogin.aspx.cs" Inherits="VALE.Account.RegisterExternalLogin" Async="true" %>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
       <div class="container">
        <div class="bs-docs-section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="page-header">
                        <h1 id="forms">Registrazione</h1>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6">
                    <div class="well bs-component">                            
                        <fieldset>
                            <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                                <legend><span class="glyphicon glyphicon-credit-card"></span> Dati di Login</legend>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="TextUserName" CssClass="col-md-12 control-label">Nome Utente *</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="TextUserName" CssClass="form-control" Width="227px" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextUserName"
                                            CssClass="text-danger" ErrorMessage="Il campo Nome Utente è obbligatorio." />
                                    </div>
                                </div>
                                <legend><span class="glyphicon glyphicon-star"></span> Richiesta di associazione</legend>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="checkAssociated" CssClass="col-md-6 control-label">Vuoi aderire all'associazione?  </asp:Label>
                                    <asp:CheckBox runat="server" ID="checkAssociated" CssClass="col-md-2" AutoPostBack="true" OnCheckedChanged="checkAssociated_CheckedChanged"/>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="TextCF" ID="lblCF" CssClass="col-md-12 control-label">Codice Fiscale</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="TextCF" CssClass="form-control" Width="240px" MaxLength="16" />
                                        <asp:RequiredFieldValidator Enabled="false" runat="server" ID="CFValidator" ControlToValidate="TextCF"
                                            CssClass="text-danger col-md-12" ErrorMessage="Il campo Codice Fiscale è obbligatorio." />
                                        <asp:RegularExpressionValidator Enabled="false" ID="FiscalCodeToValidate" ControlToValidate="TextCF" runat="server" ErrorMessage="Formato del Codice Fiscale non corretto."
                                        CssClass="text-danger" ValidationExpression="^[a-zA-Z0-9]{16}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>
                                <legend><span class="glyphicon glyphicon-user"></span> Dati anagrafici</legend>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="TextFirstName" CssClass="col-md-12 control-label">Nome *</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="TextFirstName" CssClass="form-control" Width="300px" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName"
                                            CssClass="text-danger" ErrorMessage="Il campo Nome è obbligatorio." />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="TextLastName" CssClass="col-md-12 control-label">Cognome *</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="TextLastName" CssClass="form-control" Width="300px" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLastName"
                                            CssClass="text-danger" ErrorMessage="Il campo Cognome è obbligatorio." />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-12 control-label">E-mail *</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                            CssClass="text-danger col-md-12" ErrorMessage="Il campo E-mail è obbligatorio." />
                                        <asp:RegularExpressionValidator
                                            runat="server" CssClass="text-danger"
                                            ErrorMessage="Formato non corretto." ControlToValidate="Email"
                                            SetFocusOnError="True" Display="Dynamic"
                                            ValidationExpression="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}">
                                        </asp:RegularExpressionValidator>
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
                                    <asp:Label runat="server" AssociatedControlID="TextCellPhone" CssClass="col-md-12 control-label">Cellulare *</asp:Label>
                                    <div class="col-md-10">
                                        <asp:TextBox runat="server" ID="TextCellPhone" CssClass="form-control" Width="173px" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TextCellPhone"
                                            CssClass="text-danger" ErrorMessage="Il campo Cellulare è obbligatorio." />
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <div class="col-md-offset-8 col-md-10">
                                        <p><br />
                                            <asp:Button runat="server" OnClick="CreateUser_Click"  Text="Registra" CssClass="btn btn-default" />
                                            <asp:Button runat="server" CssClass="btn btn-danger"  Text="Annulla" ID="btnCancel" CausesValidation="false"  OnClick="btnCancel_Click" />
                                        </p>
                                    </div>
                                </div>
                            </fieldset>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="well bs-component">
                        <legend><span class="glyphicon glyphicon-info-sign"></span> Dati di login</legend>
                        <lu>
                            <li>
                                Il nome utente assegnato di default, può essere modificato.
                            </li>
                        </lu>
                        <br />
                        <legend><span class="glyphicon glyphicon-info-sign"></span> Richiesta di associazione</legend>
                        <lu>
                            <li>
                                Nel caso in cui viene richiesta l'associazione, il Codice Fiscale è richiesto.
                            </li>
                        </lu>
                        <br />
                        <br />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
