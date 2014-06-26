<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UploadFile.aspx.cs" Inherits="VALE.UploadFile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <legend>Documenti Allegati</legend>
            <div class="panel panel-default">
                <div class="panel-heading"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</div>
                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                    <asp:Label ID="allowDelete" runat="server" Text="PROJECT" Visible="false"></asp:Label>
                    <asp:Label ID="action" runat="server" Text="CREATE" Visible="false"></asp:Label>
                    <asp:Label ID="id" runat="server" Text="" Visible="false"></asp:Label>
                    <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                        ItemType="VALE.Models.AttachedFile"
                        CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="FileName" HeaderText="Nome del file" />
                            <asp:BoundField DataField="FileExtension" HeaderText="Estenssione" />
                            <asp:TemplateField HeaderText="Azione" HeaderStyle-Width="50px" ItemStyle-Width="50px">
                                <ItemTemplate>
                                    <center><div><asp:Button  runat="server" Text="Cancella" value="" class="btn btn-danger btn-xs" OnClick="DeleteDocumentFromProject_Click"/></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="50px"></HeaderStyle>
                                <ItemStyle Width="50px"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="panel-footer" id="FooterDocuments" runat="server">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="form-group col-lg-5">
                                <div class="input-group">
                                    <span class="input-group-addon input-sm"><span class="glyphicon glyphicon-file"></span></span>
                                    <div runat="server" id="FileTextBox">
                                        <asp:FileUpload ID="FileUpload" runat="server" class="form-control input-sm" />
                                    </div>
                                    <span class="input-group-btn">
                                        <asp:Button runat="server" ID="AddFileNameButton" class="btn btn-default btn-sm" Text="Aggiungi" OnClick="AddFileNameButton_Click" />
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
