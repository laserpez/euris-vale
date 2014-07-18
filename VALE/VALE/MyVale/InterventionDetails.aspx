<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterventionDetails.aspx.cs" Inherits="VALE.MyVale.InterventionDetails" %>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Interventi"></asp:Label>
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
                                    <asp:Label runat="server"><%#: String.Format("Autore: {0}", Item.Creator.FullName) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Data: {0}", Item.Date.ToShortDateString()) %></asp:Label><br />
                                    <asp:Label ID="txtDescription" runat="server"></asp:Label><br />
                                    <p></p>
                                    <asp:Label ID="labelAttachment" runat="server" Text="Documenti allegati" CssClass="h4"></asp:Label>
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                        ItemType="VALE.Models.AttachedFile" EmptyDataText="Nessun allegato." AllowPaging="true" PageSize="10"
                                                        CssClass="table table-striped table-bordered"
                                                        OnRowCommand="grdFilesUploaded_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="FileName" HeaderStyle-Width="25%">
                                                                <ItemTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD" CausesValidation="false"><%#: Item.FileName %></asp:LinkButton></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="50px"></HeaderStyle>
                                                                <ItemStyle Width="50px"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="FileDescription" HeaderText="Descrizione" HeaderStyle-Width="70%" />
                                                        </Columns>
                                                        <PagerTemplate>
                                                            <asp:GridPager runat="server"
                                                                ShowFirstAndLast="true" ShowNextAndPrevious="true" PageLinksToShow="10"
                                                                NextText=">" PreviousText="<" FirstText="Prima" LastText="Ultima" />
                                                        </PagerTemplate>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <p></p>
                                </ItemTemplate>
                            </asp:FormView>
                            <p></p>
                            <asp:Label runat="server" Text="Commenti" CssClass="h4"></asp:Label>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Panel runat="server">
                                        <asp:Label runat="server" Text="Aggiungi commento:"></asp:Label>
                                        <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtComment"></asp:TextBox>
                                        <p></p>
                                        <asp:Button runat="server" CssClass="btn btn-info btn-xs" ID="btnAddComment" Text="Aggiungi" OnClick="btnAddComment_Click" />
                                    </asp:Panel>
                                    <br />
                                    <div class="panel panel-default">
                                        <div class="panel-heading">Commenti</div>
                                        <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <div class="panel-body">
                                                    <asp:ListView runat="server" ID="lstComments" OnDataBound="lstComments_DataBound" ItemType="VALE.Models.Comment" SelectMethod="GetComments">
                                                        <EmptyDataTemplate>
                                                            <asp:Label runat="server" Text="Non sono ancora presenti commenti."></asp:Label>
                                                        </EmptyDataTemplate>
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.CreatorUserName %></asp:Label>
                                                            <asp:Label runat="server"><%#: String.Format(" - {0}", Item.Date) %></asp:Label>
                                                            <asp:LinkButton runat="server" ID="deleteComment" ToolTip="Cancella commento" Visible="false" CommandArgument="<%#: Item.CommentId %>" CausesValidation="false" OnClick="deleteComment_Click"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton><br />
                                                            <asp:Label runat="server"><%#: Item.CommentText %></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemSeparatorTemplate>
                                                            <br />
                                                        </ItemSeparatorTemplate>
                                                    </asp:ListView>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
