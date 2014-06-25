<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserInterventions.aspx.cs" Inherits="VALE.Admin.UserInterventions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-12">
                                                <ul class="nav nav-pills col-lg-6">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Interventi dell'utente {0} sul progetto {1}" ></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">
                                    <br />
                                    <asp:Label ID="lblSummary" Font-Size="Large" Font-Bold="true" ForeColor="#317eac" runat="server"></asp:Label>
                                    <br />
                                    <asp:ListView OnDataBound="lstInterventions_DataBound" runat="server" ID="lstInterventions" SelectMethod="GetInterventions" ItemType="VALE.Models.Intervention">
                                        <ItemSeparatorTemplate>
                                            <br />
                                        </ItemSeparatorTemplate>
                                        <ItemTemplate>
                                            <asp:HiddenField runat="server" ID="ItemId" Value="<%#: Item.InterventionId %>" />
                                            <asp:Label runat="server" Text="Testo: "></asp:Label>
                                            <asp:Label runat="server"><%#: Item.InterventionText %></asp:Label><br />
                                            <asp:Label runat="server" Text="Data: "></asp:Label>
                                            <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label><br />
                                            <asp:ListBox CssClass="form-control" runat="server" SelectMethod="GetDocuments" ID="lstInterventionDocuments"></asp:ListBox>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
