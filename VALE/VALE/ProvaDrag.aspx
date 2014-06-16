<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProvaDrag.aspx.cs" Inherits="VALE.ProvaDrag" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title>Untitled Page</title>
<script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js" type="text/javascript"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
<script type="text/javascript">
    $(function () {
        $(".drag_drop_grid").sortable({
            items: 'tr:not(tr:first-child)',
            cursor: 'crosshair',
            connectWith: '.drag_drop_grid',
            dropOnEmpty: true,
            receive: function (e, ui) {
                $(this).find("tbody").append(ui.item);
            }
        });
    });
</script>
</head>
<body>
    <asp:GridView ID="gv1" runat="server" CssClass="drag_drop_grid" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="Item" HeaderText="Item"/>
            <asp:BoundField DataField="Price" HeaderText="Price"/>
        </Columns>
    </asp:GridView>
    <hr />
    <asp:GridView ID="gv2" runat="server" CssClass="drag_drop_grid" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="Item" HeaderText="Item"  />
            <asp:BoundField DataField="Price" HeaderText="Price"/>
        </Columns>
    </asp:GridView>
</body>
</html>
</asp:Content>
