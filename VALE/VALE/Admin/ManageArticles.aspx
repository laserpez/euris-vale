<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageArticles.aspx.cs" Inherits="VALE.Admin.ManageArticles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView ID="grdArticleList" OnRowCommand="grdArticleList_RowCommand" SelectMethod="GetArticles" runat="server" AutoGenerateColumns="false" GridLines="Both"
                ItemType="VALE.Models.BlogArticle" EmptyDataText="No articles"  CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="BlogArticleId" HeaderText="ID" SortExpression="BlogArticleId" />
                    <asp:BoundField DataField="Title" HeaderText="Name" SortExpression="Title" />
                    <asp:TemplateField HeaderText="Release Date" SortExpression="ReleaseDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.ReleaseDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Creator" SortExpression="CreatorUserName">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="View article" CssClass="btn btn-info btn-sm"
                                CommandName="ViewArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Accept">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Accept article" CssClass="btn btn-success btn-sm"
                                CommandName="AcceptArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reject">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Reject article" CssClass="btn btn-danger btn-sm"
                                CommandName="RejectArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
