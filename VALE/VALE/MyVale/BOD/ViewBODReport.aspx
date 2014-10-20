<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewBODReport.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits="VALE.MyVale.BOD.ViewBODReport" %>
<%@ Register Src="~/MyVale/FileUploader.ascx" TagPrefix="uc" TagName="FileUploader" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio del verbale"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:FormView runat="server" ID="BODReportDetail" OnDataBound="BODReportDetail_DataBound" ItemType="VALE.Models.BODReport" SelectMethod="GetBODReport" Width="100%">
                                <ItemTemplate>
                                    <h4>Sommario</h4>
                                    <asp:Label runat="server">Nome: </asp:Label>
                                    <asp:Label runat="server"><%#: Item.Name %></asp:Label><br />
                                    <asp:Label runat="server">Luogo: </asp:Label>
                                    <asp:Label runat="server"><%#: Item.Location %></asp:Label><br />
                                    <asp:Label runat="server">Data riunione: </asp:Label>
                                    <asp:Label runat="server"><%#: Item.MeetingDate.ToShortDateString() %></asp:Label><br />
                                    <asp:Label runat="server">Data di pubblicazione: </asp:Label>
                                    <asp:Label runat="server"><%#: Item.PublishingDate.HasValue ? Item.PublishingDate.Value.ToShortDateString() : "" %></asp:Label><br />
                                    <asp:Label runat="server"><br /></asp:Label>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="well col-md-12">
                                                <asp:Label ID="lblContent" runat="server"></asp:Label><br />
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button runat="server" CausesValidation="false" Text="Aggiungi Documento" CssClass="btn btn-success btn-xs" ID="btnAddDocument" OnClick="btnAddDocument_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                                ItemType="VALE.MyVale.AttachedFileGridView" AllowPaging="true" PageSize="10" EmptyDataText="Non ci sono file allegati."
                                                                CssClass="table table-striped table-bordered" AllowSorting="true"
                                                                OnRowCommand="grdFilesUploaded_RowCommand">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileName"><span  class="glyphicon glyphicon-file"></span> Nome File</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:LinkButton ToolTip="<%# Item.FileName %>"  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD_FILE" CausesValidation="false"><%#: Item.FileName.Length < 20 ? Item.FileName : Item.FileName.Substring(0, 18) + "..." %></asp:LinkButton></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="25%"></HeaderStyle>
                                                                        <ItemStyle Width="25%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileExtension"><span  class="glyphicon glyphicon-tag"></span> Tipo</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><%#: Item.FileExtension %></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="70px"></HeaderStyle>
                                                                        <ItemStyle Width="70px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileDescription"><span class="glyphicon glyphicon-list"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server" ToolTip="<%#: Item.FileDescription%>"><%#: Item.FileDescription.Length < 20 ? Item.FileDescription : Item.FileDescription.Substring(0, 18) + "..." %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="Owner"><span  class="glyphicon glyphicon-user"></span> Autore</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.Owner %>"><asp:Label runat="server"><%#: Item.Owner %></asp:Label></a></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="15%"></HeaderStyle>
                                                                        <ItemStyle Width="15%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="VersionCount"><span class="glyphicon glyphicon-list-alt"></span> Versioni</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.FileName %>" CommandName="SHOW_VERSIONS" CausesValidation="false"><span runat="server" class="badge"><%#: Item.VersionCount %></span></asp:LinkButton></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="100px"></HeaderStyle>
                                                                        <ItemStyle Width="100px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="CreationDate"><span  class="glyphicon glyphicon-th"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                                        <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <div>
                                                                                    <asp:LinkButton ID="btnDownloadFile" ToolTip="Scarica il file" runat="server" CausesValidation="false" CommandName="DOWNLOAD_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-success"><span class="glyphicon glyphicon-save"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnShowDiscription" ToolTip="Visualiza informazione del file" runat="server" CausesValidation="false" CommandName="SHOW_DESC" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-primary"><span class="glyphicon glyphicon-info-sign"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnUpdateFile" ToolTip="Aggiorna il file" runat="server" CausesValidation="false" CommandName="UPDATE_FILE" CommandArgument="<%# Item.FileName %>"><span class="label label-default"><span class="glyphicon glyphicon-refresh"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnShowVersions" ToolTip="Visualiza i versioni del file" runat="server" CausesValidation="false" CommandName="SHOW_VERSIONS" CommandArgument="<%# Item.FileName %>"><span class="label label-info"><span class="glyphicon glyphicon-list-alt"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnDeleteFile" ToolTip="Cancella il file" runat="server" Visible='<%# AllowUpdateOrDelete(Convert.ToInt32(Eval("AttachedFileID"))) %>' CausesValidation="false" CommandName="DELETE_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                                                                </div>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" ><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="155px"></HeaderStyle>
                                                                        <ItemStyle Width="155px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                            </asp:GridView>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>   <%--Documenti Allegati--%>
                                </ItemTemplate>
                            </asp:FormView>
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
                <asp:Label runat="server" ID="lblOperatioPopupAddDocument" Visible="false" />
                <div class="row">
                    <div class="col-md-12">
                        <legend>
                            <asp:Label runat="server" ID="lblInfoPopupAddDocument" /></legend>
                    </div>
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server"></asp:ValidationSummary>
                    </div>
                    <div runat="server" id="divDocunetPopupAddDocument">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Documento </label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblFileNamePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Versione </label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblVersionPopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div runat="server" id="divInfoPopupAddDocument">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Dimensione </label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblSizeFilePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Data</label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblDatePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Data</label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblHourPopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" runat="server" id="divFileUploderPopupAddDocument">
                        <label class="col-md-2 control-label">File *</label>
                        <div class="col-md-10">
                            <asp:FileUpload ID="FileUploadAddDocument" runat="server" CssClass="well well-sm"></asp:FileUpload>
                            <asp:Label ID="LabelPopUpAddDocumentError" CssClass="text-danger" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">Descrizione *</label>
                        <div class="col-md-10">
                            <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtFileDescription" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFileDescription" ID="validatorFileDescription" CssClass="text-danger" ValidationGroup="AddDocumentPopUp" ErrorMessage="Il campo Descrizione è obbligatorio." />
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
    </asp:UpdatePanel> <%--ModalPopupAddDocument--%>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupViewFileVersions" runat="server"
                PopupControlID="pnlPopupViewFileVersions" TargetControlID="lnkDummyPopupViewFileVersions" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupViewFileVersions" runat="server"></asp:LinkButton>
            <div class="panel panel-default" id="pnlPopupViewFileVersions" style="width: 80%;">
                <div class="panel-heading">
                    <asp:LinkButton ID="btnClosePopupViewFileVersions" CausesValidation="false" runat="server" class="close" OnClick="btnClosePopupViewFileVersions_Click">×</asp:LinkButton>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-8">
                                <ul class="nav nav-pills">
                                    <li>
                                        <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Versioni de file: 
                                        <asp:Label runat="server" ID="lblFileNamePopupViewFileVersions" /></li>
                                </ul>
                            </div>
                            <div class="navbar-right">
                                <%-- <asp:Button runat="server" CausesValidation="false" Text="Aggiungi Documento" CssClass="btn btn-success btn-xs"  />--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                    <asp:GridView ID="ViewFileVersionsGridView" runat="server" AutoGenerateColumns="False"
                        ItemType="VALE.Models.AttachedFile" EmptyDataText="Non ci sono file allegati."
                        CssClass="table table-striped table-bordered"
                        OnRowCommand="ViewFileVersionsGridView_RowCommand">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-barcode"></span> Versione</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD" CausesValidation="false"><span runat="server" class="badge"><%#: Item.Version %></span></asp:LinkButton></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle Width="100px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-tag"></span> Tipo</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><%#: Item.FileExtension %></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                                <ItemStyle Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span class="glyphicon glyphicon-list"></span> Descrizione</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><asp:Label runat="server" ToolTip="<%#: Item.FileDescription%>"><%#: Item.FileDescription.Length < 20 ? Item.FileDescription : Item.FileDescription.Substring(0, 18) + "..." %></asp:Label></div></center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-user"></span> Autore</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><a href="/Account/Profile?Username=<%#: Item.Owner %>"><asp:Label runat="server"><%#: Item.Owner %></asp:Label></a></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="20%"></HeaderStyle>
                                <ItemStyle Width="20%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-th"></span> Data</div></center>
                                </HeaderTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                                <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <center>
                                        <div>
                                            <asp:LinkButton ID="btnDownloadClick" runat="server" CausesValidation="false" CommandName="DOWNLOAD_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-success"><span class="glyphicon glyphicon-save"></span></span></asp:LinkButton>
                                            <asp:LinkButton ID="btnShowDiscClick" runat="server" CausesValidation="false" CommandName="SHOW_DESC" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-primary"><span class="glyphicon glyphicon-info-sign"></span></span></asp:LinkButton>
                                            <asp:LinkButton ID="btnDeleteClick" runat="server" Visible='<%# AllowUpdateOrDelete(Convert.ToInt32(Eval("AttachedFileID"))) %>' CausesValidation="false" CommandName="DELETE_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                        </div>
                                    </center>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-cog"></span> Azioni</div></center>
                                </HeaderTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                                <ItemStyle Width="115px"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>

                    </asp:GridView>

                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel> <%--ModalPopupViewFileVersions--%>
</asp:Content>
