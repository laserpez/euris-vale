<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageActivities.aspx.cs" Inherits="VALE.Prova" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>

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
            var url = "ManageActivities.aspx?Method=ChangeStatus&id=" + id + "&status=" + status;
            xmlhttp.open("Get", url, false);
            xmlhttp.send(null);
            var result = xmlhttp.responseText;
        }
    </script>

    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-8">
                                                <ul class="nav nav-pills">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Gestione Attività"></asp:Label>
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
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="col-lg-10">
                                                                <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Visualizza filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                                                            </div>
                                                            <div class="navbar-right">
                                                                <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info btn-xs" />
                                                                <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger btn-xs" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div runat="server" id="filterPanel" class="panel-body">
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
                                                        <legend>Attività</legend>

                                                    </div>

                                                    <center><div>
                                                <div class="col-md-6">
                                                    <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                                                    <asp:TextBox CssClass="col-md-2 form-control input-sm" runat="server" ID="txtName"></asp:TextBox>
                                                </div>
                                                <div class="col-md-6">
                                                    <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Descrizione"></asp:Label>
                                                    <asp:TextBox CssClass="form-control input-sm" runat="server" ID="txtDescription"></asp:TextBox>
                                                </div>
                     
                                            <div  class="col-md-12"><br /></div>
                                                <%--<asp:UpdatePanel runat="server">
                                                    <ContentTemplate>--%>
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Dal"></asp:Label>
                                                            <asp:TextBox CssClass="col-md-2 form-control input-sm" runat="server" ID="txtFromDate" OnTextChanged="txtFromDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtFromDate"></asp:CalendarExtender>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Al"></asp:Label>
                                                            <asp:TextBox CssClass="form-control input-sm" runat="server" ID="txtToDate"></asp:TextBox>
                                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtToDate"></asp:CalendarExtender>
                                                        </div>
                                                    <%--</ContentTemplate>
                                                </asp:UpdatePanel>--%>
                                                </div></center>
                                                    
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-share-alt"></span>&nbsp;&nbsp;Da Pianificare
                                                     <div class="navbar-right">
                                                         <button type="button" runat="server" class="btn btn-success btn-xs" title="Crea nuova attività (stato: da pianificare)" onserverclick="btnCreateActivityToBePlannedStatus_Click"><span class="glyphicon glyphicon-plus"></span></button>
                                                     </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="ToBePlannedGridView0" runat="server" AutoGenerateColumns="False"
                                                                ItemType="VALE.Models.Activity" AllowSorting="true" OnSorting="GridView_Sorting"
                                                                CssClass="table table-striped table-bordered"
                                                                ShowHeaderWhenEmpty="true">
                                                                <Columns>
                                                                    <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <a href="/MyVale/ActivityDetails?activityId=<%#: Item.ActivityId %>"><%#: Item.ActivityName %></a>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Nessuna Data" %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                                        <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-play"></span>&nbsp;&nbsp;In Corso
                                                    <div class="navbar-right">
                                                        <button type="button" class="btn btn-success btn-xs" runat="server" title="Crea nuova attività (stato: in corso)" onserverclick="btnCreateActivityOngoingStatus_Click"><span class="glyphicon glyphicon-plus"></span></button>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="OngoingGridView1" runat="server" AutoGenerateColumns="False"
                                                                ItemType="VALE.Models.Activity" AllowSorting="true" OnSorting="GridView_Sorting"
                                                                CssClass="table table-striped table-bordered"
                                                                ShowHeaderWhenEmpty="true">
                                                                <Columns>
                                                                    <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <a href="/MyVale/ActivityDetails?activityId=<%#: Item.ActivityId %>"><%#: Item.ActivityName %></a>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Nessuna Data" %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                                        <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-6 col-md-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-pause"></span>&nbsp;&nbsp;Sospeso
                                                     <div class="navbar-right">
                                                         <button type="button" class="btn btn-success btn-xs" runat="server" title="Crea nuova attività (stato: sospeso)" onserverclick="btnCreateActivitySuspendedStatus_Click"><span class="glyphicon glyphicon-plus"></span></button>
                                                     </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="SuspendedGridView2" runat="server" AutoGenerateColumns="False"
                                                                ItemType="VALE.Models.Activity"
                                                                CssClass="table table-striped table-bordered"
                                                                AllowSorting="true" OnSorting="GridView_Sorting"
                                                                ShowHeaderWhenEmpty="true">
                                                                <Columns>
                                                                    <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <a href="/MyVale/ActivityDetails?activityId=<%#: Item.ActivityId %>"><%#: Item.ActivityName %></a>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server" ><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Nessuna Data" %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                                        <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6 col-md-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-stop"></span>&nbsp;&nbsp;Terminato
                                                     <div class="navbar-right">
                                                         <button type="button" class="btn btn-success btn-xs" runat="server" title="Crea nuova attività (stato: terminato)" onserverclick="btnCreateActivityDoneStatus_Click"><span class="glyphicon glyphicon-plus"></span></button>
                                                     </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="DoneGridView3" runat="server" AutoGenerateColumns="False"
                                                                ItemType="VALE.Models.Activity"
                                                                CssClass="table table-striped table-bordered"
                                                                AllowSorting="true" OnSorting="GridView_Sorting"
                                                                ShowHeaderWhenEmpty="true">
                                                                <Columns>
                                                                    <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <a href="/MyVale/ActivityDetails?activityId=<%#: Item.ActivityId %>"><%#: Item.ActivityName %></a>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemStyle Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Nessuna Data" %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                                        <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
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
