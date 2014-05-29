<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VALE.Admin.ManageUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Associated users waiting for approval</h3>
    <p></p>
    <asp:GridView ID="grdWaitingUsers" runat="server" AutoGenerateColumns="false" ShowFooter="true" SelectMethod="GetWaitingUsers" GridLines="Both" 
                       ItemType="VALE.Models.ApplicationUser" EmptyDataText="No waiting users" CssClass="table table-striped table-bordered" >
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID"  />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="FirstName" HeaderText="First name" />
                    <asp:BoundField DataField="LastName" HeaderText="Last name" />
                    <asp:BoundField DataField="CF" HeaderText="Fiscal code" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkSelectUser"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
    <asp:Button ID="btnConfirmUser" runat="server" Text="Confirm selected user(s)" CssClass="btn btn-primary" OnClick="btnConfimUser_Click" />
</asp:Content>
