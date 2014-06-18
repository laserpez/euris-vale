<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Prova.aspx.cs" Inherits="VALE.Prova" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script type="text/javascript">
        //$(function () {
        //    $('.table').sortable({
        //        items: 'tr:not(tr:first-child)',
        //        cursor: 'crosshair',
        //        connectWith: '.table',
        //        dropOnEmpty: true,
        //        receive: function (e, ui) {
        //            $(this).find('tbody').append(ui.item);
        //            var receverTableId = this.id;
        //            var status = receverTableId.charAt(receverTableId.length - 1);
        //            var activityId = ui.item.find('td')[0].innerHTML;
        //            ChangeStatus(activityId, status);
        //        }
        //    });
        //});

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
                                                            <asp:Label ID="HeaderName" runat="server" Text="Gestione Attività."></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="navbar-right">
                                                <div class="btn-group">
                                                    <button type="button" id="ButtonAllActivities" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Tutti  <span class="caret"></span></button>
                                                    <button type="button" visible="false" id="ButtonProjectActivities" class="btn btn-success dropdown-toggle" data-toggle="dropdown" runat="server">Per Progetto  <span class="caret"></span></button>
                                                    <button type="button" visible="false" id="ButtonNotRelatedActivities" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" runat="server">Non Correlate  <span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <asp:LinkButton ID="LinkButtonAllActivities" runat="server" OnClick="LinkButtonAllActivities_Click"><span class="glyphicon glyphicon-tasks"></span> Tutti</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton id="LinkButtonProjectActivities" runat="server" OnClick="LinkButtonProjectActivities_Click"><span class="glyphicon glyphicon-inbox"></span> Per Progetto</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton ID="LinkButtonNotRelatedActivities" runat="server" OnClick="LinkButtonNotRelatedActivities_Click"><span class="glyphicon glyphicon-resize-full"></span> Non Correlate</asp:LinkButton></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="max-height: 300px; overflow: auto;">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-3">
                                            <div class="panel panel-default">
                                                <div class="panel-heading"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;&nbsp;To Be Planned</div>
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
                                                <div class="panel-heading"><span class="glyphicon glyphicon-play"></span>&nbsp;&nbsp;Ongoing</div>
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
                                                <div class="panel-heading"><span class="glyphicon glyphicon-pause"></span>&nbsp;&nbsp;Suspended</div>
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
                                                <div class="panel-heading"><span class="glyphicon glyphicon-stop"></span>&nbsp;&nbsp;Done</div>
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
