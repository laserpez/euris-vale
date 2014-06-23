<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalEvents.aspx.cs" Inherits="VALE.MyVale.PersonalEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Eventi a cui partecipi</h3>
    <br />
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
</asp:Content>
