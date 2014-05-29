<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InterventionDetails.aspx.cs" Inherits="VALE.MyVale.InterventionDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Intervention</h3>
    <asp:FormView runat="server" ID="InterventionDetail" ItemType="VALE.Models.Intervention" SelectMethod="GetIntervention">
        <ItemTemplate>
            <h4>Created by</h4>
            <asp:Label runat="server"><%#: Item.Creator.FullName %></asp:Label>
            <h4>Text</h4>
            <asp:Label runat="server"><%#: String.IsNullOrEmpty(Item.InterventionText) ? "No text inserted" : Item.InterventionText %></asp:Label>
            <h4>Related documents</h4>
            <asp:ListBox runat="server" ID="lstDocuments" CssClass="form-control" SelectMethod="GetRelatedDocuments"></asp:ListBox>
        </ItemTemplate>
    </asp:FormView>
    <h3>Comments</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Panel runat="server">
                <asp:Label runat="server" Font-Bold="true" Text="Add comment:"></asp:Label>
                <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtComment"></asp:TextBox>
                <asp:Button runat="server" CssClass="btn btn-info" ID="btnAddComment" Text="Add" OnClick="btnAddComment_Click" />
            </asp:Panel>
            <div class="panel panel-default">
                <div class="panel-heading">Comments</div>
                <div class="panel-body">
                    <asp:ListView runat="server" ID="lstComments" ItemType="VALE.Models.Comment" SelectMethod="GetComments">
                        <EmptyDataTemplate>
                            <asp:Label runat="server" Text="No comments yet"></asp:Label>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.Creator.FullName %></asp:Label>
                            <asp:Label runat="server"><%#: String.Format(" - {0}", Item.Date) %></asp:Label><br />
                            <asp:Label runat="server"><%#: Item.CommentText %></asp:Label><br />
                        </ItemTemplate>
                        <ItemSeparatorTemplate>
                            <br />
                        </ItemSeparatorTemplate>
                    </asp:ListView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
