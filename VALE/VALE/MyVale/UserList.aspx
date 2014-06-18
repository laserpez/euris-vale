<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="VALE.MyVale.UserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h3>Personal projects</h3>
    <p>
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
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
                <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" ShowFooter="true" SelectMethod="GetUsers" GridLines="Both"
                    ItemType="VALE.Models.ApplicationUser" AllowSorting="true" EmptyDataText="No waiting users" CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                        <asp:BoundField DataField="FirstName" HeaderText="Nome" SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="Cognome"  SortExpression="LastName"/>
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="CellPhone" HeaderText="Cell" SortExpression="CellPhone" />
                    </Columns>
                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>
    </p>
    
</asp:Content>
