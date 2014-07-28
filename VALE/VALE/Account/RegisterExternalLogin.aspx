<%@ Page Title="Registrazione con login esterno" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterExternalLogin.aspx.cs" Inherits="VALE.Account.RegisterExternalLogin" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h3>Registrati con <%: ProviderName %> account</h3>

    <asp:PlaceHolder runat="server">
        <div class="form-horizontal">
            <h4>Modulo di registrazione</h4>
            <hr />
            <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
            <p class="text-info">
                Sei autenticato con <strong><%: ProviderName %></strong>. Per favore, completa il modulo di registrazione e clicca il pulsante di Log In.
            </p>

            <p class="text-danger">
                <asp:literal runat="server" id="errormessage" />
            </p>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="TextUserName" CssClass="col-md-1 control-label">UserName*</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextUserName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextUserName"
                        CssClass="text-danger" ErrorMessage="Il campo UserName è obbligatorio." />
                </div>
                <asp:Label runat="server" AssociatedControlID="TextEmail" CssClass="col-md-1 control-label">Email *</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextEmail" CssClass="form-control" TextMode="Email" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextEmail"
                        CssClass="text-danger" ErrorMessage="Il campo Email è obbligatorio." /><br />
                    <asp:RegularExpressionValidator id="EmailToValidate" runat="server" ErrorMessage="Formato non corretto." CssClass="text-danger"
                    ControlToValidate="TextEmail" ValidationExpression="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="TextFirstName" CssClass="col-md-1 control-label">Nome*</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextFirstName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName"
                        CssClass="text-danger" ErrorMessage="Il campo Nome è obbligatorio." /><br />
                    <asp:RegularExpressionValidator ID="TextFirstNameToValidate" runat="server" ErrorMessage="Formato non corretto." CssClass="text-danger"
                        ControlToValidate="TextFirstName" ValidationExpression="^[a-zA-Z\s]+" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
                <asp:Label runat="server" AssociatedControlID="TextLastName" CssClass="col-md-1 control-label">Cognome*</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextLastName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLastName"
                        CssClass="text-danger" ErrorMessage="Il campo Cognome è obbligatorio." /><br />
                    <asp:RegularExpressionValidator ID="LastNameToValidate" runat="server" ErrorMessage="Formato non corretto." CssClass="text-danger"
                        ControlToValidate="TextLastName" ValidationExpression="^[a-zA-Z\-'.,\s]+" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="TextTelephone" CssClass="col-md-1 control-label">Telefono</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox TextMode="Number" runat="server" ID="TextTelephone" CssClass="form-control" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="TextTelephone" CssClass="text-danger"
                        ValidationExpression="[0-9]{8,11}" ErrorMessage="Numero non valido."></asp:RegularExpressionValidator>
                </div>
                <asp:Label runat="server" AssociatedControlID="TextCellPhone" CssClass="col-md-1 control-label">Cellulare</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox TextMode="Number" runat="server" ID="TextCellPhone" CssClass="form-control" /><br />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="TextCellPhone" CssClass="text-danger"
                        ValidationExpression="[0-9]{8,11}" ErrorMessage="Numero non valido" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>


            <div class="form-group">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>

                        <asp:Label runat="server" AssociatedControlID="DropDownRegion" CssClass="col-md-1 control-label">Regione*</asp:Label>
                        <div class="col-md-3">
                            <asp:DropDownList runat="server" class="form-control" ID="DropDownRegion" AutoPostBack="True" OnSelectedIndexChanged="Region_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator InitialValue="Seleziona" runat="server" ControlToValidate="DropDownRegion"
                                CssClass="text-danger" ErrorMessage="Seleziona la Regione." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="DropDownProvince" CssClass="col-md-1 control-label">Provincia*</asp:Label>
                        <div class="col-md-3">
                            <asp:DropDownList runat="server" class="form-control" ID="DropDownProvince" AutoPostBack="True" OnSelectedIndexChanged="State_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator InitialValue="Seleziona" runat="server" ControlToValidate="DropDownProvince"
                                CssClass="text-danger" ErrorMessage="Seleziona la Provincia." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="DropDownCity" CssClass="col-md-1 control-label">Città*</asp:Label>
                        <div class="col-md-3">
                            <asp:DropDownList runat="server" class="form-control" ID="DropDownCity">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator InitialValue="Seleziona" runat="server" ControlToValidate="DropDownCity"
                                CssClass="text-danger" ErrorMessage="Seleziona la Città." />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="TextAddress" CssClass="col-md-1 control-label">Indirizzo*</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextAddress" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextAddress"
                        CssClass="text-danger" ErrorMessage="Il campo Indirizzo è obbligatorio." />
                </div>
                <asp:Label runat="server" AssociatedControlID="TextCF" CssClass="col-md-1 control-label">Codice fiscale*</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextCF" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextCF"
                        CssClass="text-danger" ErrorMessage="Il campo Codice Fiscale è obbligatorio." /><br />
                    <asp:RegularExpressionValidator ID="FiscalCodeToValidate" ControlToValidate="TextCF" runat="server" ErrorMessage="Formato non corretto."
                    CssClass="text-danger" ValidationExpression="^[a-zA-Z0-9]{16}$" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-1 control-label">Password*</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                        CssClass="text-danger" ErrorMessage="Il campo password è obbligatorio." />
                </div>
                <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-1 control-label">Conferma password*</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="Il campo conferma password è obbligatorio." />
                    <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="La password e la password di conferma non coincidono." />
                </div>
            </div>
            <br />
            <br />
        <div class="col-md-5"></div>
        <asp:Label runat="server" AssociatedControlID="checkAssociated">Richiesta di associazione&nbsp</asp:Label>
        <asp:CheckBox runat="server" ID="checkAssociated" />
        <br />
        <div class="col-md-5"></div>
        <asp:Button runat="server" Text="Log in" CssClass="btn btn-info col-md-2" OnClick="LogIn_Click" />
        </div>
    </asp:PlaceHolder>
    <br />
    <br />

</asp:Content>
