<%@ Page Title="Blog articles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Articles.aspx.cs" Inherits="VALE.MyVale.Articles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-6">
                                                <ul class="nav nav-pills col-lg-6">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Articoli del Blog"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">

                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:GridView OnRowCommand="grdAllArticles_RowCommand" SelectMethod="GetAllArticles" ID="grdAllArticles" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                ItemType="VALE.Models.BlogArticle" EmptyDataText="Nessun articolo." CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:BoundField DataField="BlogArticleId" HeaderText="ID" SortExpression="BlogArticleId" />
                                                    <asp:BoundField DataField="Title" HeaderText="Titolo" SortExpression="Title" />
                                                    <asp:TemplateField HeaderText="Creatore">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
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
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
