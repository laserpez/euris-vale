<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Activities" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Activities.aspx.cs" Inherits="VALE.MyVale.Activities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>To do</h3>
    <asp:Button runat="server" Text="Export CSV" CssClass="btn btn-info" ID="btnExportCSV" OnClick="btnExportCSV_Click" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            
            <asp:GridView OnRowCommand="grdCurrentActivities_RowCommand" ID="grdCurrentActivities" runat="server" AutoGenerateColumns="false" ShowFooter="true" GridLines="Both"
                ItemType="VALE.Models.Activity" AllowSorting="true" SelectMethod="GetCurrentActivities" EmptyDataText="No current activities" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="ActivityId" HeaderText="ID" SortExpression="ActivityId" />
                    <asp:BoundField DataField="ActivityName" HeaderText="Name" SortExpression="ActivityName" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Creation Date" SortExpression="CreationDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Expire Date" SortExpression="ExpireDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "No expire date" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-info" runat="server" CommandName="ViewDetails"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View activity" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <p></p>
    <h3>Pending activities</h3>
    <asp:GridView OnRowCommand="grdPendingActivities_RowCommand" ID="grdPendingActivities" runat="server" AutoGenerateColumns="false" ShowFooter="true" GridLines="Both"
        ItemType="VALE.Models.Activity" SelectMethod="GetPendingActivities" EmptyDataText="No pending activities" CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
            <asp:BoundField DataField="ActivityName" HeaderText="Name" />
            <asp:BoundField DataField="Description" HeaderText="Description" />
            <asp:TemplateField HeaderText="Creation Date">
                <ItemTemplate>
                    <asp:Label runat="server"><%#: Item.CreationDate %></asp:Label>
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

    <%--<h3>Previous activities</h3>
    <div class="row">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Start date:"></asp:Label>
            <asp:TextBox runat="server" Text="" ID="txtStartDate"></asp:TextBox>
            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
        </div>
        <div class="col-md-3">
           <asp:Label runat="server" Text="Start date:"></asp:Label>
           <asp:TextBox runat="server" Text="" ID="txtEndDate"></asp:TextBox>
            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtEndDate"></asp:CalendarExtender>
        </div>
        <div class="col-md-3">
            <asp:Button CssClass="btn btn-primary" ID="btnSearch" runat="server" Text="Search" />
        </div>
        <div class="col-md-3">
            <asp:Button CssClass="btn btn-primary" ID="btnExport" runat="server" Text="Export CSV" />
        </div>
    </div>
    <p></p>
    <asp:ListView runat="server">

    </asp:ListView>--%>
</asp:Content>
