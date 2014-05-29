<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProjects.aspx.cs" Inherits="VALE.Admin.ManageProject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Show filters" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                </div>
                <div runat="server" id="filterPanel" class="panel-body">
                    <asp:Label AssociatedControlID="txtName" CssClass="col-md-2 control-label" runat="server" Text="Name"></asp:Label>
                    <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                    <asp:Label AssociatedControlID="txtDescription" CssClass="col-md-2 control-label" runat="server" Text="Description"></asp:Label>
                    <asp:TextBox CssClass="form-control" runat="server" ID="txtDescription"></asp:TextBox>
                    <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Created"></asp:Label>
                    <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtCreationDate"></asp:TextBox>
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtCreationDate"></asp:CalendarExtender>
                    <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Modified"></asp:Label>
                    <asp:TextBox CssClass="form-control" runat="server" ID="txtLastModifiedDate"></asp:TextBox>
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtLastModifiedDate"></asp:CalendarExtender>
                    <asp:Button runat="server" Text="Search" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info" />
                    <asp:Button runat="server" Text="Clear filter" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                </div>
            </div>

            <asp:GridView OnRowCommand="ProjectList_RowCommand" ID="ProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" 
                ItemType="VALE.Models.Project" EmptyDataText="No open projects" CssClass="table table-striped table-bordered">
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
                            <asp:Button runat="server" Text="View report" CssClass="btn btn-info btn-sm"
                                CommandName="ViewReport" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Delete project" CssClass="btn btn-danger btn-sm"
                                CommandName="DeleteProject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
