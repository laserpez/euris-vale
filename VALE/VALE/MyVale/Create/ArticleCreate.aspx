<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArticleCreate.aspx.cs" Inherits="VALE.MyVale.Create.ArticleCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Create new blog article</h3>
    <asp:Label runat="server" CssClass="control-label">Title:</asp:Label>
    <asp:TextBox CssClass="form-control" ID="txtArticleTitle" runat="server"></asp:TextBox><br />
    <asp:Label runat="server" CssClass="control-label">Release date:</asp:Label>
    <asp:TextBox CssClass="form-control" ID="txtReleaseDate" runat="server"></asp:TextBox><br />
    <asp:CalendarExtender TargetControlID="txtReleaseDate" runat="server" Format="dd/MM/yyyy"></asp:CalendarExtender>
    <asp:Label runat="server" CssClass="control-label">Content:</asp:Label><br />
    <asp:TextBox CssClass="form-control" TextMode="MultiLine" Width="500px" Height="300px" ID="txtArticleContent" runat="server"></asp:TextBox>
    <asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtArticleContent">
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
    <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-info" OnClick="btnSubmit_Click" />
</asp:Content>
