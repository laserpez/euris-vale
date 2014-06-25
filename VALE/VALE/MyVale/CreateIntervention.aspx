<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateIntervention.aspx.cs" Inherits="VALE.MyVale.CreateIntervention" %>
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
                                                            <asp:Label ID="HeaderName" runat="server" Text="Crea un intervento"></asp:Label>
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
                                    <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Aggiungi file</asp:Label>
                                    <div class="col-md-10">
                                        <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
                                        <asp:Label runat="server" ID="StatusLabel" Text="" />
                                        <asp:Button runat="server" CausesValidation="false" Text="Carica" ID="btnUploadFile" CssClass="btn btn-info btn-xs" OnClick="btnUploadFile_Click" />
                                    </div>
                                    <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">File caricati</asp:Label>
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
                                    </asp:UpdatePanel>
                                    <div class="col-md-12">
                                        <br />
                                    </div>
                                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Salva intervento" ID="btnSaveIntervention" OnClick="btnSaveIntervention_Click" />
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnUploadFile" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
