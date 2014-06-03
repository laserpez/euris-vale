<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalProjects.aspx.cs" Inherits="VALE.MyVale.PersonalProjects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Organized projects</h3>
    <p>
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:GridView OnRowCommand="grid_RowCommand" ID="OrganizedProjectList" runat="server" AutoGenerateColumns="false" ShowFooter="true" GridLines="Both" AllowSorting="true"
                       ItemType="VALE.Models.Project" EmptyDataText="No organized projects" CssClass="table table-striped table-bordered" SelectMethod="GetOrganizedProjects">
                <Columns>
                    <asp:BoundField DataField="ProjectID" HeaderText="ID" SortExpression="ProjectId" />
                    <asp:BoundField DataField="ProjectName" HeaderText="Name" SortExpression="ProjectName" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Created" SortExpression="CreationDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last modified" SortExpression="LastModified">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-info" runat="server" CommandName="ViewDetails" 
                               CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View project" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
         </ContentTemplate>
        </asp:UpdatePanel>
    </p>
    <h3>Attending projects</h3>
    <p>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:GridView OnRowCommand="grid_RowCommand" ID="AttendingProjectList" runat="server" AutoGenerateColumns="false" ShowFooter="true" GridLines="Both" AllowSorting="true"
                       ItemType="VALE.Models.Project" EmptyDataText="No organized projects" CssClass="table table-striped table-bordered" SelectMethod="GetAttendingProjects">
                <Columns>
                    <asp:BoundField DataField="ProjectID" HeaderText="ID" SortExpression="ProjectId" />
                    <asp:BoundField DataField="ProjectName" HeaderText="Name" SortExpression="ProjectName" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Created" SortExpression="CreationDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last modified" SortExpression="LastModified">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-info" runat="server" CommandName="ViewDetails" 
                               CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View project" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
         </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>
