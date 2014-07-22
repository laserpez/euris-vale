<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VALE.Admin.ManageUsers" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/AddNewUser.ascx" TagPrefix="uc" TagName="AddNewUser" %>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>

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
                                                    <uc:AddNewUser runat="server" ID="AddNewUser" />
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
                                    <asp:GridView ID="grdUsers" runat="server" DataKeyNames="UserName" AutoGenerateColumns="false" AllowSorting="true" GridLines="Both" AllowPaging="true" PageSize="2" OnPageIndexChanging="grdUsers_PageIndexChanging"
                                        ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun utente" CssClass="table table-striped table-bordered" OnSorting="grdUsers_Sorting">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CausesValidation="false" CommandArgument="UserName" CommandName="sort" runat="server" ID="labelUserName"><span  class="glyphicon glyphicon-credit-card"></span> UserName</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label ID="labelUserName" runat="server" Text="<%#: Item.UserName %>"></asp:Label></div></center>
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
                                                    <center><div><asp:LinkButton CausesValidation="false" CommandArgument="CF" CommandName="sort" runat="server" ID="labelCF"><span  class="glyphicon glyphicon-barcode"></span> Codice fiscale</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.CF %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CausesValidation="false" CommandArgument="Ruolo" CommandName="sort" runat="server" ID="labelRuolo"><span  class="glyphicon glyphicon-cog"></span> Ruolo</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                        <div class="btn-group">
                                                            <div class="navbar-right">
                                                                <button id="AllListRoles" class="btn btn-primary dropdown-toggle btn-xs" data-toggle="dropdown" runat="server" ><div><%# GetRoleName(Item.Id) %><span class="caret"></span></div></button>
                                                                <ul class="dropdown-menu" >
                                                                    <asp:ListView runat="server" ID="roleList" ItemType="Microsoft.AspNet.Identity.EntityFramework.IdentityRole" SelectMethod="GetRoles">
                                                                        <ItemTemplate>
                                                                        <li><asp:LinkButton ID="btnRole" CommandArgument='<%#: Item.Name %>' runat="server" OnClick="btnChangeUser_Click" CausesValidation="false"><span class="glyphicon glyphicon-plus-sign btn-sm"> <%#: Item.Name %></span>  </asp:LinkButton></li>
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
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkSelectUser" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerTemplate>
                                            <asp:GridPager runat="server"
                                                ShowFirstAndLast="true" ShowNextAndPrevious="true" PageLinksToShow="10"
                                                NextText=">" PreviousText="<" FirstText="Prima" LastText="Ultima" />
                                        </PagerTemplate>
                                    </asp:GridView>
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
</asp:Content>
