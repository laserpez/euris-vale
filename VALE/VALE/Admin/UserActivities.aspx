<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserActivities.aspx.cs" Inherits="VALE.Admin.UserActivities" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">

                            <asp:GridView ID="grdReports" OnDataBound="grdReports_DataBound" AllowPaging="true" PageSize="10" runat="server" SelectMethod="GetUserActivities" AutoGenerateColumns="false" GridLines="Both"
                                ItemType="VALE.Models.ActivityReport" EmptyDataText="Nessun progetto aperto" CssClass="table table-striped table-bordered" AllowSorting="true">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton runat="server" ID="labelDescription" CommandArgument="ActivityDescription" CommandName="sort"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.ActivityDescription %></asp:Label></div></center>
                                        </ItemTemplate>
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton runat="server" ID="labelHoursWorked" CommandArgument="HoursWorked" CommandName="sort"><span  class="glyphicon glyphicon-th"></span> Ore di attività</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.HoursWorked %></asp:Label></div></center>
                                        </ItemTemplate>
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Data">
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-th"></span> Data</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings Position="Bottom" />
                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
