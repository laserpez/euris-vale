<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalArticles.aspx.cs" Inherits="VALE.MyVale.PersonalArticles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Articoli personali</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView OnRowCommand="grdPersonalArticles_RowCommand" SelectMethod="GetPersonalArticles" ID="grdPersonalArticles" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                ItemType="VALE.Models.BlogArticle" EmptyDataText="Nessun articolo personale." CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="BlogArticleId" HeaderText="ID" SortExpression="BlogArticleId" />
                    <asp:BoundField DataField="Title" HeaderText="Titolo" SortExpression="Title" />
                    <asp:TemplateField HeaderText="Data di pubblicazione" SortExpression="ReleaseDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.ReleaseDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Stato" SortExpression="Status" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Vedi articolo" CssClass="btn btn-info btn-sm"
                                CommandName="ViewArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
