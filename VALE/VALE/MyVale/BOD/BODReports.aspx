<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BODReports.aspx.cs" Inherits="VALE.MyVale.BOD.BODReports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Board articles</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView OnRowCommand="grdBODReport_RowCommand" SelectMethod="GetBODReports" ID="grdBODReport" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                ItemType="VALE.Models.BODReport" EmptyDataText="No board reports" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="BODReportId" HeaderText="ID" SortExpression="BODReportId" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                    <asp:BoundField DataField="MeetingDate" DataFormatString="{0:d}"  HeaderText="Meeting date" SortExpression="MeetingDate" />
                    <asp:BoundField DataField="PublishingDate" DataFormatString="{0:d}" HeaderText="Publishing date" SortExpression="PublishingDate" />
                    
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button runat="server" Text="View report" CssClass="btn btn-info btn-sm"
                                CommandName="ViewReport" CommandArgument="<%# Item.BODReportId %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
