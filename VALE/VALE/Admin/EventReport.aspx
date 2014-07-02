<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventReport.aspx.cs" Inherits="VALE.Admin.EventReport" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Report evento"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">

                            <asp:FormView runat="server" ID="EventDetail" ItemType="VALE.Models.Event" SelectMethod="GetEvent">
                                <ItemTemplate>

                                    <asp:Label runat="server"><%#: String.Format("Titolo: {0}", Item.Name) %></asp:Label>
                                    <br />
                                    <asp:Label runat="server"><%#: String.Format("Data: {0}", Item.EventDate.ToShortDateString()) %></asp:Label>
                                    <br />
                                    <asp:Label runat="server"><%#: String.Format("Creato da: {0}", Item.Organizer.FullName) %></asp:Label>
                                    <br />
                                    <asp:Label runat="server"><%#: Item.Public ? "Evento pubblico" : "Evento privato" %></asp:Label>
                                    <br />
                                    <asp:Label runat="server"><%#: String.Format("Descrizione: {0}", Item.Description) %></asp:Label><br />
                                    <h4>Utenti registrati</h4>
                                    <asp:ListView ItemType="VALE.Models.UserData" SelectMethod="GetRegisteredUsers" runat="server" ID="lstUsers">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ForeColor="#317eac" Font-Bold="true"><%#: Item.FullName %></asp:Label><br />
                                            <asp:Label runat="server"><%#: Item.Email %></asp:Label>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <asp:Label runat="server">Nessun utente registrato.</asp:Label>
                                        </EmptyDataTemplate>
                                        <ItemSeparatorTemplate>
                                            <br />
                                        </ItemSeparatorTemplate>
                                    </asp:ListView>
                                    <br />
                                </ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
