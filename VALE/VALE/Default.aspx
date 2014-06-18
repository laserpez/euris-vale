<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VALE._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2>Benvenuto in VALE, ambiente virtuale di collaborazione</h2>
    </div>

    <div id="notLoggedUser" runat="server" class="row">
        <div class="col-md-10" style="font-size: x-large">
            <p>
                &nbsp;Fai il log-in per accedere alle sezioni interne <a runat="server" href="~/Account/Login">Qui</a>.
                <br />
                &nbsp;Puoi anche fare il log-in attraverso google, facebook, twitter o linkedin.
            </p>
            <p>
                &nbsp;Se non sei ancora registrato clicca <a runat="server" href="~/Account/Register">Qui</a>
            </p>
        </div>
    </div>

    <div id="loggedUser" runat="server" class="row">
        <div class="col-md-4" style="max-height: 600px; overflow: auto">
            <h3>Projects</h3>
            <asp:ListView ID="lstProgetti" runat="server" ItemType="VALE.Models.Project" SelectMethod="GetProjects">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td style="width: 150px">
                                <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.ProjectName %></asp:Label><br />
                            </td>
                            <td rowspan="3">
                                <asp:Button runat="server" Text="View" ID="btnViewProjectDetails" CommandArgument='<%#: String.Format("ProjectDetails?projectId={0}", Item.ProjectId) %>' CssClass="btn btn-primary btn-sm" OnClick="btnViewDetails_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label Font-Underline="true" runat="server"><%#: Item.OrganizerUserName %></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server"><%#: Item.Description.Length >= 20 ? Item.Description.Substring(0,20) + "..." : Item.Description %></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
                <ItemSeparatorTemplate>
                    <br />
                </ItemSeparatorTemplate>
                <EmptyDataTemplate>
                    No personal projects
                </EmptyDataTemplate>
            </asp:ListView>
            <br />
            <asp:Button CommandArgument="Projects" Text="View all" CssClass="btn btn-info btn-sm" ID="btnViewAll" OnClick="btnViewAll_Click" runat="server" />
        </div>
        <div class="col-md-4" style="max-height: 600px; overflow: auto">
            <h3>Events</h3>
            <asp:ListView ID="lstEvents" runat="server" ItemType="VALE.Models.Event" SelectMethod="GetEvents">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td style="width: 150px">
                                <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.Name %></asp:Label><br />
                            </td>
                            <td rowspan="3">
                                <asp:Button runat="server" Text="View" ID="btnViewEventDetails" CommandArgument='<%#: String.Format("EventDetails?eventId={0}", Item.EventId) %>' CssClass="btn btn-primary btn-sm" OnClick="btnViewDetails_Click"  />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label Font-Underline="true" runat="server"><%#: Item.OrganizerUserName %></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server"><%#: Item.Description.Length >= 20 ? Item.Description.Substring(0,20) + "..." : Item.Description %></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
                <ItemSeparatorTemplate>
                    <br />
                </ItemSeparatorTemplate>
                <EmptyDataTemplate>
                    No personal events
                </EmptyDataTemplate>
            </asp:ListView>
            <br />
            <asp:Button CommandArgument="Events" Text="View all" CssClass="btn btn-info btn-sm" ID="Button1" OnClick="btnViewAll_Click" runat="server" />
        </div>
        <div class="col-md-4" style="max-height: 600px; overflow: auto">
            <h3>Activities</h3>
            <asp:ListView ID="lstActivities" runat="server" ItemType="VALE.Models.Activity" SelectMethod="GetActivities">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td style="width: 150px">
                                <asp:Label runat="server" Font-Bold="true" ForeColor="#317eac"><%#: Item.ActivityName %></asp:Label><br />
                            </td>
                            <td rowspan="3">
                                <asp:Button runat="server" Text="View" ID="btnViewActivity" CommandArgument='<%#: String.Format("ActivityDetails?activityId={0}", Item.ActivityId) %>' CssClass="btn btn-primary btn-sm" OnClick="btnViewDetails_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label Font-Underline="true" runat="server"><%#: Item.CreatorUserName %></asp:Label><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server"><%#: Item.Description.Length >= 20 ? Item.Description.Substring(0,20) + "..." : Item.Description %></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
                <ItemSeparatorTemplate>
                    <br />
                </ItemSeparatorTemplate>
                <EmptyDataTemplate>
                    No personal activities
                </EmptyDataTemplate>
            </asp:ListView>
            <br />
            <asp:Button CommandArgument="Activities" Text="View all" CssClass="btn btn-info btn-sm" ID="Button2" OnClick="btnViewAll_Click" runat="server" />
        </div>

    </div>

</asp:Content>
