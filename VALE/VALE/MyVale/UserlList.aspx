<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserlList.aspx.cs" Inherits="VALE.MyVale.UserlList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h3>Personal projects</h3>
    <p>
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>

                <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" ShowFooter="true" SelectMethod="GetUsers" GridLines="Both"
                    ItemType="VALE.Models.ApplicationUser" EmptyDataText="No waiting users" CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="UserName" HeaderText="Username" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="FirstName" HeaderText="First name" />
                        <asp:BoundField DataField="LastName" HeaderText="Last name" />
                        <asp:BoundField DataField="CellPhone" HeaderText="Cell" />
                    </Columns>
                </asp:GridView>

            </ContentTemplate>
        </asp:UpdatePanel>
    </p>
    
</asp:Content>
