<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddNewUser.ascx.cs" Inherits="VALE.MyVale.Create.AddNewUser" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

<%--PopUp--%>
<asp:UpdatePanel ID="UpdatePanelAdd" runat="server">
    <ContentTemplate>
        <asp:Button runat="server" CausesValidation="false" ID="AddUser" Text="Aggiungi un nuovo utente" Width="170" CssClass="btn btn-primary dropdown-toggle btn-sm" OnClick="AddNewUser_Click" />

        <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
        <asp:ModalPopupExtender ID="ModalPopup" BehaviorID="mpe" runat="server"
            PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
        </asp:ModalPopupExtender>
        <div class="panel panel-primary" id="pnlPopup" style="width: 80%;">
            <div class="panel-heading">
                <asp:Label ID="TitleModalView" runat="server" Text="Aggiungi un utente"></asp:Label>
                <asp:Button runat="server" ID="CloseButton" CssClass="close" OnClick="CloseButton_Click" Text="x" CausesValidation="false" />
            </div>
            <div class="panel-body" style="height:400px; overflow-y:scroll; overflow-x:hidden">
                <div class="form-horizontal">
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="ErrorMessage" />
                    </p>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="TextUserName" CssClass="col-md-1 control-label">UserName</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="TextUserName" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="TextUserName" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Il campo UserName è obbligatorio." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-1 control-label">Email</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Il campo Email è obbligatorio." /><br />
                            <asp:RegularExpressionValidator ID="EmailToValidate" runat="server" ErrorMessage="Formato non corretto." CssClass="text-danger"
                                ControlToValidate="Email" ValidationExpression="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}" Display="Dynamic" SetFocusOnError="true"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="TextFirstName" CssClass="col-md-1 control-label">Nome</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="TextFirstName" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Il campo Nome è richiesto." /><br />
                            <asp:RegularExpressionValidator ID="TextFirstNameToValidate" runat="server" ErrorMessage="Inserire solo caratteri alfabetici e\o numerici." CssClass="text-danger"
                                ControlToValidate="TextFirstName" ValidationExpression="^[a-zA-Z]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                        <asp:Label runat="server" AssociatedControlID="TextLastName" CssClass="col-md-1 control-label">Cognome</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="TextLastName" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLastName" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Il campo Cognome è obbligatorio." /><br />
                            <asp:RegularExpressionValidator ID="LastNameToValidate" runat="server" ErrorMessage="Inserire solo caratteri alfabetici e\o numerici." CssClass="text-danger"
                                ControlToValidate="TextLastName" ValidationExpression="^[a-zA-Z]*$" Display="Dynamic"></asp:RegularExpressionValidator>
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
                            <asp:TextBox TextMode="Number" runat="server" ID="TextCellPhone" CssClass="form-control" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="TextCellPhone" CssClass="text-danger"
                                ValidationExpression="[0-9]{8,11}" ErrorMessage="Numero non valido."></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>

                                <asp:Label runat="server" AssociatedControlID="DropDownRegion" CssClass="col-md-1 control-label">Regione</asp:Label>
                                <div class="col-md-3">
                                    <asp:DropDownList runat="server" class="form-control" ID="DropDownRegion" AutoPostBack="True" OnSelectedIndexChanged="Region_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator InitialValue="Seleziona" runat="server" ControlToValidate="DropDownRegion" Display="Dynamic"
                                        CssClass="text-danger" ErrorMessage="Seleziona la Regione." />
                                </div>
                                <asp:Label runat="server" AssociatedControlID="DropDownProvince" CssClass="col-md-1 control-label">Provincia</asp:Label>
                                <div class="col-md-3">
                                    <asp:DropDownList runat="server" class="form-control" ID="DropDownProvince" AutoPostBack="True" OnSelectedIndexChanged="State_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator InitialValue="Seleziona" runat="server" ControlToValidate="DropDownProvince" Display="Dynamic"
                                        CssClass="text-danger" ErrorMessage="Seleziona la Provincia." />
                                </div>
                                <asp:Label runat="server" AssociatedControlID="DropDownCity" CssClass="col-md-1 control-label">Città</asp:Label>
                                <div class="col-md-3">
                                    <asp:DropDownList runat="server" class="form-control" ID="DropDownCity">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator InitialValue="Seleziona" runat="server" ControlToValidate="DropDownCity" Display="Dynamic"
                                        CssClass="text-danger" ErrorMessage="Seleziona la Città." />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="TextAddress" CssClass="col-md-1 control-label">Indirizzo</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="TextAddress" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="TextAddress" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Il campo Indirizzo è obbligatorio." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="TextCF" CssClass="col-md-1 control-label">Codice fiscale</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="TextCF" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="TextCF"
                                CssClass="text-danger" ErrorMessage="Il Codice fiscale è obbligatorio." Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="FiscalCodeToValidate" ControlToValidate="TextCF" runat="server" ErrorMessage="Formato non corretto."
                                CssClass="text-danger" ValidationExpression="^[a-zA-Z0-9]{16}$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-1 control-label">Password</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" Display="Dynamic"
                                CssClass="text-danger" ErrorMessage="Il campo Password è obbligatorio." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-1 control-label">Conferma password</asp:Label>
                        <div class="col-md-3">
                            <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="Il campo conferma password è obblligatorio." />
                            <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="La password e la password di conferma non coincidonno." />
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="SelectRole" CssClass="col-md-1 control-label">Assegna un ruolo</asp:Label>
                            <div class="col-md-3">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="DropDownSelectRole"></asp:DropDownList>
                                <asp:Label ID="SelectRole" runat="server" CssClass="text-danger"></asp:Label>
                                <asp:RequiredFieldValidator InitialValue="Seleziona" runat="server" ControlToValidate="DropDownSelectRole" Display="Dynamic"
                                    CssClass="text-danger" ErrorMessage="Seleziona il ruolo." />
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="col-md-5"></div>
                    <asp:Button runat="server" ID="CreateUser" OnClick="CreateUser_Click" Text="Registrazione" CssClass="btn btn-info col-md-2" />
                </div>
                </div>
            </div>
    </ContentTemplate>
</asp:UpdatePanel>
<%--End PopUp--%>