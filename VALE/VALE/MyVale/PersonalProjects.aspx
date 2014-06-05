<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalProjects.aspx.cs" Inherits="VALE.MyVale.PersonalProjects" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Personal projects</h3>
    <p>
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Label runat="server" Text="Select: "></asp:Label>
                <div class="btn-group">
                    <button type="button" id="btnCurrentView" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" runat="server">Attending<%--<span class="caret"></span>--%></button>
                    <ul class="dropdown-menu">
                        <li>
                            <asp:LinkButton ID="btnAttending" CommandArgument="Attending" runat="server" OnClick="btnViewProjects_Click">Attending</asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="btnCreated" CommandArgument="Created" runat="server" OnClick="btnViewProjects_Click">Created</asp:LinkButton></li>
                    </ul>
                </div>
                <br />
                <asp:GridView OnRowCommand="grid_RowCommand" ID="grdProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                    ItemType="VALE.Models.Project" EmptyDataText="No organized projects" CssClass="table table-striped table-bordered" SelectMethod="GetPersonalProjects">
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
                                <asp:Button CssClass="btn btn-info btn-sm" runat="server" CommandName="ViewDetails"
                                    CommandArgument="<%# Item.ProjectId %>" Text="View project" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </p>
    
</asp:Content>
