<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VALE.Admin.ManageUsers" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


            <br />
            <h3>Gestione utenti</h3>
            <br />
            <br />
            <div class="col-lg-12">
                <asp:UpdatePanel ID="UpdatePanelUsrManager" runat="server">
                    <ContentTemplate>
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="col-lg-6">
                                            <ul class="nav nav-pills col-lg-6">
                                                <li>
                                                    <h4><span class="badge" runat="server" id="NotificationNumber"></span>
                                                        <asp:Label ID="TitleLabel" runat="server"></asp:Label></h4>
                                                </li>
                                            </ul>
                                        </div>
                                        <asp:Label ID="TypeOfListUsers" runat="server" Visible="false"></asp:Label>
                                        <div class="navbar-right">
                                            <div class="btn-group" runat="server" id="ListActivityDiv">
                                                <asp:Label ID="ListUsersType" Visible="false" runat="server" Text=""></asp:Label>
                                                <button type="button" visible="true" id="GetAllUsersButton" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Tutti  <span class="caret"></span></button>
                                                <button type="button" visible="false" id="GetPartnersButton" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" runat="server">Soci  <span class="caret"></span></button>
                                                <button type="button" visible="false" id="GetDirectivPartnersButton" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" runat="server">Consiglio Direttivo<span class="caret"></span></button>
                                                <button type="button" visible="false" id="GetRequestsdButton" class="btn btn-success dropdown-toggle" data-toggle="dropdown" runat="server">Richieste  <span class="caret"></span></button>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="GetAllUsers_Click"><span class="glyphicon glyphicon-hdd"></span> Tutti</asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="GetAdmin_Click"><span class="glyphicon glyphicon-star"></span> Amministratori  </asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="GetPartners_Click"><span class="glyphicon glyphicon-user"></span> Soci  </asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="GetDirectivPartners_Click"><span class="glyphicon glyphicon-user"></span> Consiglio Direttivo</asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="GetRequests_Click"><span class="glyphicon glyphicon-plus-sign"></span>  Richieste  </asp:LinkButton></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body">
                                <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" ShowFooter="true" AllowSorting="true" GridLines="Both"
                                    ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun utente" CssClass="table table-striped table-bordered">
                                    <Columns>
                                        <asp:BoundField DataField="UserName" HeaderText="UserName" />
                                        <asp:BoundField DataField="Email" HeaderText="Email" />
                                        <asp:BoundField DataField="FirstName" HeaderText="Nome" />
                                        <asp:BoundField DataField="LastName" HeaderText="Cognome" />
                                        <asp:BoundField DataField="CellPhone" HeaderText="Cellulare" />
                                        <asp:BoundField DataField="CF" HeaderText="Codice fiscale" />
                                        <asp:TemplateField HeaderText="Ruolo">
                                            <ItemTemplate>
                                                <%# GetRoleName(Item.Id) %>
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
                                                    <button type="button" id="AllListRoles" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Cambia Ruolo<span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <asp:LinkButton ID="btnAdministrator" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click">Amministratore</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton ID="btnBoard" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click">Membro del consiglio</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton ID="btnAssociated" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click">Socio</asp:LinkButton></li>
                                                    </ul>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:Button ID="btnConfirmUser" Visible="false" runat="server" Text="Conferma utenti selezionati" CssClass="btn btn-primary" OnClick="btnConfimUser_Click" />
                                <asp:Label ID="lblChangeRole" runat="server" Visible="false" Text="" />
                                </div>
                            </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
</asp:Content>
