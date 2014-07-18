<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalActivities.aspx.cs" Inherits="VALE.MyVale.PersonalActivities" %>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Report attività"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <br />
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:Label runat="server" ID="SelectLabel"></asp:Label><br />
                                    <asp:DropDownList Width="200px" CssClass="form-control" runat="server" ID="ddlSelectActivity"></asp:DropDownList>
                                    <br />
                                    <asp:Button runat="server" Text="Vedi report" CssClass="btn btn-info btn-xs" ID="bnViewReports" OnClick="bnViewReports_Click" />
                                    <br />
                                    <br />
                                    <asp:GridView runat="server" ID="grdActivityReport" AllowPaging="true" PageSize="5" OnPageIndexChanging="grdActivityReport_PageIndexChanging" DataKeyNames="ActivityId" ItemType="VALE.Models.ActivityReport" AutoGenerateColumns="false"
                                        CssClass="table table-striped table-bordered" AllowSorting="true" OnSorting="grdActivityReport_Sorting" EmptyDataText="Nessun report per questa attività">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="ActivityDescription" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label ID="lblContent" runat="server"><%#: Item.ActivityDescription %></asp:Label></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="120px" />
                                                <ItemStyle Width="120px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton runat="server" ID="labelHoursWorked" CommandArgument="HoursWorked" CommandName="sort"><span  class="glyphicon glyphicon-time"></span> Ore di attività</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.HoursWorked %></asp:Label></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="120px" />
                                                <ItemStyle Width="120px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Data">
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="120px" />
                                                <ItemStyle Width="120px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerTemplate>
                                            <asp:GridPager runat="server"
                                                ShowFirstAndLast="true" ShowNextAndPrevious="true" PageLinksToShow="10"
                                                NextText=">" PreviousText="<" FirstText="Prima" LastText="Ultima" />
                                        </PagerTemplate>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
