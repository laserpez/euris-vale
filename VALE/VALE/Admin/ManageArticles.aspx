<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageArticles.aspx.cs" Inherits="VALE.Admin.ManageArticles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Gestione articoli"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView ID="grdArticleList" DataKeyNames="BlogArticleId" AllowSorting="true" OnRowCommand="grdArticleList_RowCommand" SelectMethod="GetArticles" runat="server" AutoGenerateColumns="false" GridLines="Both"
                                        ItemType="VALE.Models.BlogArticle" EmptyDataText="Nessun articolo presente." CssClass="table table-striped table-bordered">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="Title" CommandName="sort" runat="server" ID="labelTitle"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Title %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="ReleaseDate" CommandName="sort" runat="server" ID="labelReleaseDate"><span  class="glyphicon glyphicon-calendar"></span> Data di pubblicazione</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.ReleaseDate.ToShortDateString() %></asp:Label><center><div>
                                                </ItemTemplate>
                                                <HeaderStyle Width="190px" />
                                                <ItemStyle Width="190px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="CreatorUserName" CommandName="sort" runat="server" ID="labelCreatorUserName"><span  class="glyphicon glyphicon-user"></span> Creatore</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label><center><div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="Status" CommandName="sort" runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Status== "rejected" ? "Rifiutato" : "Accettato" %></asp:Label></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:Label runat="server" ID="labelDetails"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Button runat="server" Width="90" Text="Visualizza" CssClass="btn btn-info btn-xs"
                                                                CommandName="ViewArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:Label runat="server" ID="labelAccept"><span  class="glyphicon glyphicon-ok-circle"></span> Accetta</asp:Label></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Button runat="server" Width="120" Text="Accetta articolo" CssClass="btn btn-success btn-xs"
                                                                CommandName="AcceptArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="120px" />
                                                <ItemStyle Width="120px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:Label runat="server" ID="labelReject"><span  class="glyphicon glyphicon-remove-circle"></span> Rifiuta</asp:Label></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Button runat="server" Width="120" Text="Rifiuta articolo" CssClass="btn btn-danger btn-xs"
                                                                CommandName="RejectArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="120px" />
                                                <ItemStyle Width="120px" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
