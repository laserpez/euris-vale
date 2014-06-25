<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalEvents.aspx.cs" Inherits="VALE.MyVale.PersonalEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-6">
                                                <ul class="nav nav-pills col-lg-6">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Eventi a cui partecipi"></asp:Label>
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
                                            <asp:GridView runat="server" DataKeyNames="EventId" ItemType="VALE.Models.Event" AutoGenerateColumns="false" AllowSorting="true" EmptyDataText="Nessun evento pianificato"
                                                CssClass="table table-striped table-bordered" ID="grdPlannedEvent" SelectMethod="GetAttendingEvents">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center>
                                <div>
                                    <asp:LinkButton CommandArgument="EventDate" CommandName="sort" runat="server" ID="labelEventDate"><span  class="glyphicon glyphicon-th"></span>Data</asp:LinkButton>
                                </div>
                            </center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center>
                                <div>
                                    <asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label>
                                </div>
                            </center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="140px" />
                                                        <ItemStyle Width="140px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center>
                                <div>
                                    <asp:LinkButton CommandArgument="Name" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-th"></span>Nome</asp:LinkButton>
                                </div>
                            </center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center>
                                <div>
                                    <asp:Label runat="server"><%#: Item.Name %></asp:Label>
                                </div>
                            </center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center>
                                <div>
                                    <asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span>Descrizione</asp:LinkButton>
                                </div>
                            </center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center>
                                <div>
                                    <asp:Label runat="server"><%#: Item.Description %></asp:Label>
                                </div>
                            </center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center>
                                <div>
                                    <asp:Label runat="server" ID="viewLabel"><span  class="glyphicon glyphicon-th"></span>Vedi</asp:Label>
                                </div>
                            </center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center>
                                <div>
                                    <asp:Button ID="btnViewDetails" CssClass="btn btn-info btn-xs" Text="Vedi dettagli" runat="server" OnClick="btnViewDetails_Click" />
                                </div>
                            </center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="100px" />
                                                        <ItemStyle Width="100px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
