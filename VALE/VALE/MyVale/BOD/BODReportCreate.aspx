<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BODReportCreate.aspx.cs" Inherits="VALE.MyVale.BOD.BODReportCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Create new board of directors report</h3>
    <asp:Label runat="server" CssClass="control-label">Name:</asp:Label>
    <asp:TextBox CssClass="form-control" ID="txtReportName" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtReportName" ErrorMessage="* name field required" ></asp:RequiredFieldValidator><br />

    <asp:Label runat="server" CssClass="control-label">Location:</asp:Label>
    <asp:TextBox CssClass="form-control" ID="txtLocation" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtLocation" ErrorMessage="* location field required" ></asp:RequiredFieldValidator><br />

    <asp:Label runat="server" CssClass="control-label">Meeting date:</asp:Label>
    <asp:TextBox CssClass="form-control" ID="txtMeetingDate" runat="server" OnTextChanged="txtMeetingDate_TextChanged" AutoPostBack="true"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarMeetingDate" TargetControlID="txtMeetingDate" runat="server" Format="dd/MM/yyyy"></asp:CalendarExtender>
    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtMeetingDate" ErrorMessage="* date field required" ></asp:RequiredFieldValidator><br />

    <asp:Label runat="server" CssClass="control-label">Publishing date:</asp:Label>
    <asp:TextBox CssClass="form-control" ID="txtPublishDate" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarPublishDate" TargetControlID="txtPublishDate" runat="server" Format="dd/MM/yyyy"></asp:CalendarExtender>
    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtPublishDate" ErrorMessage="* date field required" ></asp:RequiredFieldValidator><br />

    <asp:Label runat="server" CssClass="control-label">Write report:</asp:Label>
    <asp:TextBox CssClass="form-control" TextMode="MultiLine" Width="500px" Height="300px" ID="txtReportText" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtReportText" ErrorMessage="* report field required" ></asp:RequiredFieldValidator><br />
    <asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtReportText">
        <Toolbar>
            <ajaxToolkit:Undo />
            <ajaxToolkit:Redo />
            <ajaxToolkit:Bold />
            <ajaxToolkit:Italic />
            <ajaxToolkit:Underline />
            <ajaxToolkit:StrikeThrough />
            <ajaxToolkit:Subscript />
            <ajaxToolkit:Superscript />
            <ajaxToolkit:InsertOrderedList />
            <ajaxToolkit:InsertUnorderedList />
            <ajaxToolkit:CreateLink />
            <ajaxToolkit:Cut />
            <ajaxToolkit:Copy />
            <ajaxToolkit:Paste />
        </Toolbar>
    </asp:HtmlEditorExtender>
    <br />
    <asp:Label runat="server" CssClass="control-label">Upload file(s)</asp:Label>

    <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
    <asp:Label runat="server" ID="StatusLabel" Text="" />
    <asp:Button runat="server" CausesValidation="true" Text="Upload" ID="btnUploadFile" CssClass="btn btn-info" OnClick="btnUploadFile_Click" />

    <br />
    <br />
    <asp:Label runat="server" CssClass="control-label">Uploaded file</asp:Label>
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
    <br />
    <asp:Button runat="server" ID="btnSubmit" Text="Save report" CssClass="btn btn-success" OnClick="btnSubmit_Click" />
</asp:Content>
