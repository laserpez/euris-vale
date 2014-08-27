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
                                    <div class="col-lg-8">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Gestione Servizio E-Mail"></asp:Label>
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
                        <div class="panel-body" style="overflow: auto">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="grdLogEmail" DataKeyNames="LogEntryEmailId" CssClass="table table-striped table-bordered" runat="server" ItemType="VALE.Logic.LogEntryEmail" AutoGenerateColumns="false" SelectMethod="grdLogEmail_GetData"
                                        GridLines="None" AllowPaging="true" AllowSorting="true" PageSize="10">
                                        <EmptyDataTemplate>
                                            <table>
                                                <tr>
                                                    <td>Nessuna email circolante nel sistema.</td>
                                                </tr>
                                            </table>
                                        </EmptyDataTemplate>
                                        <Columns>
                                            <asp:BoundField ItemStyle-Font-Bold="false" DataField="Date" HeaderText="Data" SortExpression="Date" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:LinkButton runat="server" CommandArgument="Sent" CommandName="sort">Stato ricezione</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label runat="server"><%#: GetStatus(Item) %></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField ItemStyle-Font-Bold="false" DataField="Receiver" HeaderText="Destinatario" SortExpression="Receiver" />
                                            <%--<asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" CommandArgument="Receiver" CommandName="sort">Destinatario</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:ListView runat="server" ID="ToListView">
                                                                        <EmptyDataTemplate>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>Non sono presenti destinatari.</td>
                                                                                </tr>
                                                                            </table>
                                                                        </EmptyDataTemplate>
                                                                        <ItemTemplate>
                                                                            <asp:Label runat="server"><%#: Container.DataItem %></asp:Label>
                                                                        </ItemTemplate>
                                                                        <ItemSeparatorTemplate>
                                                                            <br />
                                                                        </ItemSeparatorTemplate>
                                                                    </asp:ListView>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>--%>
                                            <asp:BoundField ItemStyle-Font-Bold="false" DataField="DataType" HeaderText="Modulo" SortExpression="DataType" />
                                            <asp:BoundField ItemStyle-Font-Bold="false" DataField="DataAction" HeaderText="Oggetto" SortExpression="DataAction" />
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:LinkButton runat="server" CommandArgument="Body" CommandName="sort"></asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label runat="server"><%#: GetBody(Item.Body) %></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:BoundField ItemStyle-Font-Bold="false" DataField="Body" HeaderText="Corpo della mail" SortExpression="Body" />--%>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <asp:LinkButton runat="server" CommandArgument="Error" CommandName="sort">Messaggio d'errore</asp:LinkButton>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:Label runat="server"><%#: Item.Error == null ? "Nessun messaggio d'errore" : Item.Error %></asp:Label>
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
                <%--</div>
            </div>
        </div>
    </div>--%>
</asp:Content>
