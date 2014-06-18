<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectReport.aspx.cs" Inherits="VALE.Admin.ProjectReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Project report</h4>
    <asp:FormView OnDataBound="frmProjectReport_DataBound" SelectMethod="GetProject" runat="server" ItemType="VALE.Models.Project" ID="frmProjectReport">
        <ItemTemplate>
            <asp:Label runat="server"><%#: String.Format("Name: {0}", Item.ProjectName) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Description: {0}", Item.Description) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Status: {0}", Item.Status.ToUpper()) %></asp:Label><br />
            <h4>Users interventions</h4>
            <asp:GridView OnRowCommand="grid_RowCommand" runat="server" ID="grdUsersInterventions" CssClass="table table-striped table-bordered" EmptyDataText="No users interventions">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button CausesValidation="false" CssClass="btn btn-info btn-sm" runat="server" CommandName="ViewUserInterventions"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View details" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <h4>Activities report</h4>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:DropDownList CssClass="form-control" runat="server" ID="ddlSelectActivity" SelectMethod="GetActivities" DataTextField="ActivityName" DataValueField="ActivityId">
                    </asp:DropDownList>
                    <asp:Button runat="server" ID="btnShowActivityReport" OnClick="btnShowActivityReport_Click" CssClass="btn btn-info" Text="Show report" />
                    <asp:GridView OnRowCommand="grid_RowCommand" runat="server" EmptyDataText="No reports" ID="grdActivitiesReport" CssClass="table table-striped table-bordered">
                        <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button CausesValidation="false" CssClass="btn btn-info btn-sm" runat="server" CommandName="ViewActivityReport"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View details" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>


        </ItemTemplate>
    </asp:FormView>
</asp:Content>
