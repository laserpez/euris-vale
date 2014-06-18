<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalActivities.aspx.cs" Inherits="VALE.MyVale.PersonalActivities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Activity report</h4>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Label runat="server" Text="Select activity to see personal report"></asp:Label><br />
            <asp:DropDownList Width="200px" CssClass="form-control" runat="server" ID="ddlSelectActivity" SelectMethod="GetPersonalActivities" 
                ItemType="VALE.Models.Activity" DataTextField="ActivityName" DataValueField="ActivityId"></asp:DropDownList>
            <asp:Button runat="server" Text="View report" CssClass="btn btn-info" ID="bnViewReports" OnClick="bnViewReports_Click" />

            <asp:GridView runat="server" ID="grdActivityReport" ItemType="VALE.Models.ActivityReport" AutoGenerateColumns="false"
                CssClass="table table-striped table-bordered" EmptyDataText="No report for this activity">
                <Columns>
                    <asp:BoundField HeaderText="Description" DataField="ActivityDescription" SortExpression="ActivityDescription" />
                    <asp:BoundField HeaderText="Hours worked" DataField="HoursWorked" SortExpression="HoursWorked" />
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
