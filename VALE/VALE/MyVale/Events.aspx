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
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Calendario eventi"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Panel ID="ExternalPanelDefault" runat="server" CssClass="panel panel-default">
                                        <asp:Panel ID="InternalPanelHeading" runat="server" CssClass="panel-heading">
                                            <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Mostra filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                                        </asp:Panel>
                                        <div runat="server" id="filterPanel" class="panel-body" visible="false">
                                            <div class="col-md-2">
                                                <asp:Label runat="server" Text="Da" CssClass="control-label"></asp:Label>
                                                <asp:TextBox runat="server" CausesValidation="true" ID="txtFromDate" CssClass="form-control" OnTextChanged="txtFromDate_TextChanged" AutoPostBack="true" ></asp:TextBox>
                                                <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtFromDate"></asp:CalendarExtender>
                                            </div>
                                            <div class="col-md-2">
                                                <asp:Label runat="server" Text="A" CssClass="control-label"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control" ></asp:TextBox>
                                                <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtToDate"></asp:CalendarExtender>
                                            </div>
                                            <br />
                                            <br />
                                            <br />
                                            <asp:Button runat="server" Text="Cerca" ID="btnFilterEvents" OnClick="btnFilterEvents_Click" CssClass="btn btn-info" />
                                            <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" CausesValidation="false" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                                        </div>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtFromDate" ErrorMessage="Date from format in DD/MM/YYYY" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$"></asp:RegularExpressionValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtToDate" ErrorMessage="Date to format in DD/MM/YYYY" ValidationExpression="^(0[1-9]|[12][0-9]|3[01])[-/.](0[1-9]|1[012])[-/.](19|20)\d\d$"></asp:RegularExpressionValidator>
                                        
                                    </asp:Panel>
                                    <div class="col-md-12">
                                        <asp:GridView runat="server" OnRowDataBound="grdEvents_RowDataBound" ItemType="VALE.Models.Event" DataKeyNames="EventId" AllowSorting="true" AutoGenerateColumns="false" EmptyDataText="Non ci sono eventi per il periodo selezionato"
                                            CssClass="table table-striped table-bordered" ID="grdEvents" SelectMethod="grdEvents_GetData" AllowPaging="true">
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
                                                        <center><div><asp:Label ID="lblContent" runat="server"></asp:Label></div></center>
                                                    </ItemTemplate>
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
                                            </Columns>
                                        </asp:GridView>
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
