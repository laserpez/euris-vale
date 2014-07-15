<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewArticle.aspx.cs" Inherits="VALE.MyVale.ViewArticle" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio articolo"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">

                            <asp:FormView ID="frmArticle" OnDataBound="Unnamed_DataBound" ItemType="VALE.Models.BlogArticle" SelectMethod="GetArticle" runat="server">
                                <ItemTemplate>
                                    <h3><%#: Item.Title %></h3>
                                    <asp:Label runat="server"><%#: String.Format("Autore: {0}", Item.Creator.FullName) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Data: {0}", Item.ReleaseDate.ToShortDateString()) %></asp:Label>
                                    <p>
                                        <asp:Label ID="lblContent" runat="server"></asp:Label>
                                    </p>
                                </ItemTemplate>
                            </asp:FormView>
                            <p></p>
                            <asp:Label runat="server" Text="Commenti" CssClass="h4"></asp:Label>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Panel runat="server">
                                        <asp:Label runat="server" Text="Aggiungi commento:"></asp:Label>
                                        <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtComment"></asp:TextBox>
                                        <asp:Button runat="server" CssClass="btn btn-info btn-xs" ID="btnAddComment" Text="Aggiungi" OnClick="btnAddComment_Click" />
                                    </asp:Panel>
                                    <br />
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Commenti</div>
                                        <div class="panel-body">
                                            <asp:ListView runat="server" ID="lstComments" OnDataBound="lstComments_DataBound" ItemType="VALE.Models.BlogComment" SelectMethod="GetComments">
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server" Text="Nessun commento"></asp:Label>
                                                </EmptyDataTemplate>
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.Creator.FullName %></asp:Label>
                                                    <asp:Label runat="server"><%#: String.Format(" - {0}", Item.Date) %></asp:Label>
                                                    <asp:LinkButton runat="server" ID="deleteComment" ToolTip="Cancella commento" Visible="false" CommandArgument="<%#: Item.BlogCommentId %>" CausesValidation="false" OnClick="deleteComment_Click"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton><br />
                                                    <asp:Label runat="server"><%#: Item.CommentText %></asp:Label><br />
                                                </ItemTemplate>
                                                <ItemSeparatorTemplate>
                                                    <br />
                                                </ItemSeparatorTemplate>
                                            </asp:ListView>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
