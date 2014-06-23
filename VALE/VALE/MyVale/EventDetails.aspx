<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="VALE.MyVale.EventDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView runat="server" ID="EventDetail" ItemType="VALE.Models.Event" SelectMethod="GetEvent">
        <ItemTemplate>
            <h3><%#: Item.Name %></h3>
            <asp:Button ID="btnAttend" Text="Partecipa" runat="server" OnClick="btnAttend_Click" /><br />
            <h4>Dettagli evento</h4>
            <asp:Label runat="server"><%#: String.Format("Data: {0}", Item.EventDate.ToShortDateString()) %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: String.Format("Organizzatore: {0}", Item.Organizer.FullName) %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: Item.Public ? "Pubblico" : "Privato" %></asp:Label>
            <br />
            <asp:Label runat="server"><%#: String.Format("Descrizione: {0}", Item.Description) %></asp:Label><br />
            <h4>Partecipanti</h4>
            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                SelectMethod="GetRegisteredUsers" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label runat="server">Nessun utente registrato.</asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>
            <h4>Progetto correlato</h4>
            <asp:FormView runat="server" ID="ProjectDetail" EmptyDataText="Nessun progetto correlato." ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                <ItemTemplate>
                    <a href="ProjectDetails.aspx?projectId=<%#:Item.ProjectId %>"><%#: Item.ProjectName %></a>
                    <br />
                </ItemTemplate>
            </asp:FormView>
            <br />
            <asp:Label runat="server" ID="AttachmentsLabel" Text="Documenti" CssClass="h4"></asp:Label>
            <asp:ListBox runat="server" CssClass="form-control" Width="400px" ID="lstDocuments" SelectMethod="GetRelatedDocuments"></asp:ListBox>
            <asp:Button runat="server" Text="Scarica documento" CssClass="btn btn-info" ID="btnViewDocument" OnClick="btnViewDocument_Click" />
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
