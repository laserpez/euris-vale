<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalActivities.aspx.cs" Inherits="VALE.MyVale.PersonalActivities" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Repilogo interventi"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Progetto</asp:Label>
                                                    <asp:DropDownList AutoPostBack="true" Width="300px" CssClass="form-control col-md-4" runat="server" OnSelectedIndexChanged="ddlSelectProject_SelectedIndexChanged" ID="ddlSelectProject" SelectMethod="GetProjects" ItemType="VALE.Models.Project" DataTextField="ProjectName" DataValueField="ProjectId"></asp:DropDownList>
                                                    <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Attività</asp:Label>
                                                    <asp:DropDownList Width="300px" CssClass="form-control col-md-4" runat="server" ID="ddlSelectActivity" ItemType="VALE.Models.Activity" DataTextField="ActivityName" DataValueField="ActivityId"></asp:DropDownList>
                                                    <asp:Button runat="server" Text="Visualizza Interventi" CssClass="btn btn-info col-md-2 col-md-offset-1" ID="bnViewReports" OnClick="bnViewReports_Click" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                     <div class="row">
                                        <div class="col-md-12">
                                            <br />
                                        </div>
                                     </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            Interventi
                                                        </div>
                                                        <div class="panel-body">
                                                            <asp:GridView runat="server" ID="grdActivityReport" DataKeyNames="ActivityId" ItemType="VALE.Models.ActivityReport" AutoGenerateColumns="false" SelectMethod="grdActivityReport_GetData"
                                                                CssClass="table table-striped table-bordered" AllowSorting="true" AllowPaging="true" PageSize="10" EmptyDataText="Nessun intervento">
                                                                <Columns>
                                                                    <%--<asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="WorkedActivity.ActivityName" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label  runat="server"><%#: Item.WorkedActivity.ActivityName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="120px" />
                                                                        <ItemStyle Width="120px" />
                                                                    </asp:TemplateField>--%>
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
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Data">
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
