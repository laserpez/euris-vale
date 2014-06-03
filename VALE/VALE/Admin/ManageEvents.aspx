<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageEvents.aspx.cs" Inherits="VALE.Admin.ManageEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView OnRowCommand="grdEventList_RowCommand" ID="grdEventList" SelectMethod="GetEvents" runat="server" AutoGenerateColumns="false" GridLines="Both" 
                ItemType="VALE.Models.Event" EmptyDataText="No open projects" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="EventId" HeaderText="ID" SortExpression="EventId" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Created" SortExpression="EventDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Creator" SortExpression="OrganizerId">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: GetOrganizerName(Item.OrganizerId) %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="View report" CssClass="btn btn-info btn-sm"
                                CommandName="ViewReport" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Delete event" CssClass="btn btn-danger btn-sm"
                                CommandName="DeleteProject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
