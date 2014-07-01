<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserSelector.aspx.cs" Inherits="VALE.MyVale.UserSelector" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Scelta utenti"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtSearchUsers" runat="server"></asp:TextBox>
                                    <asp:Button CssClass="btn btn-info" ID="btnSearchUsers" runat="server" Text="Cerca utente" OnClick="btnSearchUsers_Click" />
                            <asp:GridView ID="UsersGridView" runat="server" ItemType="VALE.Models.UserData" AllowPaging="true" PageSize="10" AllowSorting="true" SelectMethod="UsersGridView_GetData">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-open"></span> Azione</asp:Label></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Button ID="btnAddUsers" Width="90" CssClass="btn btn-info btn-xs" Text="Aggiungi" runat="server" OnClick="btnAddUsers_Click" CommandName="<%# Item.UserName %>" /></div></center>
                                        </ItemTemplate>
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <asp:Label runat="server">Nessun utente da aggiungere.</asp:Label>
                                </EmptyDataTemplate>
                            </asp:GridView>
                                    <asp:Button CssClass="btn btn-info" ID="btnReturn" runat="server" Text="Fine" OnClick="btnReturn_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
