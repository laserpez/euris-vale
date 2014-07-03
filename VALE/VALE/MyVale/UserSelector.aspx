<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserSelector.aspx.cs" Inherits="VALE.MyVale.UserSelector" %>

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
                                            <div class="col-lg-10">
                                                <ul class="nav nav-pills">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Scelta utenti"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="navbar-right">
                                                <div class="btn-group">
                                                    <button type="button" id="btnCurrentView" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" runat="server">Utenti <span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <asp:LinkButton ID="btnUsers" CommandArgument="Users" runat="server" OnClick="btnSelectUsers_Click">Utenti</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton ID="btnGroups" CommandArgument="Groups" runat="server" OnClick="btnSelectUsers_Click">Gruppi</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton ID="btnGroupsOfGroups" CommandArgument="GroupsOfGroups" runat="server" OnClick="btnSelectUsers_Click">Gruppi di gruppi</asp:LinkButton></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <asp:TextBox ID="txtSearchByName" runat="server" CssClass="form-control input-sm"></asp:TextBox>

                                                    <span class="input-group-btn">
                                                        <asp:Button CssClass="btn btn-info btn-sm" ID="btnSearchUsers" runat="server" Text="Cerca" OnClick="btnSearchUsers_Click" />
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <asp:DropDownList AutoPostBack="true" ID="ddlFilterGrids" runat="server" CssClass="form-control input-sm">
                                                <asp:ListItem Text="Tutti" Value="all" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Aggiunti" Value="related" Selected="False"></asp:ListItem>
                                                <asp:ListItem Text="Da aggiungere" Value="unrelated" Selected="False"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:GridView AutoGenerateColumns="false" ID="UsersGridView" runat="server" ItemType="VALE.Models.UserData" AllowPaging="false" PageSize="10" AllowSorting="false" SelectMethod="UsersGridView_GetData" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
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
                                                            <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-open"></span> Azione</asp:Label></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Button ID="btnAddUsers" Width="90" Enabled='<%# this.CanRemove || (!this.CanRemove && !IsUserRelated(Eval("UserName").ToString())) %>' CssClass='<%#: IsUserRelated(Item.UserName) ? "btn btn-danger btn-xs" : "btn btn-success btn-xs" %>' Text= '<%#: IsUserRelated(Item.UserName) ? "Rimuovi" : "Aggiungi" %>' runat="server" OnClick="btnAddOrRemoveUsers_Click" CommandName="<%# Item.UserName %>" /></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessun utente da aggiungere.</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                            <asp:GridView AutoGenerateColumns="false" ID="GroupsGridView" runat="server" ItemType="VALE.Models.Group" AllowPaging="false" PageSize="10" AllowSorting="false" SelectMethod="GroupsGridView_GetData" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="GroupName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.GroupName  %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-open"></span> Azione</asp:Label></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Button ID="btnAddGroup" Width="90" CssClass='<%#: IsGroupRelated(Item.GroupId) ? "btn btn-danger btn-xs" : "btn btn-success btn-xs" %>' CommandName='<%#: IsGroupRelated(Item.GroupId) ? "Remove" : "Add" %>' Text= '<%#: IsGroupRelated(Item.GroupId) ? "Rimuovi" : "Aggiungi" %>' runat="server" OnClick="btnAddGroup_Click" CommandArgument="<%# Item.GroupId %>" /></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessun utente da aggiungere.</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <asp:Button CssClass="btn btn-info" ID="btnReturn" runat="server" Text="Fine" OnClick="btnReturn_Click" />
                                </div>
                            </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
