<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Activities" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Activities.aspx.cs" Inherits="VALE.MyVale.Activities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>To do</h3>
    <asp:Button runat="server" Text="Export CSV" CssClass="btn btn-info" ID="btnExportCSV" OnClick="btnExportCSV_Click" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="panel panel-default">
                    <div class="panel-heading">
                        <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Show filters" ID="btnShowFilters"  OnClick="btnShowFilters_Click" />
                     </div>
                    <div runat="server" id="filterPanel" class="panel-body">
                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                        <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Descrizione"></asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtDescription"></asp:TextBox>
                        
                        <%--<asp:Label CssClass="col-md-2 control-label" runat="server" Text="Creato il"></asp:Label>
                        <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtCreationDate"></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtCreationDate"></asp:CalendarExtender>
                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Ultima modifica"></asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtLastModifiedDate"></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtLastModifiedDate"></asp:CalendarExtender>--%>

                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Stato"></asp:Label>
                        <asp:DropDownList SelectMethod="PopulateDropDown" Width="200" CssClass="col-md-10 form-control" ID="ddlStatus" runat="server"></asp:DropDownList>
                        <br /><br /><br />
                        <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info" />
                        <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                    </div>
                </div>
            <asp:GridView OnRowCommand="grdCurrentActivities_RowCommand" ID="grdCurrentActivities" runat="server" AutoGenerateColumns="false" GridLines="Both"
                ItemType="VALE.Models.Activity" AllowSorting="true" SelectMethod="GetCurrentActivities" EmptyDataText="No current activities" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="ActivityId" HeaderText="ID" SortExpression="ActivityId" />
                    <asp:BoundField DataField="ActivityName" HeaderText="Nome" SortExpression="ActivityName" />
                    <asp:BoundField DataField="Description" HeaderText="Descrizione" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Data inizio" SortExpression="StartDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Data fine" SortExpression="ExpireDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Stato" SortExpression="Status" />
                    <asp:TemplateField HeaderText="Dettagli">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-info" runat="server" CommandName="ViewDetails"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Vedi" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <p></p>
    <h3>Attività in attesa</h3>
    <asp:GridView OnRowCommand="grdPendingActivities_RowCommand" ID="grdPendingActivities" runat="server" AutoGenerateColumns="false" ShowFooter="true" GridLines="Both"
        ItemType="VALE.Models.Activity" SelectMethod="GetPendingActivities" EmptyDataText="No pending activities" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
            <asp:BoundField DataField="ActivityName" HeaderText="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:TemplateField HeaderText="Creation Date">
                <ItemTemplate>
                    <asp:Label runat="server"><%#: Item.StartDate %></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Expire Date">
                <ItemTemplate>
                    <asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "No expire date" %></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Accept">
                <ItemTemplate>
                    <asp:Button CssClass="btn btn-success" runat="server" CommandName="AcceptActivity"
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Accept" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Refuse">
                <ItemTemplate>
                    <asp:Button CssClass="btn btn-danger" runat="server" CommandName="RefuseActivity"
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Refuse" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>
