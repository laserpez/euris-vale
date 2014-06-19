<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageActivities.aspx.cs" Inherits="VALE.Prova" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script type="text/javascript">
        function ChangeStatus(id, status) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            var url = "Prova.aspx?Method=ChangeStatus&id=" + id + "&status=" + status;
            xmlhttp.open("Get", url, false);
            xmlhttp.send(null);
            var result = xmlhttp.responseText;
        }
    </script>
    
    <div class="container" onload="Go()">
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
                                            <div class="col-lg-6">
                                                <ul class="nav nav-pills col-lg-6">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Gestione Attività"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="navbar-right">
                                                <asp:DropDownList AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlSelectProject_SelectedIndexChanged" ID="ddlSelectProject" SelectMethod="GetProjects" ItemType="VALE.Models.Project" DataTextField="ProjectName" DataValueField="ProjectId"></asp:DropDownList>
                                                <div class="btn-group">
                                                    <button type="button" id="ButtonAllActivities" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Tutti  <span class="caret"></span></button>
                                                    <button type="button" visible="false" id="ButtonProjectActivities" class="btn btn-success dropdown-toggle" data-toggle="dropdown" runat="server">Per Progetto  <span class="caret"></span></button>
                                                    <button type="button" visible="false" id="ButtonNotRelatedActivities" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" runat="server">Non Correlate  <span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <asp:LinkButton ID="LinkButtonAllActivities" runat="server" OnClick="LinkButtonAllActivities_Click"><span class="glyphicon glyphicon-tasks"></span> Tutte</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton ID="LinkButtonProjectActivities" runat="server" OnClick="LinkButtonProjectActivities_Click"><span class="glyphicon glyphicon-inbox"></span> Per Progetto</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton ID="LinkButtonNotRelatedActivities" runat="server" OnClick="LinkButtonNotRelatedActivities_Click"><span class="glyphicon glyphicon-resize-full"></span> Non Correlate</asp:LinkButton></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="max-height: 700px; overflow: auto;">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Show filters" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                                        </div>
                                        <div runat="server" id="filterPanel" class="panel-body">
                                            <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                                            <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                                            <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Descrizione"></asp:Label>
                                            <asp:TextBox CssClass="form-control" runat="server" ID="txtDescription"></asp:TextBox>

                                            <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Dal"></asp:Label>
                                            <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtFromDate"></asp:TextBox>
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtFromDate"></asp:CalendarExtender>
                                            <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Al"></asp:Label>
                                            <asp:TextBox CssClass="form-control" runat="server" ID="txtToDate"></asp:TextBox>
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtToDate"></asp:CalendarExtender>
                                            <br />
                                            <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info" />
                                            <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-3">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-share-alt"></span>&nbsp;&nbsp;To Be Planned
                                                     <div class="navbar-right">
                                                        <button type="button" runat="server" class="btn btn-success btn-xs" onserverclick="btnCreateActivity_Click"><span class="glyphicon glyphicon-plus"></span></button>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:GridView ID="ToBePlannedGridView0" runat="server" AutoGenerateColumns="False"
                                                        ItemType="VALE.Models.Activity"
                                                        CssClass="table table-striped table-bordered"
                                                        SelectMethod="ToBePlannedGridViewGetData"
                                                        ShowHeaderWhenEmpty="true">
                                                        <Columns>
                                                            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                            <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                                                            <asp:TemplateField HeaderText="Data">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-3">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-play"></span>&nbsp;&nbsp;Ongoing
                                                    <div class="navbar-right">
                                                        <button type="button" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus"></span></button>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:GridView ID="OngoingGridView1" runat="server" AutoGenerateColumns="False"
                                                        ItemType="VALE.Models.Activity"
                                                        CssClass="table table-striped table-bordered"
                                                        SelectMethod="OngoingGridViewGetData"
                                                        ShowHeaderWhenEmpty="true">
                                                        <Columns>
                                                            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                            <asp:BoundField DataField="ActivityName" HeaderText="Nome" />
                                                            <asp:TemplateField HeaderText="Data">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-3">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-pause"></span>&nbsp;&nbsp;Suspended
                                                     <div class="navbar-right">
                                                        <button type="button" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus"></span></button>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:GridView ID="SuspendedGridView2" runat="server" AutoGenerateColumns="False"
                                                        ItemType="VALE.Models.Activity"
                                                        CssClass="table table-striped table-bordered"
                                                        SelectMethod="SuspendedGridViewGetData"
                                                        ShowHeaderWhenEmpty="true">
                                                        <Columns>
                                                            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                            <asp:BoundField DataField="ActivityName" HeaderText="Nome" />
                                                            <asp:TemplateField HeaderText="Data">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-3">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-stop"></span>&nbsp;&nbsp;Done
                                                     <div class="navbar-right">
                                                        <button type="button" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus"></span></button>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 400px; overflow: auto;">
                                                    <asp:GridView ID="DoneGridView3" runat="server" AutoGenerateColumns="False"
                                                        ItemType="VALE.Models.Activity"
                                                        CssClass="table table-striped table-bordered"
                                                        SelectMethod="DoneGridViewGetData"
                                                        ShowHeaderWhenEmpty="true">
                                                        <Columns>
                                                            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                            <asp:BoundField DataField="ActivityName" HeaderText="Nome" />
                                                            <asp:TemplateField HeaderText="Data">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>



</asp:Content>
