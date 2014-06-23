<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateIntervention.aspx.cs" Inherits="VALE.MyVale.CreateIntervention" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Crea un intervento</h4>
    <div class="col-md-12"></div>
    <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Inserisci commento</asp:Label>
    <div class="col-md-10">
        <asp:TextBox TextMode="MultiLine" runat="server" ID="txtComment" CssClass="form-control" Height="145px" Width="404px" />
    </div>
    <div class="col-md-12"><br /></div>
    <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Aggiungi file</asp:Label>
    <div class="col-md-10">
        <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
        <asp:Label runat="server" ID="StatusLabel" Text="" />
        <asp:Button runat="server" CausesValidation="false" Text="Carica" ID="btnUploadFile" CssClass="btn btn-info" OnClick="btnUploadFile_Click" />
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
    <div class="col-md-12"><br /></div>
    <asp:Button runat="server" CssClass="btn btn-primary" Text="Salva intervento" ID="btnSaveIntervention" OnClick="btnSaveIntervention_Click" />
</asp:Content>
