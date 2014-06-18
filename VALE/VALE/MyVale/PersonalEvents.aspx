<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalEvents.aspx.cs" Inherits="VALE.MyVale.PersonalEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Attending events</h3>
            <asp:GridView runat="server" ItemType="VALE.Models.Event" AutoGenerateColumns="false" AllowSorting="true" EmptyDataText="No planned events" 
                CssClass="table table-striped table-bordered" ID="grdPlannedEvent" SelectMethod="GetAttendingEvents" >
            <Columns>
                <asp:BoundField HeaderText="Id" SortExpression="EventId" DataField="EventId" />
                <asp:TemplateField HeaderText="Date" SortExpression="EventDate">
                    <ItemTemplate>
                        <asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Name" SortExpression="Name" DataField="Name" />
                <asp:BoundField HeaderText="Description" SortExpression="Description" DataField="Description" />
                <asp:TemplateField HeaderText="View">
                    <ItemTemplate>
                        <asp:Button ID="btnViewDetails" CssClass="btn btn-info" Text="View Details" runat="server" OnClick="btnViewDetails_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            </asp:GridView>
</asp:Content>
