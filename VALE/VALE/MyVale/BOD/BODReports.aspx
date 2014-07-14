<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BODReports.aspx.cs" Inherits="VALE.MyVale.BOD.BODReports" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Articoli del consiglio"></asp:Label>
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
                                    <asp:GridView OnRowCommand="grdBODReport_RowCommand" SelectMethod="GetBODReports" ID="grdBODReport" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                        ItemType="VALE.Models.BODReport" EmptyDataText="Nessun verbale del consiglio direttivo." CssClass="table table-striped table-bordered">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="Name" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Name %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="Location" CommandName="sort" runat="server" ID="labelLocation"><span  class="glyphicon glyphicon-align-justify"></span> Luogo</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Location %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="MeetingDate" CommandName="sort" runat="server" ID="labelMeetingDate"><span  class="glyphicon glyphicon-calendar"></span> Data riunione</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.MeetingDate.ToShortDateString() %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="PublishingDate" CommandName="sort" runat="server" ID="labelPublishingDate"><span  class="glyphicon glyphicon-calendar"></span> Data pubblicazione</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.PublishingDate.ToShortDateString() %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                         <HeaderTemplate>
                                                            <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                        </HeaderTemplate>
                                                <ItemTemplate>
                                                            <center><div><asp:Button runat="server" Width="90px" Text="Visualizza" CssClass="btn btn-info btn-xs"
                                                                CommandName="ViewReport" CommandArgument="<%# Item.BODReportId %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
                                            </asp:TemplateField>
                                        </Columns>
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
