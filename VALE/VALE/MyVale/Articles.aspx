<%@ Page Title="Blog articles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Articles.aspx.cs" Inherits="VALE.MyVale.Articles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Blog articles</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView OnRowCommand="grdAllArticles_RowCommand" SelectMethod="GetAllArticles" ID="grdAllArticles" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                ItemType="VALE.Models.BlogArticle" EmptyDataText="No articles" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="BlogArticleId" HeaderText="ID" SortExpression="BlogArticleId" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:TemplateField HeaderText="Creator" >
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: GetCreatorName(Item.CreatorId) %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Release date" SortExpression="ReleaseDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.ReleaseDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button runat="server" Text="View article" CssClass="btn btn-info btn-sm"
                                CommandName="ViewArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
