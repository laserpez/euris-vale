<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="VALE.MyVale.Events" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Planned events</h3>
    
    <asp:UpdatePanel runat="server">
        <%--<Triggers>
            <asp:PostBackTrigger ControlID="txtFromDate" />   
        </Triggers>--%>
        <ContentTemplate>
            <div class="row">
                <div class="col-md-2">
                    <asp:Label runat="server" Text="From" CssClass="control-label"></asp:Label>
                    <asp:TextBox runat="server" ID="txtFromDate" CssClass="form-control" OnTextChanged="txtFromDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ErrorMessage="* required" runat="server" ControlToValidate="txtFromDate"></asp:RequiredFieldValidator>
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtFromDate" ></asp:CalendarExtender>
                </div>
                <div class="col-md-2">
                    <asp:Label runat="server" Text="To" CssClass="control-label"></asp:Label>
                    <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ErrorMessage="* required" runat="server" ControlToValidate="txtToDate"></asp:RequiredFieldValidator>
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtToDate"></asp:CalendarExtender>
                </div>
            </div>
            <div class="row">
                    <asp:Button CausesValidation="true" runat="server" ID="btnShowEvents" CssClass="btn btn-primary" Text="Show events" OnClick="btnShowEvents_Click" />
            </div>
            <p></p>
            <asp:GridView runat="server" ItemType="VALE.Models.Event" AutoGenerateColumns="false" EmptyDataText="No planned events" 
                CssClass="table table-striped table-bordered" ShowFooter="true" ID="grdPlannedEvent" >
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
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnAttendEvent" runat="server" OnClick="btnAttendEvent_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
