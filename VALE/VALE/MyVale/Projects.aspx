<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="VALE.MyVale.Projects" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Progetti"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">
                                        <asp:Button runat="server" Text="Crea Progetto"  CssClass="btn btn-success" ID="btnAddProject" OnClick="btnAddProject_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <p>
                                <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:Panel ID="ExternalPanelDefault" runat="server" CssClass="panel panel-default">
                                            <asp:Panel ID="InternalPanelHeading" runat="server" CssClass="panel-heading">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="col-lg-10">
                                                            <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Mostra filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                                                        </div>
                                                        <div class="navbar-right">
                                                            <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" Visible="false" OnClick="btnFilterProjects_Click" CssClass="btn btn-info btn-xs" />
                                                            <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" Visible="false" OnClick="btnClearFilters_Click" CssClass="btn btn-danger btn-xs" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <div runat="server" id="filterPanel" class="panel-body">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                                                        <asp:TextBox CssClass="col-md-4 form-control input-sm" runat="server" ID="txtName"></asp:TextBox>
                                                        <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Descrizione"></asp:Label>
                                                        <asp:TextBox CssClass="form-control col-md-4 input-sm" runat="server" ID="txtDescription"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <br />
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Creato il"></asp:Label>
                                                        <asp:TextBox CssClass="col-md-4 form-control input-sm" runat="server" ID="txtCreationDate"></asp:TextBox>
                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtCreationDate"></asp:CalendarExtender>
                                                        <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Ultima modifica"></asp:Label>
                                                        <asp:TextBox CssClass="form-control col-md-4 input-sm" runat="server" ID="txtLastModifiedDate"></asp:TextBox>
                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtLastModifiedDate"></asp:CalendarExtender>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <br />
                                                    </div>
                                                </div>
                                                <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Stato"></asp:Label>
                                                <asp:DropDownList SelectMethod="PopulateDropDown" Width="200" CssClass="col-md-10 form-control input-sm" ID="ddlStatus" runat="server"></asp:DropDownList>
                                            </div>
                                        </asp:Panel>
                                        <asp:GridView OnDataBound="OpenedProjectList_DataBound" ID="OpenedProjectList" AllowPaging="true" PageSize="10" OnPageIndexChanging="OpenedProjectList_PageIndexChanging" DataKeyNames="ProjectId" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                            ItemType="VALE.Models.Project" EmptyDataText="Non sono presenti progetti aperti." CssClass="table table-striped table-bordered" OnSorting="OpenedProjectList_Sorting">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <center><div><asp:LinkButton CommandArgument="ProjectName" CommandName="sort" runat="server" ID="labelProjectName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center><div><asp:Label runat="server"><%#: Item.ProjectName %></asp:Label></div></center>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center><div><asp:Label ID="lblContent" runat="server"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <center><div><asp:LinkButton CommandArgument="CreationDate" CommandName="sort" runat="server" ID="labelCreationDate"><span  class="glyphicon glyphicon-calendar"></span> Data Creazione</asp:LinkButton></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="150px" />
                                                    <ItemStyle Width="150px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <center><div><asp:LinkButton CommandArgument="LastModified" CommandName="sort" runat="server" ID="labelLastModified"><span  class="glyphicon glyphicon-calendar"></span> Ultima modifica</asp:LinkButton></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center><div><asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label></div></center>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="150px" />
                                                    <ItemStyle Width="150px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <center><div><asp:LinkButton CommandArgument="Status" CommandName="sort" runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center><div><asp:Label runat="server"><%#: Item.Status %></asp:Label></div></center>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="90px" />
                                                    <ItemStyle Width="90px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                                <center><div><asp:Label runat="server" ID="labelAttend"><span  class="glyphicon glyphicon-thumbs-up"></span> Partecipa</asp:Label></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center><div><asp:Button runat="server" CommandArgument="<%#: Item.ProjectId %>" Width="150" Text="Partecipa" CssClass="btn btn-info btn-xs" ID="btnWorkOnThis"  OnClick="btnWorkOnThis_Click" /></div></center>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="100px" />
                                                    <ItemStyle Width="100px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <center><div><asp:Label runat="server" ID="labelDetails"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <center><div><asp:Button CommandArgument="<%#: Item.ProjectId %>" runat="server" Width="90" Text="Visualizza" CssClass="btn btn-info btn-xs" ID="btnViewDetails" OnClick="btnViewDetails_Click" /></div></center>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="90px" />
                                                    <ItemStyle Width="90px" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerSettings Position="Bottom" />
                                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>