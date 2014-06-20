<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalActivities.aspx.cs" Inherits="VALE.MyVale.PersonalActivities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Report attività</h4>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Label runat="server" Text="Seleziona l'attività per vedere il report personale"></asp:Label><br />
            <asp:DropDownList Width="200px" CssClass="form-control" runat="server" ID="ddlSelectActivity" SelectMethod="GetPersonalActivities" 
                ItemType="VALE.Models.Activity" DataTextField="ActivityName" DataValueField="ActivityId"></asp:DropDownList>
            <asp:Button runat="server" Text="Vedi report" CssClass="btn btn-info" ID="bnViewReports" OnClick="bnViewReports_Click" />

            <asp:GridView runat="server" ID="grdActivityReport" ItemType="VALE.Models.ActivityReport" AutoGenerateColumns="false"
                CssClass="table table-striped table-bordered" EmptyDataText="Nessun report per questa attività">
                <Columns>
                    <asp:BoundField HeaderText="Description" DataField="ActivityDescription" SortExpression="ActivityDescription" />
                    <asp:BoundField HeaderText="Ore di lavoro" DataField="HoursWorked" SortExpression="HoursWorked" />
                    <asp:TemplateField HeaderText="Data">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
