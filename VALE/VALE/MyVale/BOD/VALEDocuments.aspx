<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VALEDocuments.aspx.cs" Inherits="VALE.MyVale.BOD.VALEDocuments" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bs-docs-section">
        <br />
        <div class="row">
            <div class="col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-lg-7">
                                    <ul class="nav nav-pills">
                                        <li>
                                            <h4>
                                                <asp:Label ID="HeaderName" runat="server" Text="Documenti Vale"></asp:Label>
                                            </h4>
                                        </li>
                                    </ul>
                                </div>
                                <div class="navbar-right">
                                    <asp:Button runat="server" Text="Aggiungi Documento"  CssClass="btn btn-success" ID="btnAddDocument" OnClick="btnAddDocument_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body" style="overflow: auto;">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati
                                        
                                    </div>
                                    <div class="panel-body">
                                        <asp:Label ID="allowDelete" runat="server" Text="PROJECT" Visible="false"></asp:Label>
                                        <asp:Label ID="action" runat="server" Text="CREATE" Visible="false"></asp:Label>
                                        <asp:Label ID="id" runat="server" Text="" Visible="false"></asp:Label>
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                    ItemType="VALE.Models.ValeFile" AllowPaging="true" PageSize="10" EmptyDataText="Non ci sono file allegati."
                                                    CssClass="table table-striped table-bordered"
                                                    OnRowCommand="grdFilesUploaded_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="FileName" HeaderStyle-Width="25%">
                                                            <ItemTemplate>
                                                                <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.ValeFileID %>" CommandName="DOWNLOAD" CausesValidation="false"><%#: Item.FileName %></asp:LinkButton></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="50px"></HeaderStyle>
                                                            <ItemStyle Width="50px"></ItemStyle>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="FileDescription" HeaderText="Descrizione" HeaderStyle-Width="70%" />
                                                        <asp:TemplateField HeaderText="Azione" HeaderStyle-Width="50px" ItemStyle-Width="50px">
                                                            <ItemTemplate>
                                                                <center><div><asp:Button  runat="server" Text="Cancella" Enabled='<%# AllowDelete(Convert.ToInt32(Eval("ValeFileID"))) %>'  CssClass="btn btn-danger btn-xs" CommandArgument="<%# Item.ValeFileID %>" CommandName="Cancella" CausesValidation="false" /></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="50px"></HeaderStyle>
                                                            <ItemStyle Width="50px"></ItemStyle>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <PagerSettings Position="Bottom" />
                                                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
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
    </div>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupAddDocument" runat="server"
                PopupControlID="pnlPopupAddDocument" TargetControlID="lnkDummyPopupAddDocument" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupAddDocument" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupAddDocument" style="width: 60%;">
                <div class="row">
                    <div class="col-md-12">
                        <legend>Allega un documento</legend>
                    </div>
                    <div class="col-md-12">
                        <br />
                        <asp:ValidationSummary runat="server"></asp:ValidationSummary>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">File *</label>
                        <div class="col-md-10">
                            <asp:FileUpload ID="FileUploadAddDocument" runat="server" CssClass="well well-sm"></asp:FileUpload>
                            <asp:Label ID="LabelPopUpAddDocumentError" CssClass="text-danger" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                     <div class="form-group">
                        <br />
                        <label class="col-md-2 control-label">Descrizione *</label>
                        <div class="col-md-10">
                            <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtFileDescription" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFileDescription" CssClass="text-danger" ValidationGroup="AddDocumentPopUp" ErrorMessage="Il campo Descrizione è obbligatorio." />
                        </div>
                    </div>
        
                    <div class="col-md-12">
                        <br />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpAddDocument" CssClass="btn btn-success btn-sm" ValidationGroup="AddDocumentPopUp" OnClick="btnPopUpAddDocument_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpAddDocumentClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpAddDocumentClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnPopUpAddDocument" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
