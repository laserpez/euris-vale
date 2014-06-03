<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityCreate.aspx.cs" Inherits="VALE.MyVale.ActivityCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Create new personal activity</h3>
    <div class="form-group">
        <asp:Label runat="server" CssClass="col-md-2 control-label">Activity name *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="The name field is required." />
        </div>
        <asp:Label runat="server" CssClass="col-md-2 control-label">Description *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtDescription" CssClass="form-control" Height="145px" Width="404px" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="The description field is required." />
        </div>
        <asp:Label runat="server" CssClass="col-md-2 control-label">Start date *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" OnTextChanged="txtStartDate_TextChanged" AutoPostBack="true" />
            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="The start date field is required." />
        </div>
        <asp:Label runat="server" CssClass="col-md-2 control-label">End date (optional)</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" />
            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtEndDate"></asp:CalendarExtender>
        </div>
        <asp:Label runat="server" CssClass="col-md-2 control-label">Related project (optional)</asp:Label>
        <div class="col-md-10">
            <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
                <ContentTemplate>
                    <asp:TextBox runat="server" ID="txtProjectName" CssClass="form-control" />
                    <asp:AutoCompleteExtender
                        ServiceMethod="GetProjectNames" ServicePath="/AutoComplete.asmx"
                        ID="txtManufacturer_AutoCompleteExtender" runat="server"
                        Enabled="True" TargetControlID="txtProjectName" UseContextKey="True"
                        MinimumPrefixLength="2">
                    </asp:AutoCompleteExtender>
                    <asp:Button runat="server" Text="Add project" ID="btnSearchProject" CssClass="btn btn-default" CausesValidation="false" OnClick="btnSearchProject_Click" />
                    <asp:Label runat="server" ID="lblResultSearchProject" CssClass="control-label"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <asp:UpdateProgress AssociatedUpdatePanelID="SearchProjectPanel" ID="MyUpdateProgress" runat="server">
            <ProgressTemplate>
                Checking project name...
            </ProgressTemplate>
        </asp:UpdateProgress>
        <p></p>
    </div>
    <p></p>
    <asp:Button runat="server" CssClass="btn btn-primary" Text="Save" ID="btnSaveActivity" CausesValidation="true" OnClick="btnSaveActivity_Click" />
    <br />
</asp:Content>
