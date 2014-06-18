<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VALE.Admin.ManageUsers" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="nav nav-tabs" style="margin-bottom: 15px;">
        <li class="active"><a href="#approve" data-toggle="tab">Utenti in attesa</a></li>
        <li class=""><a href="#manage" data-toggle="tab">Gestione utenti</a></li>
    </ul>

    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade active in" id="approve">
            <br />
            <h3>Utenti in attesa di approvazione</h3>
            <br />
            <br />
            <asp:UpdatePanel ID="UpdatePanelApproval" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="grdWaitingUsers" runat="server" AutoGenerateColumns="false" AllowSorting="true" ShowFooter="true" SelectMethod="GetWaitingUsers" GridLines="Both"
                        ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun utente in attesa" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                            <asp:BoundField DataField="FirstName" HeaderText="Nome" SortExpression="FirstName" />
                            <asp:BoundField DataField="LastName" HeaderText="Cognome" SortExpression="LastName" />
                            <asp:BoundField DataField="CellPhone" HeaderText="Cellulare" SortExpression="CellPhone" />
                            <asp:BoundField DataField="CF" HeaderText="Codice Fiscale" SortExpression="CF" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkSelectUser" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:Button ID="btnConfirmUser" runat="server" Text="Conferma utenti selezionati" CssClass="btn btn-primary" OnClick="btnConfimUser_Click" />
        </div>

        <div class="tab-pane fade" id="manage">
            <br />
            <h3>Gestione utenti</h3>
            <br />
            <br />
            <asp:UpdatePanel ID="UpdatePanelUserManager" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    
                    <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" ShowFooter="true" AllowSorting="true" GridLines="Both"
                        ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun utente" CssClass="table table-striped table-bordered"  OnSorting="UsersList_Sorting">
                        <Columns>
                            <asp:BoundField DataField="UserName" HeaderText="UserName"/>
                            <asp:BoundField DataField="Email" HeaderText="Email"/>
                            <asp:BoundField DataField="FirstName" HeaderText="Nome"/>
                            <asp:BoundField DataField="LastName" HeaderText="Cognome"/>
                            <asp:BoundField DataField="CF" HeaderText="Codice fiscale"/>
                            <asp:TemplateField HeaderText="Ruolo">
                                <ItemTemplate>
                                    <%# GetRoleName(Item.Id) %>
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
                    <asp:Label ID="lblChangeRole" runat="server" Visible="false" Text="" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
