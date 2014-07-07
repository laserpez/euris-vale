<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="VALE.Profile" %>
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
                                                    <asp:Label ID="HeaderName" runat="server"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div class="col-md-12 form-group">
                                <div id="PersonalData">
                                    <asp:FormView runat="server" ID="PersonalDataFormView" ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun dato presente." SelectMethod="GetUserData">
                                        <ItemTemplate>
                                            <div style="border: ridge; height: 122px; width: 112px">
                                                <div id="photo" style="border: thin; height: 114px; width: 104px">
                                                    <asp:Image ImageUrl="~/DownloadFile.ashx?fileId=<% Item.UserName %>" runat="server" height="114" width="104" />
                                                </div>
                                            </div>
                                            <asp:Label runat="server" Font-Bold="true"><%#: String.Format(Item.UserName) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Nome:\t{0}", Item.FirstName) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Cognome:\t{0}", Item.LastName) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("E-mail:\t{0}", Item.Email) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Residenza:\t{0} {1}", Item.Address, Item.City) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Telefono:\t{0}", Item.Telephone) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Cellulare:\t{0}", Item.CellPhone) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Codice fiscale:\t{0}", Item.CF) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Ruolo:\t{0}", GetRole(Item.Id)) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Descrizione:\t{0}", Item.Description) %></asp:Label>
                                        </ItemTemplate>
                                    </asp:FormView>
                                </div>
                            </div>
                            <div class="col-md-12"><br /></div>
                            <div class="col-md-12 form-group">
                                <div id="ChangeProfile">
                                    <asp:Button runat="server" ID="EditProfile" CssClass="btn btn-warning btn-xs" Text="Aggiorna il tuo profilo" CausesValidation="false" Visible="true" OnClick="EditProfile_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
