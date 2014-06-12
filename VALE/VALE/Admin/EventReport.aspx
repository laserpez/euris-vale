<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventReport.aspx.cs" Inherits="VALE.Admin.EventReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView runat="server" ID="EventDetail" ItemType="VALE.Models.Event" SelectMethod="GetEvent">
        <ItemTemplate>
            <h3><%#: Item.Name %></h3>
            <h4>Event details</h4>
            <asp:Label runat="server"><%#: String.Format("When: {0}", Item.EventDate.ToShortDateString()) %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: String.Format("Created by: {0}", Item.Organizer.FullName) %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: Item.Public ? "Public event" : "Private event" %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: String.Format("Description: {0}", Item.Description) %></asp:Label><br />
            <h4>Registered users</h4>
            <asp:ListView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                SelectMethod="GetRegisteredUsers" runat="server" ID="lstUsers" >
                <ItemTemplate>
                    <asp:Label runat="server" ForeColor="#317eac" Font-Bold="true"><%#: Item.FullName %></asp:Label><br />
                    <asp:Label runat="server"><%#: Item.Email %></asp:Label>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <asp:Label runat="server">No registered users</asp:Label>
                </EmptyDataTemplate>
                <ItemSeparatorTemplate>
                    <br />
                </ItemSeparatorTemplate>
            </asp:ListView>
            <br />
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
