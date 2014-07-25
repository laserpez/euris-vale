<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="VALE.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:TextBox ID="TextBox1" runat="server">
    </asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="TextBox1" runat="server" ErrorMessage="RequiredFieldValidator" ></asp:RequiredFieldValidator>
    <asp:Button  ID="Button1" runat="server" CssClass="btn btn-primary" Font-Bold="true" Font-Size="Large"   OnClick="Button1_Click"/>
    <button type="button" runat="server" class="btn btn-success"  onserverclick="Button1_Click" causesvalidation="false"><span class="glyphicon glyphicon-plus"></span></button>
</asp:Content>
