<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VALE._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <h2>Benvenuto in VALE, ambiente virtuale di collaborazione</h2>
    </div>

    <div id="notLoggedUser" runat="server" class="row">
        <div class="col-md-10" style="font-size: x-large">
            <p>
                &nbsp;Fai il log-in per accedere alle sezioni interne <a runat="server" href="~/Account/Login">Qui</a>.
            </p>
            <p>
                &nbsp;Se non sei ancora registrato clicca <a runat="server" href="~/Account/Register">Qui</a>.
            </p>
        </div>
    </div>

    <div id="loggedUser" runat="server" class="row">
        <div class="col-md-4" style="max-height: 600px; overflow: auto">
            <h3>Progetti</h3>
            <asp:ListView ID="lstProgetti" runat="server" ItemType="VALE.Models.Project" SelectMethod="GetProjects">
                <ItemTemplate>
                    <div class="well">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-8">
                                    <ul class="nav nav-pills">
                                        <li>
                                            <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.ProjectName %></asp:Label></li>
                                    </ul>
                                </div>
                                <div class="navbar-right">
                                    <asp:Button runat="server" Text="Visualizza" ID="btnViewProjectDetails" CommandArgument='<%#: String.Format("ProjectDetails?projectId={0}", Item.ProjectId) %>' CssClass="btn btn-primary btn-sm" OnClick="btnViewDetails_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label Font-Underline="true" runat="server"><%#: Item.OrganizerUserName %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label runat="server"><%#: Item.Description.Length >= 40 ? Item.Description.Substring(0,40) + "..." : Item.Description %></asp:Label>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <ItemSeparatorTemplate>
                    <br />
                </ItemSeparatorTemplate>
                <EmptyDataTemplate>
                    <div class="well">
                        Nessun progetto creato.
                    </div>
                </EmptyDataTemplate>
            </asp:ListView>
            <br />
            <asp:Button CommandArgument="Projects" Text="Vedi tutti" CssClass="btn btn-info btn-sm" ID="btnViewAll" OnClick="btnViewAll_Click" runat="server" />
        </div>
        <div class="col-md-4" style="max-height: 600px; overflow: auto">
            <h3>Eventi</h3>
            <asp:ListView ID="lstEvents" runat="server" ItemType="VALE.Models.Event" SelectMethod="GetEvents">
                <ItemTemplate>
                    <div class="well">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-8">
                                    <ul class="nav nav-pills">
                                        <li>
                                            <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.Name %></asp:Label></li>
                                    </ul>
                                </div>
                                <div class="navbar-right">
                                    <asp:Button runat="server" Text="Visualizza" ID="Button3" CommandArgument='<%#: String.Format("EventDetails?eventId={0}", Item.EventId) %>' CssClass="btn btn-primary btn-sm" OnClick="btnViewDetails_Click"  />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label Font-Underline="true" runat="server"><%#: Item.OrganizerUserName %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label runat="server"><%#: Item.Description.Length >= 40 ? Item.Description.Substring(0,40) + "..." : Item.Description %></asp:Label>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <ItemSeparatorTemplate>
                    <br />
                </ItemSeparatorTemplate>
                <EmptyDataTemplate>
                    <div class="well">
                        Nessun evento creato.
                    </div>
                </EmptyDataTemplate>
            </asp:ListView>
            <br />
            <asp:Button CommandArgument="Events" Text="Vedi tutti" CssClass="btn btn-info btn-sm" ID="Button1" OnClick="btnViewAll_Click" runat="server" />
        </div>
        <div class="col-md-4" style="max-height: 600px; overflow: auto">
            <h3>Attività</h3>
            <asp:ListView ID="lstActivities" runat="server" ItemType="VALE.Models.Activity" SelectMethod="GetActivities">
                <ItemTemplate>
                    <div class="well">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="col-md-8">
                                    <ul class="nav nav-pills">
                                        <li>
                                            <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.ActivityName %></asp:Label>
                                    </ul>
                                </div>
                                <div class="navbar-right">
                                    <asp:Button runat="server" Text="Visualizza" ID="Button4" CommandArgument='<%#: String.Format("ActivityDetails?activityId={0}", Item.ActivityId) %>' CssClass="btn btn-primary btn-sm" OnClick="btnViewDetails_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label Font-Underline="true" runat="server"><%#: Item.CreatorUserName %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label runat="server"><%#: Item.Description.Length >= 40 ? Item.Description.Substring(0,40) + "..." : Item.Description %></asp:Label>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <ItemSeparatorTemplate>
                    <br />
                </ItemSeparatorTemplate>
                <EmptyDataTemplate>
                    <div class="well">
                        Nessuna attività creata.
                    </div>
                </EmptyDataTemplate>
            </asp:ListView>
            <br />
            <asp:Button CommandArgument="Activities" Text="Vedi tutti" CssClass="btn btn-info btn-sm" ID="Button2" OnClick="btnViewAll_Click" runat="server" />
        </div>

    </div>
    <br />
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12"  style="font-size:24px">
                    Ultime attività
                </div>
                <div class="col-md-12">
                    <br />
                </div>
            </div>

            <div class="row" id="log">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="grdLog" CssClass="table table-striped table-hover" runat="server" ItemType="VALE.Logic.LogEntry" AutoGenerateColumns="false" SelectMethod="GetLogEntry"
                            GridLines="None" AllowPaging="true" AllowSorting="true" PageSize="10">
                            <Columns>
                                <asp:BoundField HeaderStyle-Width="10%" DataFormatString="{0:d}" DataField="Date" HeaderText="Data" SortExpression="Date" />
                                <asp:TemplateField HeaderText="Tipo" SortExpression="DataType" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <span title="<%#: Item.DataType %>" class="<%#:Item.DataTypeUrl %>" ></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="DataAction" HeaderText="Azione" SortExpression="DataAction" />
                                <asp:BoundField DataField="Description" HeaderText="Dettagli" SortExpression="Description" />
                                <asp:BoundField DataField="Username" HeaderText="Utente" SortExpression="Username" />
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
</asp:Content>
