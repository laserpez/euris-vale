﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewBODReport.aspx.cs" Inherits="VALE.MyVale.BOD.ViewBODReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <h3>Dettaglio del verbale</h3>
    <asp:FormView runat="server" ID="BODReportDetail" ItemType="VALE.Models.BODReport" SelectMethod="GetBODReport">
        <ItemTemplate>
            <h4>Sommario</h4>
            <asp:Label runat="server">Nome: </asp:Label>
            <asp:Label runat="server"><%#: Item.Name %></asp:Label><br />
            <asp:Label runat="server">Luogo: </asp:Label>
            <asp:Label runat="server"><%#: Item.Location %></asp:Label><br />
            <asp:Label runat="server">Data riunione: </asp:Label>
            <asp:Label runat="server"><%#: Item.MeetingDate.ToShortDateString() %></asp:Label><br />
            <asp:Label runat="server">Data di pubblicazione: </asp:Label>
            <asp:Label runat="server"><%#: Item.PublishingDate.ToShortDateString() %></asp:Label><br />
            <asp:Label runat="server">Testo: </asp:Label>
            <asp:Label runat="server"><%#: Item.Text %></asp:Label><br />
            <h4>Documenti correlati</h4>
            <asp:ListBox runat="server" ID="lstDocuments" CssClass="form-control" SelectMethod="GetRelatedDocuments"></asp:ListBox>
            <asp:Button runat="server" ID="btnViewDocuments" OnClick="btnViewDocuments_Click" CssClass="btn btn-info" Text="View document" />
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
