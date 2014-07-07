<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VALEDocuments.aspx.cs" Inherits="VALE.MyVale.BOD.VALEDocuments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<br />
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</div>
            <div class="panel-body" style="max-height: 200px; overflow: auto;">
                <asp:Label ID="allowDelete" runat="server" Text="PROJECT" Visible="false"></asp:Label>
                <asp:Label ID="action" runat="server" Text="CREATE" Visible="false"></asp:Label>
                <asp:Label ID="id" runat="server" Text="" Visible="false"></asp:Label>
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                            ItemType="VALE.Models.ValeFile"
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
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="panel-footer" id="FooterDocuments" runat="server">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-group col-lg-5">
                            <div class="input-group">
                                <span class="input-group-addon input-sm"><span class="glyphicon glyphicon-file"></span></span>
                                <div runat="server" id="FileTextBox">
                                    <asp:FileUpload ID="FileUpload" runat="server" CssClass="form-control input-sm" />
                                </div>
                                <span class="input-group-btn">
                                    <asp:Button runat="server" ID="AddFileNameButton" ValidationGroup="UploadFile" CssClass="btn btn-default btn-sm" Text="Aggiungi" OnClick="AddFileNameButton_Click" />
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <asp:Label ID="Label1" runat="server" Text="Label">Descrizione * </asp:Label>
                        <asp:TextBox ID="txtFileDescription" runat="server" CssClass="form-control" Width="300px"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ValidationGroup="UploadFile" ControlToValidate="txtFileDescription" CssClass="text-danger" ErrorMessage="Il campo Descrizione è richiesto." />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>
