<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserActivities.aspx.cs" Inherits="VALE.Admin.UserActivities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Label ID="lblSummary" Font-Size="Large" Font-Bold="true" ForeColor="#317eac" runat="server"></asp:Label>
    <p></p>
    <asp:GridView ID="grdReports" OnDataBound="grdReports_DataBound" runat="server" SelectMethod="GetUserActivities" AutoGenerateColumns="false" GridLines="Both"
        ItemType="VALE.Models.ActivityReport" EmptyDataText="No open projects" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField HeaderText="Description" DataField="ActivityDescription" />
            <asp:BoundField HeaderText="Hours worked" DataField="HoursWorked" />
            <asp:BoundField HeaderText="Date" DataFormatString="{0:d}" DataField="Date" />
        </Columns>
    </asp:GridView>
</asp:Content>
