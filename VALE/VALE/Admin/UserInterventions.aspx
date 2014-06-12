<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserInterventions.aspx.cs" Inherits="VALE.Admin.UserInterventions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <asp:Label ID="lblSummary" Font-Size="Large" Font-Bold="true" ForeColor="#317eac" runat="server"></asp:Label>
    <br />
    <asp:ListView OnDataBound="lstInterventions_DataBound" runat="server" ID="lstInterventions" SelectMethod="GetInterventions" ItemType="VALE.Models.Intervention">
        <ItemSeparatorTemplate>
            <br />
        </ItemSeparatorTemplate>
        <ItemTemplate>
            <asp:HiddenField runat="server" ID="ItemId" Value="<%#: Item.InterventionId %>" />
            <asp:Label runat="server" Text="Text: "></asp:Label>
            <asp:Label runat="server"><%#: Item.InterventionText %></asp:Label><br />
            <asp:Label runat="server" Text="Date: "></asp:Label>
            <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label><br />
            <asp:ListBox CssClass="form-control" runat="server" SelectMethod="GetDocuments" ID="lstInterventionDocuments">

            </asp:ListBox>
        </ItemTemplate>
    </asp:ListView>
</asp:Content>
