<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BODReports.aspx.cs" Inherits="VALE.MyVale.BOD.BODReports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Articoli del consiglio</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView OnRowCommand="grdBODReport_RowCommand" SelectMethod="GetBODReports" ID="grdBODReport" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                ItemType="VALE.Models.BODReport" EmptyDataText="Nessun verbale del consiglio direttivo." CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="BODReportId" HeaderText="ID" SortExpression="BODReportId" />
                    <asp:BoundField DataField="Name" HeaderText="Nome" SortExpression="Name" />
                    <asp:BoundField DataField="Location" HeaderText="Luogo" SortExpression="Location" />
                    <asp:BoundField DataField="MeetingDate" DataFormatString="{0:d}"  HeaderText="Data riunione" SortExpression="MeetingDate" />
                    <asp:BoundField DataField="PublishingDate" DataFormatString="{0:d}" HeaderText="Data pubblicazione" SortExpression="PublishingDate" />
                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Vedi verbali" CssClass="btn btn-info btn-sm"
                                CommandName="ViewReport" CommandArgument="<%# Item.BODReportId %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
