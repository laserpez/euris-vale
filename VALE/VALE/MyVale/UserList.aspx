<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="VALE.MyVale.UserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h3>Lista utenti</h3>
    <p>
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="col-lg-10">
                                    <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Mostra filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                                </div>
                                <div class="navbar-right">
                                    <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" Visible="false" CssClass="btn btn-info btn-xs" />
                                    <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" OnClick="btnClearFilters_Click" Visible="false" CssClass="btn btn-danger btn-xs" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div runat="server" id="filterPanel" class="panel-body">
                        <asp:Label AssociatedControlID="txtName" CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                        <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                        <asp:Label AssociatedControlID="txtLastname" CssClass="col-md-2 control-label" runat="server" Text="Cognome"></asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtLastname"></asp:TextBox>

                        <br />

                        <asp:Label AssociatedControlID="txtUsername" CssClass="col-md-2 control-label" runat="server" Text="Username"></asp:Label>
                        <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtUsername"></asp:TextBox>
                        <asp:Label AssociatedControlID="txtEmail" CssClass="col-md-2 control-label" runat="server" Text="Email"></asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtEmail"></asp:TextBox>

</div>
                </div>
                <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowPaging="true" PageSize="10" OnPageIndexChanging="grdUsers_PageIndexChanging"
                    ItemType="VALE.MyVale.UserInfo" AllowSorting="true" EmptyDataText="No waiting users" CssClass="table table-striped table-bordered" OnSorting="grdUsers_Sorting">
                    <Columns>

                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="FirstName" CommandName="sort" runat="server" ID="label1"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Label runat="server"><a href="/Account/Profile?Username=<%#: Item.Username %>"><%#: Item.FirstName %></a></asp:Label></div></center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="LastName" CommandName="sort" runat="server" ID="label2"><span  class="glyphicon glyphicon-user"></span> Cognome</asp:LinkButton></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Label runat="server"><%#: Item.LastName %></asp:Label></div></center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="label3"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="Telephone" CommandName="sort" runat="server" ID="label4"><span  class="glyphicon glyphicon-credit-card"></span> Telephone</asp:LinkButton></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Label runat="server"><%#: Item.Telephone %></asp:Label></div></center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="CellPhone" CommandName="sort" runat="server" ID="label5"><span  class="glyphicon glyphicon-phone"></span> Cell</asp:LinkButton></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Label runat="server"><%#: Item.CellPhone %></asp:Label></div></center>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <PagerSettings Position="Bottom" />
                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>
    </p>
    
</asp:Content>
