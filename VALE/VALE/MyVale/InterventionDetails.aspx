<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterventionDetails.aspx.cs" Inherits="VALE.MyVale.InterventionDetails" %>
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
                                                            <asp:Label ID="HeaderName" runat="server" Text="Interventi"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">
                                    <asp:FormView runat="server" ID="InterventionDetail" ItemType="VALE.Models.Intervention" SelectMethod="GetIntervention">
                                        <ItemTemplate>
                                            <asp:Label runat="server"><%#: String.Format("Autore: {0}", Item.Creator.FullName) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Data: {0}", Item.Date.ToShortDateString()) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Testo: {0}", String.IsNullOrEmpty(Item.InterventionText) ? "Nessun commento scritto inserito." : Item.InterventionText) %></asp:Label><br />
                                            <p></p>
                                            <asp:Label ID="labelAttachment" runat="server" Text="Documenti allegati" CssClass="h4"></asp:Label>
                                            <asp:ListBox runat="server" ID="lstDocuments" CssClass="form-control" SelectMethod="GetRelatedDocuments"></asp:ListBox>
                                            <p></p>
                                            <asp:Button runat="server" Text="Scarica" CssClass="btn btn-info btn-xs" ID="btnViewDocument" OnClick="btnViewDocument_Click" />
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <p></p>
                                    <asp:Label runat="server" Text="Commenti" CssClass="h4"></asp:Label>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Panel runat="server">
                                                <asp:Label runat="server" Text="Aggiungi commento:"></asp:Label>
                                                <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtComment"></asp:TextBox>
                                                <p></p>
                                                <asp:Button runat="server" CssClass="btn btn-info btn-xs" ID="btnAddComment" Text="Aggiungi" OnClick="btnAddComment_Click" />
                                            </asp:Panel>
                                            <br />
                                            <div class="panel panel-default">
                                                <div class="panel-heading">Commenti</div>
                                                <div class="panel-body">
                                                    <asp:ListView runat="server" ID="lstComments" ItemType="VALE.Models.Comment" SelectMethod="GetComments">
                                                        <EmptyDataTemplate>
                                                            <asp:Label runat="server" Text="Non sono ancora presenti commenti."></asp:Label>
                                                        </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.CreatorUserName %></asp:Label>
                                                            <asp:Label runat="server"><%#: String.Format(" - {0}", Item.Date) %></asp:Label><br />
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
