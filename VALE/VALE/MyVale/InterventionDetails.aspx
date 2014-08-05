<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterventionDetails.aspx.cs" Inherits="VALE.MyVale.InterventionDetails" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/FileUploader.ascx" TagPrefix="uc" TagName="FileUploader" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Button ID="btnBack" ToolTip="Torna indietro" runat="server" CausesValidation="false" CssClass="btn btn-primary col-md-1" Font-Bold="true" Text="&#171;" OnClick="btnBack_ServerClick" />
                                    <div class="col-lg-11">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio conversazione"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:FormView runat="server" OnDataBound="InterventionDetail_DataBound" ID="InterventionDetail" ItemType="VALE.Models.Intervention" SelectMethod="GetIntervention">
                                <ItemTemplate>
                                    <asp:Label Font-Bold="true" Text="Autore: " runat="server"><%#: Item.Creator.FullName %></asp:Label><br />
                                    <asp:Label Font-Bold="true" Text="Data: " runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label><br />
                                    <br />
                                    <asp:Label ID="txtDescription" runat="server"></asp:Label><br />
                                    <p></p>
                                </ItemTemplate>
                            </asp:FormView>
                            <uc:FileUploader ID="FileUploader" runat="server" />
                            <p><br /></p>

                            <div class="col-sm-12 col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Commenti
                                                     <div class="navbar-right">
                                                         <button type="button" id="addComment" class="btn btn-success btn-xs" runat="server" title="Aggiungi commento" onserverclick="OpenPopUp_Click"><span class="glyphicon glyphicon-plus"></span></button>
                                                     </div>
                                    </div>
                                    <div class="panel-body">
                                        <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:GridView runat="server" ID="grdComments" AllowPaging="true" PageSize="10" AutoGenerateColumns="false" OnRowCommand="grdComments_RowCommand" OnDataBound="grdComments_DataBound" ItemType="VALE.Models.Comment" DataKeyNames="CommentId" AllowSorting="true"
                                                    SelectMethod="grdComments_GetData" CssClass="able table-striped table-bordered" EmptyDataText="Non sono presenti commenti.">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label runat="server"><%#: Item.Date %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="100px" />
                                                            <ItemStyle Width="100px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="CreatorUserName" CommandName="sort" runat="server" ID="labelCreatorUserName"><span  class="glyphicon glyphicon-credit-user"></span> Autore</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="150px" />
                                                            <ItemStyle Width="150px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="CommentText" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Commento</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label ID="txtCommentDescription" runat="server"><%#: Item.CommentText %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:LinkButton runat="server" ID="deleteComment"
                                CommandName="DeleteComment" CommandArgument="<%# Item.CommentId %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="30px" />
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerSettings Position="Bottom" />
                                                    <PagerStyle Height="30px" HorizontalAlign="Center" CssClass="GridPager" />
                                                </asp:GridView>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

                <asp:ModalPopupExtender ID="PopupAddComments" runat="server"
                    PopupControlID="pnlListProject" TargetControlID="lnkDummy1" BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
                <asp:LinkButton ID="lnkDummy1" runat="server"></asp:LinkButton>
                <div class="panel panel-primary" id="pnlListProject" style="width: 60%;">
                    <div class="panel-heading">
                        <asp:Label ID="TitleMpdalView" runat="server" Text="Aggiungi un commento"></asp:Label>
                        <asp:Button runat="server" CssClass="close" CausesValidation="false" OnClick="ClosePopUp_Click" Text="x" />
                    </div>
                    <div class="panel-body" style="max-height: 500px">
                        <div>
                            <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                            <div class="form-group">
                                <asp:Panel runat="server">
                                    <asp:Label runat="server" ID="AddTextForConversation" AssociatedControlID="AddTextForConversation" Text="Testo *"></asp:Label>
                                    <textarea class="form-control" rows="10" cols="10" maxlength="2048" id="txtComment" runat="server"></textarea>
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="AddComment" ControlToValidate="txtComment" CssClass="text-danger" ErrorMessage="Il campo testo è obbligatorio" />
                                    <div class="row">
                                        <div class="col-md-11">
                                            <div class="col-md-11">
                                                <br />
                                            </div>
                                            <div class="col-md-offset-10 col-md-12">
                                                <asp:Button runat="server" CssClass="btn btn-info btn-sm" ID="btnAddComment" CausesValidation="true" ValidationGroup="AddComment" Text="Salva" OnClick="btnAddComment_Click" />
                                                <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="ClosePopUp_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
    </div>
</asp:Content>