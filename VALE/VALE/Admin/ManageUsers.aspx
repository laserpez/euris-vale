<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VALE.Admin.ManageUsers" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/AddNewUser.ascx" TagPrefix="uc" TagName="AddNewUser" %>

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
                                            <div class="col-lg-6">
                                                <ul class="nav nav-pills">
                                                    <li>
                                                        <h4><span class="badge" runat="server" id="NotificationNumber"></span>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Gestione Utenti"></asp:Label></h4>
                                                    </li>
                                                </ul>
                                            </div>
                                            <asp:Label ID="TypeOfListUsers" runat="server" Visible="false"></asp:Label>
                                            <div class="navbar-right">
                                                <div class="btn-group" runat="server" id="AddNewUserMenagement" >
                                                    <asp:Button runat="server" CausesValidation="false" ID="btnAddUser" Text="Nuovo utente" CssClass="btn btn-success dropdown-toggle btn-sm" OnClick="btnAddUser_Click" />
                                                </div>
                                                <div class="btn-group">
                                                    <asp:Label ID="ListUsersType" Visible="false" runat="server" Text=""></asp:Label>
                                                    <button type="button" visible="true" id="btnSelectUsersType" class="btn btn-primary dropdown-toggle btn-sm" data-toggle="dropdown" runat="server">Tutti  <span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <asp:LinkButton CommandArgument="All" runat="server" OnClick="GetSelectedUsers_Click" CausesValidation="false"><span class="glyphicon glyphicon-hdd btn-sm"></span> Tutti</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton CommandArgument="Administrators" runat="server" OnClick="GetSelectedUsers_Click" CausesValidation="false"><span class="glyphicon glyphicon-star btn-sm"></span> Amministratori  </asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton CommandArgument="Associates" runat="server" OnClick="GetSelectedUsers_Click" CausesValidation="false"><span class="glyphicon glyphicon-user btn-sm"></span> Soci  </asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton CommandArgument="Board" runat="server" OnClick="GetSelectedUsers_Click" CausesValidation="false"><span class="glyphicon glyphicon-user btn-sm"></span> Consiglio Direttivo</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton CommandArgument="Requests" runat="server" OnClick="GetSelectedUsers_Click" CausesValidation="false"><span class="glyphicon glyphicon-plus-sign btn-sm"></span>  Richieste  </asp:LinkButton></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel-body">
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="grdUsers" runat="server" DataKeyNames="UserName" AutoGenerateColumns="false" AllowSorting="true" GridLines="Both" AllowPaging="true" PageSize="10" OnPageIndexChanging="grdUsers_PageIndexChanging"
                                                ItemType="VALE.Models.ApplicationUser" OnRowCommand="grdUsers_RowCommand" EmptyDataText="Nessun utente" CssClass="table table-striped table-bordered" OnSorting="grdUsers_Sorting">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="UserName" CommandName="sort" runat="server" ID="labelUserName"><span  class="glyphicon glyphicon-credit-card"></span> UserName</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.UserName %>"><asp:Label ID="labelUserName" runat="server" Text="<%#: Item.UserName %>"></asp:Label></a></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="FirstName" CommandName="sort" runat="server" ID="labelFirstName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.FirstName %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="LastName" CommandName="sort" runat="server" ID="labelLastName"><span  class="glyphicon glyphicon-user"></span> Cognome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.LastName %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="CellPhone" CommandName="sort" runat="server" ID="labelCellPhone"><span  class="glyphicon glyphicon-phone"></span> Cellulare</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.CellPhone %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="IsPartner" CommandName="sort" runat="server" ID="labelIsPartner"><span  class="glyphicon glyphicon-briefcase"></span> Socio</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <div class="btn-group">
                                                                <button type="button" class="btn btn-primary dropdown-toggle btn-xs" style="width: 70px" data-toggle="dropdown" runat="server"><%#: Item.IsPartner ? "Si" : "No" %><span class="caret">&nbsp;&nbsp;</span></button>
                                                                <ul class="dropdown-menu">
                                                                    <li>
                                                                        <asp:LinkButton CommandName="Yes" runat="server" CommandArgument="<%#: Item.UserName %>" CausesValidation="false"><span class="glyphicon glyphicon-ok-circle"></span>    Si   </asp:LinkButton></li>
                                                                    <li>
                                                                        <asp:LinkButton CommandName="No" runat="server" CommandArgument="<%#: Item.UserName %>" CausesValidation="false"><span class="glyphicon glyphicon-remove-circle"></span>    No   </asp:LinkButton></li>
                                                                </ul>
                                                            </div>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="80px" />
                                                        <HeaderStyle Width="80px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="PartnerType" CommandName="sort" runat="server" ID="labelPartnerType"><span  class="glyphicon glyphicon-tasks"></span> Tipo Socio</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.IsPartner ? Item.PartnerType : ""   %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="LastLoginDate" CommandName="sort" runat="server" ><span  class="glyphicon glyphicon-log-in"></span> Ultimo LogIn</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server" ToolTip="<%#: Item.LastLoginTimeString %>"><%#: Item.LastLoginDateString %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="Ruolo" CommandName="sort" runat="server" ID="labelRuolo"><span  class="glyphicon glyphicon-cog"></span> Ruolo</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <div class="btn-group">
                                                                <div class="navbar-right">
                                                                    <button id="AllListRoles" class="btn btn-primary dropdown-toggle btn-xs" data-toggle="dropdown" runat="server" style="width: 140px"><%# GetRoleName(Item.Id) %><span class="caret"></span></button>
                                                                    <ul class="dropdown-menu">
                                                                        <asp:ListView runat="server" ID="roleList" ItemType="Microsoft.AspNet.Identity.EntityFramework.IdentityRole" SelectMethod="GetRoles">
                                                                            <ItemTemplate>
                                                                                <li>
                                                                                    <asp:LinkButton ID="btnRole" CommandArgument='<%#: Item.Name %>' runat="server" OnClick="btnChangeUser_Click" CausesValidation="false"><span class="glyphicon glyphicon-plus-sign"> <%#: Item.Name %></span>  </asp:LinkButton></li>
                                                                            </ItemTemplate>
                                                                        </asp:ListView>
                                                                    </ul>
                                                                </div>
                                                            </div>
                                                            </center>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="150px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server"><span  class="glyphicon glyphicon-check"></span></asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:CheckBox runat="server" ID="chkSelectUser"/></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings Position="Bottom" />
                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:Button ID="btnConfirmUser" Visible="false" runat="server" Text="Conferma utenti selezionati" CssClass="btn btn-primary" CausesValidation="false" OnClick="btnConfimUser_Click" />
                                    <asp:Label ID="lblChangeRole" runat="server" Visible="false" Text="" />
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="grdUsers" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupAddUser" runat="server"
                PopupControlID="pnlPopupAddUser" TargetControlID="lnkDummyPopupAddUser" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupAddUser" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupAddUser" style="width: 60%; height: 80%; overflow-y: scroll; overflow-x: hidden">
                <div class="row">
                    <div class="col-md-12">
                        <asp:Label ID="lblError" CssClass="text-danger" runat="server" Visible="false"></asp:Label>
                        <br />
                        <legend><span class="glyphicon glyphicon-credit-card"></span> Dati di Login</legend>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextUserName" CssClass="col-md-12 control-label">Nome Utente *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextUserName" CssClass="form-control" Width="227px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextUserName" ValidationGroup="PopUpAddUser"
                                    CssClass="text-danger" ErrorMessage="Il campo Nome Utente è obbligatorio." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-12 control-label">Password *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" Width="227px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" ValidationGroup="PopUpAddUser"
                                    CssClass="text-danger" ErrorMessage="Il campo Password è obbligatorio." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-12 control-label">Conferma password *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" Width="227px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword" ValidationGroup="PopUpAddUser"
                                    CssClass="text-danger col-md-12" ErrorMessage="Il campo Conferma Password è obbligatorio" />
                                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" ValidationGroup="PopUpAddUser"
                                    CssClass="text-danger" Display="Dynamic" ErrorMessage="La password e la password di conferma non coincidonno." />
                            </div>
                        </div>
                        <legend><span class="glyphicon glyphicon-user"></span> Dati anagrafici</legend>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextFirstName" CssClass="col-md-12 control-label">Nome *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextFirstName" CssClass="form-control" Width="300px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName" ValidationGroup="PopUpAddUser"
                                    CssClass="text-danger" ErrorMessage="Il campo Nome è obbligatorio." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextLastName" CssClass="col-md-12 control-label">Cognome *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextLastName" CssClass="form-control" Width="300px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLastName" ValidationGroup="PopUpAddUser"
                                    CssClass="text-danger" ErrorMessage="Il campo Cognome è obbligatorio." />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextCF" ID="lblCF" CssClass="col-md-12 control-label">Codice Fiscale</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextCF" CssClass="form-control" Width="240px" MaxLength="16" />
                                <asp:RegularExpressionValidator Enabled="false" ID="FiscalCodeToValidate" ControlToValidate="TextCF" runat="server" ErrorMessage="Formato del Codice Fiscale non corretto."
                                    CssClass="text-danger" ValidationExpression="^[a-zA-Z0-9]{16}$" ValidationGroup="PopUpAddUser"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-12 control-label">E-mail *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" ValidationGroup="PopUpAddUser"
                                    CssClass="text-danger col-md-12" ErrorMessage="Il campo E-mail è obbligatorio." />
                                <asp:RegularExpressionValidator
                                    runat="server" CssClass="text-danger"
                                    ErrorMessage="Formato non corretto." ControlToValidate="Email"
                                    SetFocusOnError="True" Display="Dynamic" ValidationGroup="PopUpAddUser"
                                    ValidationExpression="[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="TextCellPhone" CssClass="col-md-12 control-label">Cellulare *</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox runat="server" ID="TextCellPhone" CssClass="form-control" Width="173px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextCellPhone" ValidationGroup="PopUpAddUser"
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
                                <asp:DropDownList runat="server" CssClass="form-control" ID="Region" AutoPostBack="True" OnSelectedIndexChanged="Region_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="Province" CssClass="col-md-12 control-label">Provincia</asp:Label>
                            <div class="col-md-8">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="Province" AutoPostBack="True" OnSelectedIndexChanged="Province_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label runat="server" AssociatedControlID="City" CssClass="col-md-12 control-label">Comune</asp:Label>
                            <div class="col-md-8">
                                <asp:DropDownList runat="server" CssClass="form-control" ID="City">
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
                            <legend><span class="glyphicon glyphicon-star"></span> Dati Associazione</legend>
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
                                    <div class="form-group" visible="false" runat="server" id="pnlPartnerType">
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
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpAddUserOk" CssClass="btn btn-success btn-sm" ValidationGroup="PopUpAddUser" OnClick="btnPopUpAddUserOk_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpAddUserClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpAddUserClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
