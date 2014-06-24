<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewArticle.aspx.cs" Inherits="VALE.MyVale.ViewArticle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView ID="frmArticle" OnDataBound="Unnamed_DataBound" ItemType="VALE.Models.BlogArticle" SelectMethod="GetArticle" runat="server">
        <ItemTemplate>
            <h3><%#: Item.Title %></h3>
            <asp:Label runat="server"><%#: String.Format("Autore: {0}", Item.Creator.FullName) %></asp:Label><br />
            <asp:Label runat="server"><%#: Item.ReleaseDate.ToShortDateString() %></asp:Label>
            <p>
                <asp:Label ID="lblContent" runat="server"></asp:Label>
            </p>
        </ItemTemplate>
    </asp:FormView>
    <h3>Commenti</h3>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:Panel runat="server">
                <asp:Label runat="server" Font-Bold="true" Text="Aggiungi commento:"></asp:Label>
                <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine" ID="txtComment"></asp:TextBox>
                <asp:Button runat="server" CssClass="btn btn-info" ID="btnAddComment" Text="Aggiungi" OnClick="btnAddComment_Click" />
            </asp:Panel>
            <br />
            <div class="panel panel-default">
                <div class="panel-heading">Commenti</div>
                <div class="panel-body">
                    <asp:ListView runat="server" ID="lstComments" ItemType="VALE.Models.BlogComment" SelectMethod="GetComments">
                        <EmptyDataTemplate>
                            <asp:Label runat="server" Text="Nessun commento"></asp:Label>
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
