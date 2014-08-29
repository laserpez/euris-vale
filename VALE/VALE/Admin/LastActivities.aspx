<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LastActivities.aspx.cs" Inherits="VALE.Admin.LastActivities" %>
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
                                    <div class="col-lg-8">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Ultime attività"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">
                                        <asp:Button runat="server" Text="Esporta Log CSV" CssClass="btn btn-info btn-sm" ID="btnExportCSV" OnClick="btnExportCSV_Click" />
                                        <asp:Button runat="server" Text="Cancella Log" CssClass="btn btn-danger btn-sm" ID="btnDeleteAllLogs" OnClick="btnDeleteAllLogs_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="grdLog" CssClass="table table-striped table-bordered" runat="server" ItemType="VALE.Logic.LogEntry" AutoGenerateColumns="false" SelectMethod="GetLogEntry"
                                        GridLines="None" AllowPaging="true" AllowSorting="true" EmptyDataText="Non sono presenti aggiornamenti sulle ultime attività." PageSize="10">
                                        <Columns>
                                            <asp:BoundField HeaderStyle-Width="10%" DataFormatString="{0:d}" DataField="Date" HeaderText="Data" SortExpression="Date" />
                                            <asp:TemplateField HeaderText="Tipo" SortExpression="DataType" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <center><div><span title="<%#: Item.DataType %>" class="<%#:Item.DataTypeUrl %>"></span></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderStyle-Width="20%" ItemStyle-Font-Bold="false" DataField="DataAction" HeaderText="Azione" SortExpression="DataAction" />
                                            <asp:BoundField HeaderStyle-Width="55%" ItemStyle-Font-Bold="false" DataField="Description" HeaderText="Dettagli" SortExpression="Description" />
                                            <asp:BoundField HeaderStyle-Width="10%" ItemStyle-Font-Bold="false" DataField="Username" HeaderText="Utente" SortExpression="Username" />
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
</asp:Content>
