<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="VALE.MyVale.EventDetails" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettagli evento"></asp:Label>
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
                                    <h3><%#: Item.Name %></h3>
                                    <asp:Button ID="btnAttend" Text="Partecipa" runat="server" OnClick="btnAttend_Click" /><br />
                                    <asp:Label runat="server"><%#: String.Format("Data: {0}", Item.EventDate.ToShortDateString()) %></asp:Label>
                                    <br />
                                    <asp:Label runat="server"><%#: String.Format("Organizzatore: {0}", Item.Organizer.FullName) %></asp:Label>
                                    <br />
                                    <asp:Label runat="server"><%#: Item.Public ? "Pubblico" : "Privato" %></asp:Label>
                                    <br />
                                    <asp:Label runat="server"><%#: String.Format("Descrizione: {0}", Item.Description) %></asp:Label><br />
                                    <h4>Partecipanti</h4>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                SelectMethod="GetRegisteredUsers" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center>
                                        <div>
                                            <asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-th"></span>Nome</asp:LinkButton>
                                        </div>
                                    </center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center>
                                        <div>
                                            <asp:Label runat="server"><%#: Item.FullName %></asp:Label>
                                        </div>
                                    </center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center>
                                        <div>
                                            <asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-th"></span>Email</asp:LinkButton>
                                        </div>
                                    </center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center>
                                        <div>
                                            <asp:Label runat="server"><%#: Item.Email %></asp:Label>
                                        </div>
                                    </center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessun utente registrato.</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <h4>Progetto correlato</h4>
                                    <asp:FormView runat="server" ID="ProjectDetail" EmptyDataText="Nessun progetto correlato." ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                                        <ItemTemplate>
                                            <a href="ProjectDetails.aspx?projectId=<%#:Item.ProjectId %>"><%#: Item.ProjectName %></a>
                                            <br />
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <br />
                                    <asp:Label runat="server" ID="AttachmentsLabel" Text="Documenti" CssClass="h4"></asp:Label>
                                    <asp:ListBox runat="server" CssClass="form-control" Width="400px" ID="lstDocuments" SelectMethod="GetRelatedDocuments"></asp:ListBox>
                                    <asp:Button runat="server" Text="Scarica" CssClass="btn btn-info" ID="btnViewDocument" OnClick="btnViewDocument_Click" />
                                </ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
