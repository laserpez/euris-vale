<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SummaryInterventions.aspx.cs" Inherits="VALE.MyVale.SummaryInterventions" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
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
                                    <div class="col-lg-8">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="Label1" runat="server" Text="Repilogo interventi"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">
                                        <div class="btn-group" runat="server" id="divAllOrPersonal" visible="false">
                                            <asp:Label ID="lblAllOrPersonal" Visible="false" runat="server" Text="Personal"></asp:Label>
                                            <button type="button" id="btnPersonal" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Personali  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="btnAllUsers" class="btn btn-success dropdown-toggle" data-toggle="dropdown" runat="server">Tutti Gli Utenti <span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li>
                                                    <asp:LinkButton ID="btnPersonalLinkButton"  runat="server" OnClick="btnPersonalLinkButton_Click"><span class="glyphicon glyphicon-tasks"></span> Personali</asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton ID="btnAllUsersLinkButton" runat="server" OnClick="btnAllUsersLinkButton_Click"><span class="glyphicon glyphicon-inbox"></span> Tutti Gli Utenti</asp:LinkButton></li>
                                            </ul>
                                        </div>
                                        <div class="btn-group">
                                            <asp:Label ID="ProjectOrNorRelated" Visible="false" runat="server" Text="Project"></asp:Label>
                                            <button type="button" id="btnProjectActivities" class="btn btn-success dropdown-toggle" data-toggle="dropdown" runat="server">Per Progetto  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="btnNotRelatedActivities" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" runat="server">Non Correlate  <span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li>
                                                    <asp:LinkButton ID="btnProjectActivitiesLinkButton" OnClick="btnProjectActivitiesLinkButton_Click" runat="server"><span class="glyphicon glyphicon-inbox"></span> Per Progetto</asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton ID="btnNotRelatedActivitiesLinkButton" OnClick="btnNotRelatedActivitiesLinkButton_Click" runat="server"><span class="glyphicon glyphicon-resize-full"></span> Non Correlate</asp:LinkButton></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="col-lg-10">
                                                        <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Visualizza filtri" ID="btnFiltersVisibility" OnClick="btnFiltersVisibility_Click" />
                                                    </div>
                                                    <div class="navbar-right">
                                                        <asp:Button runat="server" Text="Cerca" ID="btnApplyFilters"  CssClass="btn btn-info btn-xs" OnClick="btnApplyFilters_Click" />
                                                        <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters"  CssClass="btn btn-danger btn-xs" OnClick="btnClearFilters_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div runat="server" id="filterPanel" class="panel-body">
                                            <asp:Label ID="lblFilterVisibility" Visible="false" runat="server" Text="True"></asp:Label>
                                            <div runat="server" id="UserPanel" visible="false">
                                                <legend>Utenti</legend>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Gruppo"></asp:Label>
                                                            <div class="col-md-10">
                                                                <asp:DropDownList AutoPostBack="true" Width="280px" CssClass="form-control input-sm" runat="server" OnSelectedIndexChanged="ddlUserGroup_SelectedIndexChanged" ID="ddlUserGroup"  DataTextField="GroupName" DataValueField="GroupId" ></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Utente"></asp:Label>
                                                            <div class="col-md-10">
                                                                <asp:DropDownList AutoPostBack="true" Width="280px" CssClass="form-control input-sm col-md-6" runat="server" OnSelectedIndexChanged="ddlUser_SelectedIndexChanged" ID="ddlUser" ItemType="VALE.Models.UserData" DataTextField="UserName" DataValueField="UserName"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <br />
                                                </div>
                                            </div>
                                            <div runat="server" id="projectPanel">
                                                <legend>Progetti</legend>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Tipo"></asp:Label>
                                                            <div class="col-md-10">
                                                                <asp:DropDownList AutoPostBack="true" Width="280px" CssClass="form-control input-sm" runat="server" OnSelectedIndexChanged="ddlProjectType_SelectedIndexChanged" ID="ddlProjectType"  ItemType="VALE.Models.ProjectType"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Progetto"></asp:Label>
                                                            <div class="col-md-10">
                                                                <asp:DropDownList AutoPostBack="true" Width="280px" CssClass="form-control input-sm col-md-6" runat="server" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged" ID="ddlProject"  ItemType="VALE.Models.Project" DataTextField="ProjectName" DataValueField="ProjectId"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="col-md-12">
                                                    <br />
                                                </div>
                                            </div>
                                            <div runat="server" id="activityPanel">
                                                <legend>Attività</legend>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true"  CssClass="col-md-2 control-label" runat="server" Text="Tipo"></asp:Label>
                                                            <div class="col-md-10">
                                                                <asp:DropDownList AutoPostBack="true" Width="280px" CssClass="form-control input-sm" runat="server" OnSelectedIndexChanged="ddlActivityType_SelectedIndexChanged" ID="ddlActivityType" ></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Attività"></asp:Label>
                                                            <div class="col-md-10">
                                                                <asp:DropDownList CssClass="form-control input-sm"  Width="280px" runat="server" ID="ddlActivity" ItemType="VALE.Models.Activity" DataTextField="ActivityName" DataValueField="ActivityId"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12">
                                                        <br />
                                                    </div>
                                                    <div class="col-md-12">
                                                        <asp:UpdatePanel runat="server">
                                                            <ContentTemplate>
                                                                <div class="col-md-6">
                                                                    <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Dal"></asp:Label>
                                                                    <div class="col-md-10">
                                                                        <asp:TextBox CssClass="form-control input-sm" runat="server" ID="txtFromDate"></asp:TextBox>
                                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtFromDate"></asp:CalendarExtender>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Al"></asp:Label>
                                                                    <div class="col-md-10">
                                                                        <asp:TextBox CssClass="form-control input-sm" runat="server" ID="txtToDate"></asp:TextBox>
                                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtToDate"></asp:CalendarExtender>
                                                                    </div>
                                                                </div>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            Interventi
                                                            <div class="navbar-right">
                                                                <asp:Button runat="server" Text="Esporta CSV" CssClass="btn btn-info btn-sm" ID="btnExportCSV" OnClick="btnExportCSV_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <div class="panel-body">
                                                            <asp:GridView runat="server" ID="grdActivityReport" DataKeyNames="ActivityId" ItemType="VALE.Models.SummaryIntervention" AutoGenerateColumns="false" SelectMethod="grdActivityReport_GetData"
                                                                CssClass="table table-striped table-bordered" AllowSorting="true" AllowPaging="true" PageSize="10" EmptyDataText="Nessun intervento">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" ><span  class="glyphicon glyphicon-th"></span> Progetto</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label  runat="server"><%#: Item.ProjectName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="120px" />
                                                                        <ItemStyle Width="120px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" ><span  class="glyphicon glyphicon-th"></span> Progetto Correlato</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label  runat="server"><%#: Item.RelatedProjectName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="120px" />
                                                                        <ItemStyle Width="120px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" ><span  class="glyphicon glyphicon-th"></span> Nome Attività</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label  runat="server"><%#: Item.ActivityName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="120px" />
                                                                        <ItemStyle Width="120px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="ActivityDescription" CommandName="sort" runat="server" ><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label ID="lblContent" runat="server"><%#: Item.ActivityDescription %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="120px" />
                                                                        <ItemStyle Width="120px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server"  CommandArgument="HoursWorked" CommandName="sort"><span  class="glyphicon glyphicon-time"></span> Ore di attività</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.HoursWorked %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Data">
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
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
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btnExportCSV" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
