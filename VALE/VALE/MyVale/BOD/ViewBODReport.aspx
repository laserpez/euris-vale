<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewBODReport.aspx.cs" Inherits="VALE.MyVale.BOD.ViewBODReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <h3>Intervention</h3>
    <asp:FormView runat="server" ID="BODReportDetail" ItemType="VALE.Models.BODReport" SelectMethod="GetBODReport">
        <ItemTemplate>
            <h4>Summary</h4>
            <asp:Label runat="server">Name: </asp:Label>
            <asp:Label runat="server"><%#: Item.Name %></asp:Label><br />
            <asp:Label runat="server">Location: </asp:Label>
            <asp:Label runat="server"><%#: Item.Location %></asp:Label><br />
            <asp:Label runat="server">Meeting date: </asp:Label>
            <asp:Label runat="server"><%#: Item.MeetingDate.ToShortDateString() %></asp:Label><br />
            <asp:Label runat="server">Publishing date: </asp:Label>
            <asp:Label runat="server"><%#: Item.PublishingDate.ToShortDateString() %></asp:Label><br />
            <asp:Label runat="server">Text: </asp:Label>
            <asp:Label runat="server"><%#: Item.Text %></asp:Label><br />
            <h4>Related documents</h4>
            <asp:ListBox runat="server" ID="lstDocuments" CssClass="form-control" SelectMethod="GetRelatedDocuments"></asp:ListBox>
            <asp:Button runat="server" ID="btnViewDocuments" OnClick="btnViewDocuments_Click" CssClass="btn btn-info" Text="View document" />
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
