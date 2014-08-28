<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArticleCreate.aspx.cs" Inherits="VALE.MyVale.Create.ArticleCreate" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Crea un nuovo articolo per il Blog"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div class="row">
                                <div class="col-md-12"><br /></div>
                                <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                                <div class="col-md-12">
                                    <asp:Label Font-Bold="true" runat="server" CssClass="control-label col-md-3">Titolo *</asp:Label>
                                    <div class="col-md-9">
                                        <asp:TextBox CssClass="form-control" ID="txtArticleTitle" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtArticleTitle" CssClass="text-danger" ErrorMessage="Il Titolo è obbligatorio" />
                                    </div>
                                </div>
                            </div>
                             <div class="row">
                                 <div class="col-md-12">
                                     <asp:Label Font-Bold="true" runat="server" CssClass="control-label col-md-3">Data di pubblicazione *</asp:Label>
                                     <div class="col-md-9">
                                        <asp:TextBox CssClass="form-control" ID="txtReleaseDate" runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ValidationExpression="\d{1,2}/\d{1,2}/\d{4}" CssClass="text-danger" ErrorMessage="Il formato della data non è corretto." ControlToValidate="txtReleaseDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                         <asp:RequiredFieldValidator runat="server" ControlToValidate="txtArticleTitle" CssClass="text-danger" ErrorMessage="La Data di pubblicazione è obbligatoria" />
                                        <asp:CalendarExtender ID="CalendarReleaseDate" TargetControlID="txtReleaseDate" runat="server" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                     </div>
                                 </div>
                             </div>
                              <div class="row">
                                 <div class="col-md-12">
                                     <asp:Label Font-Bold="true" runat="server" CssClass="control-label col-md-3">Contenuto *</asp:Label>
                                     <div class="col-md-9">
                                        <asp:TextBox CssClass="form-control" TextMode="MultiLine" Height="300px" ID="txtArticleContent" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtArticleContent" CssClass="text-danger" ErrorMessage="Il Contenuto è obbligatorio" />
                                        <%--<asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtArticleContent">
                                            <Toolbar>
                                    <ajaxToolkit:Undo />
                                    <ajaxToolkit:Redo />
                                    <ajaxToolkit:Bold />
                                    <ajaxToolkit:Italic />
                                    <ajaxToolkit:Underline />
                                    <ajaxToolkit:StrikeThrough />
                                    <ajaxToolkit:Subscript />
                                    <ajaxToolkit:Superscript />
                                    <ajaxToolkit:InsertOrderedList />
                                    <ajaxToolkit:InsertUnorderedList />
                                    <ajaxToolkit:CreateLink />
                                    <ajaxToolkit:Cut />
                                    <ajaxToolkit:Copy />
                                    <ajaxToolkit:Paste />
                                </Toolbar>
                                        </asp:HtmlEditorExtender>--%>
                                     </div>
                                 </div>
                                 <div class="col-md-12"><br /></div>
                             </div>

                            <asp:Button runat="server" ID="btnSubmit" Text="Invia" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                            <asp:Button runat="server" CssClass="btn btn-danger"  Text="Annulla" ID="btnCancel" CausesValidation="false"  OnClick="btnCancel_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
