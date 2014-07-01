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

                            <asp:TextBox ID="txtSearchUsers" runat="server"></asp:TextBox>

                            <asp:GridView ID="UsersGridView" EmptyDataText="Nessun utente" runat="server" AutoGenerateColumns="true" ItemType="VALE.Models.UserData" AllowPaging="true" AllowSorting="true" SelectMethod="UsersGridView_GetData">


                                
                            </asp:GridView>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
