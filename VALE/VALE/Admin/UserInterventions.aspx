<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserInterventions.aspx.cs" Inherits="VALE.Admin.UserInterventions" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Interventi dell'utente {0} sul progetto {1}"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <br />
                            <asp:Label ID="lblSummary" Font-Size="Large" Font-Bold="true" ForeColor="#317eac" runat="server"></asp:Label>
                            <br />
                            <asp:ListView OnDataBound="lstInterventions_DataBound" runat="server" ID="lstInterventions" SelectMethod="GetInterventions" ItemType="VALE.Models.Intervention">
                                <ItemSeparatorTemplate>
                                    <br />
                                </ItemSeparatorTemplate>
                                <ItemTemplate>
                                    <asp:HiddenField runat="server" ID="ItemId" Value="<%#: Item.InterventionId %>" />
                                    <asp:Label runat="server" Text="Testo: "></asp:Label>
                                    <asp:Label runat="server" ID="txtDescription"></asp:Label><br />
                                    <asp:Label runat="server" Text="Data: "></asp:Label>
                                    <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label><br />

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                        ItemType="VALE.Models.AttachedFile" EmptyDataText="Nessun allegato." AllowPaging="true"
                                                        CssClass="table table-striped table-bordered" PageSize="10"
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
                                                        <PagerSettings Position="Bottom" />
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
