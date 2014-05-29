<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="VALE.MyVale.EventDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView runat="server" ID="EventDetail" ItemType="VALE.Models.Event" SelectMethod="GetEvent">
        <ItemTemplate>
            <h3><%#: Item.Name %></h3>
            <asp:Button ID="btnAttend" Text="I will attend" runat="server" OnClick="btnAttend_Click" /><br />
            <h4>Event details</h4>
            <asp:Label runat="server"><%#: String.Format("When: {0}", Item.EventDate.ToShortDateString()) %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: String.Format("Created by: {0}", Item.Organizer.FullName) %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: Item.Public ? "Public event" : "Private event" %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: String.Format("Description: {0}", Item.Description) %></asp:Label><br />
            <h4>Registered users</h4>
            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                SelectMethod="GetRegisteredUsers" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label runat="server">No registered users</asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>
            <br />
            <h4>Related project</h4>
            <asp:FormView runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                <ItemTemplate>
                    <a href="ProjectDetails.aspx?projectId=<%#:Item.ProjectId %>"><%#: Item.ProjectName %></a>
                    <br />
                </ItemTemplate>
            </asp:FormView>
            <h4>Documents</h4>
            <asp:ListBox runat="server" CssClass="form-control" Width="400px" ID="lstDocuments" SelectMethod="GetRelatedDocuments"></asp:ListBox>
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
