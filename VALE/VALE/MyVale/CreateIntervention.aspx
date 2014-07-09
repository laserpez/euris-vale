<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateIntervention.aspx.cs" Inherits="VALE.MyVale.CreateIntervention" %>
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
                                <div class="col-lg-12">
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Aggiungi conversazione"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div class="col-md-12"></div>
                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Inserisci commento</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox TextMode="MultiLine" runat="server" ID="txtComment" CssClass="form-control" Height="145px" Width="404px" />
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComment" CssClass="text-danger" ErrorMessage="Il campo Inserisci commento è obbligatorio"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                            <%--<asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Aggiungi file</asp:Label>--%>
                            <div class="col-md-10">
                                <%--<asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
                                <asp:Label runat="server" ID="StatusLabel" Text="" />
                                <asp:Button runat="server" CausesValidation="false" Text="Carica" ID="btnUploadFile" CssClass="btn btn-info btn-xs" OnClick="btnUploadFile_Click" />--%>
                                <uc:FileUploader ID="FileUploader" Visible="false" runat="server" AllowUpload="true" />
                            </div>
                            <%--<asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">File caricati</asp:Label>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="col-md-10">
                                        <asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="Nessun file caricato."
                                            ID="grdFilesUploaded" runat="server">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <center>
                                    <div>
                                        <asp:Button CausesValidation="false" CssClass="btn btn-danger btn-xs" Width="90" runat="server" CommandName="DeleteFile"
                                            CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Elimina" />
                                    </div>
                                </center>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="100px" />
                                                    <ItemStyle Width="100px" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>--%>
                            <div class="col-md-12">
                                <br />
                            </div>
                            <div class="col-md-12">
                            <asp:Button runat="server" CssClass="btn btn-primary" CausesValidation="false" Text="Aggiungi allegati" ID="btnSaveInterventionWithAttachment" OnClick="btnSaveInterventionWithAttachment_Click" />
                            <asp:Button runat="server" CssClass="btn btn-primary" CausesValidation="false" Text="Salva conversazione" ID="btnSaveIntervention" OnClick="btnSaveIntervention_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
