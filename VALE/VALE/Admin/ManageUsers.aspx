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
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                        </div>
                        <div runat="server" id="filterPanel" class="panel-body">
                            <asp:Label AssociatedControlID="txtName" CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                            <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                            <asp:Label AssociatedControlID="txtLastname" CssClass="col-md-2 control-label" runat="server" Text="Cognome"></asp:Label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="txtLastname"></asp:TextBox>

                            
                            <asp:Label AssociatedControlID="txtUsername" CssClass="col-md-2 control-label" runat="server" Text="Username"></asp:Label>
                            <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtUsername"></asp:TextBox>
                            <asp:Label AssociatedControlID="txtEmail" CssClass="col-md-2 control-label" runat="server" Text="Email"></asp:Label>
                            <asp:TextBox CssClass="form-control" runat="server" ID="txtEmail"></asp:TextBox>


                            <asp:Button runat="server" Text="Search" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info" />
                            <asp:Button runat="server" Text="Clear filter" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                        </div>
                    </div>
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
