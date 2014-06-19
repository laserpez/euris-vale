<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateIntervention.aspx.cs" Inherits="VALE.MyVale.CreateIntervention" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Create intervention</h4>
    <asp:Label runat="server" CssClass="col-md-2 control-label">You can write a comment</asp:Label>
    <div class="col-md-10">
        <asp:TextBox TextMode="MultiLine" runat="server" ID="txtComment" CssClass="form-control" Height="145px" Width="404px" />
    </div>
            <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">or upload file</asp:Label>
            <div class="col-md-10">
                <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
                <asp:Label runat="server" ID="StatusLabel" Text="" />
                <asp:Button runat="server" CausesValidation="false" Text="Upload" ID="btnUploadFile" CssClass="btn btn-info" OnClick="btnUploadFile_Click" />
            </div>
            <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Uploaded file</asp:Label>
            <div class="col-md-10">
                <asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="No files uploaded"
                    ID="grdFilesUploaded" runat="server">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button CausesValidation="false" CssClass="btn btn-danger btn-sm" runat="server" CommandName="DeleteFile"
                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Delete file" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
    <asp:Button runat="server" CssClass="btn btn-primary" Text="Save intervention" ID="btnSaveIntervention" OnClick="btnSaveIntervention_Click" />
    <br />
</asp:Content>
