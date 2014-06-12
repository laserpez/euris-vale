<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectCreate.aspx.cs" Inherits="VALE.MyVale.ProjectCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Create new project</h3>
    <div class="form-group">
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Project name *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="The name field is required." />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Description *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtDescription" CssClass="form-control" Height="145px" Width="404px" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="The description field is required." />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Start date *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" />
            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="The start date field is required." />
        </div>

        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Upload file</asp:Label>
        <div class="col-md-10">
            <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
            <asp:Label runat="server" ID="StatusLabel" Text="" />
            <asp:Button runat="server" CausesValidation="false" Text="Upload" ID="btnUploadFile" CssClass="btn btn-info" OnClick="btnUploadFile_Click" />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Uploaded file</asp:Label>
        <div class="col-md-10">
            <asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="No files uploaded" 
                ID="grdFilesUploaded" runat="server">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button CausesValidation="false" CssClass="btn btn-danger btn-sm" runat="server" CommandName="DeleteFile" 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Delete file" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <p></p>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Related project (optional)</asp:Label>
        <div class="col-md-10">
            <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
                <ContentTemplate>
                    <asp:TextBox runat="server" ID="txtProjectName" CssClass="form-control" />
                    <asp:AutoCompleteExtender
                        ServiceMethod="GetProjectNames" ServicePath="/AutoComplete.asmx"
                        ID="txtProjectAutoCompleter" runat="server"
                        Enabled="True" TargetControlID="txtProjectName" UseContextKey="True"
                        MinimumPrefixLength="2">
                    </asp:AutoCompleteExtender>
                    <asp:Button runat="server" Text="Save" ID="btnSearchProject" CssClass="btn btn-default" CausesValidation="false" OnClick="btnSearchProject_Click" />
                    <asp:Label runat="server" ID="lblResultSearchProject" CssClass="control-label"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <uc:SelectProject runat="server" ID="SelectProject"/>

        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Add users</asp:Label>

        <asp:UpdatePanel runat="server" ID="SearchUserPanel">
            <ContentTemplate>
                <div class="col-md-2">
                    <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control" />
                    <asp:AutoCompleteExtender
                        ServiceMethod="GetUserNames" ServicePath="/AutoComplete.asmx"
                        ID="txtNameAutoCompleter" runat="server"
                        Enabled="True" TargetControlID="txtUserName" UseContextKey="True"
                        MinimumPrefixLength="2">
                    </asp:AutoCompleteExtender>
                </div>
                <div class="col-md-8">
                    <asp:Button runat="server" Text="Add" ID="btnSearchUser" CssClass="btn btn-default" CausesValidation="false" OnClick="btnSearchUser_Click" />
                    <asp:Label runat="server" ID="lblResultSearchUser" CssClass="control-label"></asp:Label>
                </div>

                <br />
                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label" Text="Related users"></asp:Label><br />
                <asp:GridView ItemType="VALE.Models.UserData" DeleteMethod="DeleteUser" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                    SelectMethod="GetRelatedUsers" AutoGenerateDeleteButton="true" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                    </Columns>
                    <EmptyDataTemplate>
                        <asp:Label runat="server">No related users</asp:Label>
                    </EmptyDataTemplate>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress AssociatedUpdatePanelID="SearchUserPanel" ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                Checking user name...
            </ProgressTemplate>
        </asp:UpdateProgress>

        <p></p>
        <asp:Button runat="server" CssClass="btn btn-primary" Text="Save" ID="btnSaveActivity" CausesValidation="true" OnClick="btnSaveProject_Click" />
        <br />
    </div>
</asp:Content>
