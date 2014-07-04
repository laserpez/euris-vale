﻿<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalArticles.aspx.cs" Inherits="VALE.MyVale.PersonalArticles" %>
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
                                        ItemType="VALE.Models.BlogArticle" EmptyDataText="Nessun articolo personale." CssClass="table table-striped table-bordered" DataKeyNames="BlogArticleId">
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
                                                            <center><div><asp:Button runat="server" Width="90px" Text="Visualizza" CssClass="btn btn-info btn-xs"
                                                                CommandName="ViewArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                            <center><div><asp:Label runat="server" ID="labelDelete"><span  class="glyphicon glyphicon-remove"></span> Cancella</asp:Label></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Button runat="server" Width="90px" Text="Cancella" CssClass="btn btn-danger btn-xs"
                                                                 CommandName="DeleteArticle" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanelDelete" runat="server">
                                <ContentTemplate>
                                    <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                                    <asp:ModalPopupExtender ID="ModalPopup" BehaviorID="mpe" runat="server"
                                        PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
                                    </asp:ModalPopupExtender>
                                    <div class="panel panel-primary" id="pnlPopup" style="width: 60%;">
                                        <div class="panel-heading">
                                            <asp:Label ID="TitleModalView" runat="server" Text="Cancella articolo"></asp:Label>
                                            <asp:Button runat="server" CssClass="close" OnClick="CloseButton_Click" Text="x" />
                                        </div>
                                        <div class="panel-body" style="max-height: 220px">
                                            <div>
                                                <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                                                <div class="form-group">
                                                    <div class="form-group">
                                                        <label class="col-lg-12 control-label">Nome articolo</label>
                                                        <div class="col-lg-10 control-label" runat="server" id="Div1">
                                                            <asp:Label runat="server" ID="ArticleName" Text="" />
                                                            <asp:Label runat="server" ID="ArticleID" Text="" Visible="false"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-12 control-label">Password</label>
                                                        <div class="col-lg-10 control-label" runat="server" id="PasswordDiv">
                                                            <asp:TextBox TextMode="Password" runat="server" CssClass="form-control" ID="PassTextBox" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <asp:Button runat="server" ID="DeleteButton" CssClass="btn btn-default navbar-btn" Text="Conferma" OnClick="DeleteButton_Click" />
                                                <asp:Label runat="server" ID="ErrorDeleteLabel" Text="" Visible="false"></asp:Label>
                                            </div>
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
