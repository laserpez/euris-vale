<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalArticles.aspx.cs" Inherits="VALE.MyVale.PersonalArticles" %>
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
                                                            <asp:Label ID="HeaderName" runat="server" Text="Articoli personali"></asp:Label>
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
                                            <asp:GridView OnRowCommand="grdPersonalArticles_RowCommand" SelectMethod="GetPersonalArticles" ID="grdPersonalArticles" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                ItemType="VALE.Models.BlogArticle" EmptyDataText="Nessun articolo personale." CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:BoundField DataField="BlogArticleId" HeaderText="ID" SortExpression="BlogArticleId" />
                                                    <asp:BoundField DataField="Titolo" HeaderText="Title" SortExpression="Title" />
                                                    <asp:TemplateField HeaderText="Data di pubblicazione" SortExpression="ReleaseDate">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server"><%#: Item.ReleaseDate.ToShortDateString() %></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Status" HeaderText="Stato" SortExpression="Status" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button runat="server" Text="Vedi articolo" Width="90" CssClass="btn btn-info btn-xs"
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
