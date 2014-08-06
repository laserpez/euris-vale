<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageEmailSystem.aspx.cs" Inherits="VALE.Admin.ManageEmailSystem" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Gestione Servizio E-Mail"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div id="log" class="panel panel-default" runat="server">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-12" style="font-size: 24px">
                                            Ultime E-Mail inviate
                                        </div>
                                        <div class="col-md-12">
                                            <br />
                                        </div>
                                    </div>

                                    <div class="row">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:GridView ID="grdLogEmail" CssClass="table table-striped table-hover" EmptyDataText="Nessuna email circolante nel sistema." runat="server" ItemType="VALE.Logic.LogEntryEmail" AutoGenerateColumns="false" SelectMethod="grdLogEmail_GetData"
                                                    GridLines="None" AllowPaging="true" AllowSorting="true" PageSize="10">
                                                    <Columns>
                                                        <asp:BoundField HeaderStyle-Width="20%" DataFormatString="{0:d}" DataField="Date" HeaderText="Data" SortExpression="Date" />
                                                        <asp:TemplateField HeaderText="Tipo" SortExpression="DataType" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <span title="<%#: Item.DataType %>" class="<%#:Item.DataTypeUrl %>"></span>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField HeaderStyle-Width="20%" ItemStyle-Font-Bold="false" DataField="DataAction" HeaderText="Azione" SortExpression="DataAction" />
                                                        <asp:BoundField ItemStyle-Font-Bold="false" DataField="Sender" HeaderText="Mittente" SortExpression="Sender" />
                                                        <asp:BoundField ItemStyle-Font-Bold="false" DataField="Receiver" HeaderText="Destinatario" SortExpression="Receiver" />
                                                        <asp:BoundField ItemStyle-Font-Bold="false" DataField="Description" HeaderText="Oggetto" SortExpression="Description" />
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton runat="server" CommandArgument="Sent" CommandName="sort">Ricezione</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label runat="server"><%#: Item.Sent== true ? "Inviato" : "Rifiutato" %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton runat="server" CommandArgument="Error" CommandName="sort">Messaggio d'errore</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label runat="server"><%#: Item.Error == null ? "Nessun messaggio d'errore" : Item.Error %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
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
            </div>
        </div>
    </div>
</asp:Content>
