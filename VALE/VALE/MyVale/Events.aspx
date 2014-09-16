<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="VALE.MyVale.Events" %>
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
                                    <div class="col-lg-6">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Calendario eventi"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">
                                         <asp:Button runat="server" Text="Crea Evento"  CssClass="btn btn-success" ID="btnAddEvent" OnClick="btnAddEvent_Click" />
                                         <div class="btn-group" runat="server" visible="false" id="btnAllOrPersonal">
                                            <asp:Label ID="lblAllOrPersonal" Visible="false" runat="server" Text="Personal"></asp:Label>
                                            <button type="button" id="btnPersonal" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Personali  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="btnAllUsers" class="btn btn-info dropdown-toggle" data-toggle="dropdown" runat="server">Di Tutti Gli Utenti <span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li>
                                                    <asp:LinkButton ID="btnPersonalLinkButton" runat="server" OnClick="btnPersonalLinkButton_Click"><span class="glyphicon glyphicon-tasks"></span> Personali</asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton ID="btnAllUsersLinkButton" runat="server" OnClick="btnAllUsersLinkButton_Click"><span class="glyphicon glyphicon-inbox"></span> Di Tutti Gli Utenti</asp:LinkButton></li>
                                            </ul>
                                        </div>
                                        <div class="btn-group">
                                            <asp:Label ID="EventsListType" runat="server" Text="AllEvents" Visible="false"></asp:Label>
                                            <button type="button" visible="true" id="btnList" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Tutti <span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                              <li>
                                                    <asp:LinkButton CommandArgument="AllEvents" runat="server" OnClick="ChangeSelectedEvents_Click" CausesValidation="false"><span class="glyphicon glyphicon-hdd"></span> Tutti  </asp:LinkButton></li>
                                              <li>
                                                    <asp:LinkButton CommandArgument="ProjectEvents" runat="server" OnClick="ChangeSelectedEvents_Click" CausesValidation="false"><span class="glyphicon glyphicon-inbox"></span> Per Progetto</asp:LinkButton></li>
                                              <li>
                                                    <asp:LinkButton CommandArgument="NotRelatedEvents" runat="server" OnClick="ChangeSelectedEvents_Click" CausesValidation="false"><span class="glyphicon glyphicon-resize-full"></span> Non Correlati</asp:LinkButton></li>
                                              <li>
                                                    <asp:LinkButton CommandArgument="RequestEvents" runat="server" OnClick="ChangeSelectedEvents_Click" CausesValidation="false"><span class="glyphicon glyphicon-ok-sign"></span> Richieste</asp:LinkButton></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Panel ID="ExternalPanelDefault" runat="server" CssClass="panel panel-default">
                                        <asp:Panel ID="InternalPanelHeading" runat="server" CssClass="panel-heading">
                                            <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="col-lg-10">
                                                            <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Visualizza filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                                                        </div>
                                                        <div class="navbar-right">
                                                            <asp:Button runat="server" Visible="false" Text="Cerca" ID="btnFilterEvents" OnClick="btnFilterEvents_Click" CssClass="btn btn-info btn-xs" />
                                                            <asp:Button runat="server" Visible="false" Text="Pulisci filtri" ID="btnClearFilters" CausesValidation="false" OnClick="btnClearFilters_Click" CssClass="btn btn-danger btn-xs" />
                                                        </div>
                                                    </div>
                                                </div>
                                        </asp:Panel>
                                        <div runat="server" id="filterPanel" class="panel-body" visible="false">
                                            <div runat="server" id="projectPanel">
                                                <legend>Progetto</legend>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <asp:DropDownList AutoPostBack="true" class="col-md-2 form-control input-sm" runat="server" OnSelectedIndexChanged="ddlSelectProject_SelectedIndexChanged" ID="ddlSelectProject" SelectMethod="GetProjects" ItemType="VALE.Models.Project" DataTextField="ProjectName" DataValueField="ProjectId"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <br />
                                                </div>
                                                <legend>Eventi</legend>
                                            </div>
                                            <div class="col-md-12">
                                                <div class="col-md-6">
                                                    <asp:Label runat="server" Font-Bold="true" Text="Da" CssClass="control-label col-md-1"></asp:Label>
                                                    <div class="col-md-10">
                                                        <asp:TextBox runat="server" CausesValidation="true" ID="txtFromDate" CssClass="form-control input-sm" OnTextChanged="txtFromDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtFromDate"></asp:CalendarExtender>
                                                        <asp:RegularExpressionValidator CssClass="text-danger" ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtFromDate" ErrorMessage="Date from format in DD/MM/YYYY" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            
                                                <div class="col-md-6">
                                                    <asp:Label runat="server" Font-Bold="true" Text="A" CssClass="control-label col-md-1"></asp:Label>
                                                    <div class="col-md-10">
                                                        <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control input-sm"></asp:TextBox>
                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtToDate"></asp:CalendarExtender>
                                                        <asp:RegularExpressionValidator CssClass="text-danger" ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtToDate" ErrorMessage="Date to format in DD/MM/YYYY" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$"></asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:Panel>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="col-lg-10">
                                                        Eventi
                                                    </div>
                                                    <div class="navbar-right">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div runat="server" class="panel-body">
                                            <asp:GridView runat="server" ItemType="VALE.Models.Event" DataKeyNames="EventId" AllowSorting="true" AutoGenerateColumns="false" EmptyDataText="Nessun Evento."
                                            CssClass="table table-striped table-bordered" ID="grdEvents" SelectMethod="grdEvents_GetData" AllowPaging="true" PageSize="10" OnRowCommand="grdEvents_RowCommand">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="EventDate" CommandName="sort" runat="server" ID="labelEventData"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="90px" />
                                                            <ItemStyle Width="90px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="Name" CommandName="sort" runat="server" ID="labelEventName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label runat="server"><%#: Item.Name %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelEventDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label ID="lblContent" runat="server"><%#: GetDescription(Item.Description) %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:Label runat="server" ID="labelAttend"><span  class="glyphicon glyphicon-thumbs-up"></span> Partecipa</asp:Label></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Button ID="btnAttendEvent" Width="120px" runat="server" OnClick="btnAttendEvent_Click" Text='<%#: IsUserRelated(Item.EventId) ? "Stai partecipando" : "Partecipa" %>' CssClass='<%#: IsUserRelated(Item.EventId) ? "btn btn-success btn-xs" : "btn btn-info btn-xs" %>' /></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="100px" />
                                                            <ItemStyle Width="100px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:Label runat="server" ID="labelAccept"><span  class="glyphicon glyphicon-ok-circle"></span> Accetta</asp:Label></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Button CssClass="btn btn-success btn-xs" Width="120" runat="server" CommandName="AcceptEvent" CommandArgument="<%# Item.EventId %>" Text="Accetta" /></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="120px" />
                                                            <ItemStyle Width="120px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:Label runat="server" ID="labelReject" ><span  class="glyphicon glyphicon-remove-circle"></span> Rifiuta</asp:Label></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Button CssClass="btn btn-danger btn-xs" Width="120" runat="server" Text="Rifiuta" CommandName="RejectEvent" CommandArgument="<%# Item.EventId %>"/></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="120px" />
                                                            <ItemStyle Width="120px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Button ID="btnViewDetails" Width="90" CssClass="btn btn-info btn-xs" Text="Visualizza" runat="server" OnClick="btnViewDetails_Click" /></div></center>
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
                </div>
            </div>
        </div>
    </div>
</asp:Content>
