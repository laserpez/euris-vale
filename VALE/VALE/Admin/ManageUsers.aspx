<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VALE.Admin.ManageUsers" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

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
                                                <h4><span class="badge" runat="server" id="NotificationNumber"></span>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Gestione Utenti"></asp:Label></h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <asp:Label ID="TypeOfListUsers" runat="server" Visible="false"></asp:Label>
                                    <div class="navbar-right">
                                        <div class="btn-group" runat="server" id="ListActivityDiv">
                                            <asp:Label ID="ListUsersType" Visible="false" runat="server" Text=""></asp:Label>
                                            <button type="button" visible="true" id="GetAllUsersButton" class="btn btn-primary dropdown-toggle btn-sm" data-toggle="dropdown" runat="server">Tutti  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="GetAdminButton" class="btn btn-warning dropdown-toggle btn-sm" data-toggle="dropdown" runat="server">Amministratori  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="GetPartnersButton" class="btn btn-warning dropdown-toggle btn-sm" data-toggle="dropdown" runat="server">Soci  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="GetDirectivPartnersButton" class="btn btn-warning dropdown-toggle btn-sm" data-toggle="dropdown" runat="server">Consiglio Direttivo<span class="caret"></span></button>
                                            <button type="button" visible="false" id="GetRequestsdButton" class="btn btn-success dropdown-toggle btn-sm" data-toggle="dropdown" runat="server">Richieste  <span class="caret"></span></button>
                                            <ul class="dropdown-menu" >
                                                <li>
                                                    <asp:LinkButton runat="server" OnClick="GetAllUsers_Click"><span class="glyphicon glyphicon-hdd btn-sm"></span> Tutti</asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton runat="server" OnClick="GetAdmin_Click"><span class="glyphicon glyphicon-star btn-sm"></span> Amministratori  </asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton runat="server" OnClick="GetPartners_Click"><span class="glyphicon glyphicon-user btn-sm"></span> Soci  </asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton runat="server" OnClick="GetDirectivPartners_Click"><span class="glyphicon glyphicon-user btn-sm"></span> Consiglio Direttivo</asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton runat="server" OnClick="GetRequests_Click"><span class="glyphicon glyphicon-plus-sign btn-sm"></span>  Richieste  </asp:LinkButton></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" AllowSorting="true" GridLines="Both"
                                ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun utente" CssClass="table table-striped table-bordered" OnSorting="grdUsers_Sorting">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="UserName" CommandName="sort" runat="server" ID="labelUserName"><span  class="glyphicon glyphicon-credit-card"></span> UserName</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label ID="labelUserName" runat="server" Text="<%#: Item.UserName %>"></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="FirstName" CommandName="sort" runat="server" ID="labelFirstName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.FirstName %></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="LastName" CommandName="sort" runat="server" ID="labelLastName"><span  class="glyphicon glyphicon-user"></span> Cognome</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.LastName %></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="CellPhone" CommandName="sort" runat="server" ID="labelCellPhone"><span  class="glyphicon glyphicon-phone"></span> Cellulare</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.CellPhone %></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="CF" CommandName="sort" runat="server" ID="labelCF"><span  class="glyphicon glyphicon-barcode"></span> Codice fiscale</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.CF %></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="Ruolo" CommandName="sort" runat="server" ID="labelRuolo"><span  class="glyphicon glyphicon-cog"></span> Ruolo</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><%# GetRoleName(Item.Id) %></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkSelectUser" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="btn-group">
                                                <button type="button" id="AllListRoles" width="150" class="btn btn-primary dropdown-toggle btn-xs" data-toggle="dropdown" runat="server">Cambia Ruolo<span class="caret"></span></button>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <asp:LinkButton ID="btnAdministrator" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click"><span class="glyphicon glyphicon-star btn-sm"></span> Amministratore</asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton ID="btnBoard" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click"><span class="glyphicon glyphicon-user btn-sm"></span> Membro del consiglio</asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton ID="btnAssociated" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click"><span class="glyphicon glyphicon-user btn-sm"></span> Socio</asp:LinkButton></li>
                                                </ul>
                                            </div>
                                        </ItemTemplate>
                                        <ItemStyle Width="100px" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Button ID="btnConfirmUser" Visible="false" runat="server" Text="Conferma utenti selezionati" CssClass="btn btn-primary" OnClick="btnConfimUser_Click" />
                            <asp:Label ID="lblChangeRole" runat="server" Visible="false" Text="" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
