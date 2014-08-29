<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VALE._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <p></p>
    <div id="notLoggedUser" style="background-image:url(~/Images/Logo_VALE.png)" runat="server" class="row">
        <div class="col-md-2">
            <asp:Image runat="server" ID="LogoImage" Width="159" Height="196" />
        </div>
        <div class="col-md-10" style="font-size: x-large; position:relative">
            
                <h2>Benvenuto in VALE, ambiente virtuale di collaborazione</h2>
            
            <p>
                &nbsp;Fai il log-in per accedere alle sezioni interne <a runat="server" href="~/Account/Login">Qui</a>.
            </p>
            <p>
                &nbsp;Se non sei ancora registrato clicca <a runat="server" href="~/Account/Register">Qui</a>.
            </p>
        </div>
    </div>

    <div id="loggedUser" runat="server" class="row">
        <div class="col-md-4" >
            <h3>Progetti</h3>
            <asp:ListView ID="lstProgetti" DataKeyNames="ProjectId" runat="server" ItemType="VALE.Models.Project" SelectMethod="GetProjects">
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
                                <asp:Label  Font-Bold="true" runat="server">Organizzato da: </asp:Label>
                                <asp:Label  runat="server"><%#: Item.OrganizerUserName %></asp:Label>
                            </div>
                           <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Ultima Modifica: </asp:Label>
                                <asp:Label  runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Buget(Ore): </asp:Label>
                                <asp:Label runat="server" ID="lblHoursWorked" CssClass="control-label"><%#: GetWorkInfo(Item) %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Partecipanti: </asp:Label>
                                <asp:Label runat="server"><%#: Item.InvolvedUsers.Count() %></asp:Label>
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
        <div class="col-md-4" >
            <h3>Eventi</h3>
            <asp:ListView ID="lstEvents" DataKeyNames="EventId" runat="server" ItemType="VALE.Models.Event" SelectMethod="GetEvents">
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
                                <asp:Label  Font-Bold="true" runat="server">Organizzato da: </asp:Label>
                                <asp:Label  Font-Bold="false" runat="server"><%#: Item.OrganizerUserName %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Data: </asp:Label>
                                <asp:Label  Font-Bold="false" runat="server"><%#: Item.EventDate.ToShortDateString()%></asp:Label>
                                <asp:Label  Font-Bold="true" runat="server">Ore: </asp:Label>
                                <asp:Label  Font-Bold="false" runat="server"><%#: Item.EventDate.ToShortTimeString() %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Luogo: </asp:Label>
                                <asp:Label ID="lblContentEvent" runat="server"><%#:Item.Site %></asp:Label>
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
        <div class="col-md-4" >
            <h3>Attività</h3>
            <asp:ListView ID="lstActivities" DataKeyNames="ActivityId" runat="server" ItemType="VALE.Models.Activity" SelectMethod="GetActivities">
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
                                <asp:Label  Font-Bold="true" runat="server">Organizzato da: </asp:Label>
                                <asp:Label  runat="server"><%#: Item.CreatorUserName %></asp:Label>
                            </div>
                           <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Ultima Modifica: </asp:Label>
                                <asp:Label  runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Buget(Ore): </asp:Label>
                                <asp:Label runat="server" ID="lblHoursWorked" CssClass="control-label"><%#: GetWorkInfo(Item) %></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <asp:Label  Font-Bold="true" runat="server">Partecipanti: </asp:Label>
                                <asp:Label runat="server"><%#: Item.RegisteredUsers.Count() %></asp:Label>
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
    <div id="log" class="panel panel-default" runat="server">
        <div class="panel-body">
            <div class="row">
                <div class="col-md-12"  style="font-size:24px">
                    Messaggi
                </div>
                <div class="col-md-12">
                    <br />
                </div>
            </div>
            <div class="row">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="grdLog" CssClass="table table-striped table-hover" DataKeyNames="LogEntryEmailId" runat="server" ItemType="VALE.Logic.LogEntryEmail" AutoGenerateColumns="false" SelectMethod="grdLog_GetData"
                            GridLines="None" AllowPaging="true" AllowSorting="true" PageSize="10">
                            <Columns>
                                <asp:BoundField HeaderStyle-Width="10%" DataFormatString="{0:d}" DataField="Date" HeaderText="Data" SortExpression="Date" />
                                <asp:TemplateField HeaderText="Tipo" SortExpression="DataType" HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <span title="<%#: Item.DataType %>" class="<%#:Item.DataTypeUrl %>"></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderStyle-Width="30%" DataField="DataAction" HeaderText="Azione" SortExpression="DataAction" />
                                <asp:TemplateField HeaderStyle-Width="45%">
                                    <HeaderTemplate>
                                        <asp:LinkButton runat="server" CommandArgument="Body" CommandName="sort">Corpo del messaggio</asp:LinkButton>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label runat="server"><%#: GetDescription(Item.Body) %></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <center><div><asp:LinkButton ID="selectedMessage" runat="server"><span  class="glyphicon glyphicon-screenshot"></span></asp:LinkButton></div></center>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <center><div><asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="selectedMessage_Click" ID="chkSelectMessage"/></div></center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <PagerSettings Position="Bottom" />
                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>
</asp:Content>
