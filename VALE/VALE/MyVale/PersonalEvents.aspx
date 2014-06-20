<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalEvents.aspx.cs" Inherits="VALE.MyVale.PersonalEvents" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Eventi a cui partecipi</h3>
            <asp:GridView runat="server" ItemType="VALE.Models.Event" AutoGenerateColumns="false" AllowSorting="true" EmptyDataText="Nessun evento pianificato" 
                CssClass="table table-striped table-bordered" ID="grdPlannedEvent" SelectMethod="GetAttendingEvents" >
            <Columns>
                <asp:BoundField HeaderText="Id" SortExpression="EventId" DataField="EventId" />
                <asp:TemplateField HeaderText="Data" SortExpression="EventDate">
                    <ItemTemplate>
                        <asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Nome" SortExpression="Name" DataField="Name" />
                <asp:BoundField HeaderText="Descrizione" SortExpression="Description" DataField="Description" />
                <asp:TemplateField HeaderText="Vedi">
                    <ItemTemplate>
                        <asp:Button ID="btnViewDetails" CssClass="btn btn-info" Text="Vedi dettagli" runat="server" OnClick="btnViewDetails_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            </asp:GridView>
</asp:Content>
