﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectDetails.aspx.cs" MaintainScrollPositionOnPostback="true" Inherits="VALE.MyVale.ProjectDetails" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-md-6">
                                    <asp:Button ID="btnBack" ToolTip="Torna indietro" runat="server" CausesValidation="false" CssClass="btn btn-primary col-md-1" Font-Bold="true" Text="&#171;" OnClick="btnBack_ServerClick" />
                                    <div class="col-lg-11">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio progetto"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="navbar-right">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Button CausesValidation="false" runat="server" ID="btnWorkOnThis" OnClick="btnWorkOnThis_Click" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:FormView Width="100%" OnDataBound="ProjectDetail_DataBound" runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetProject">
                                <ItemTemplate>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-md-9">
                                                <h3><%#: Item.ProjectName %></h3>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="navbar-right">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:UpdatePanel runat="server">
                                                                <ContentTemplate>
                                                                    <asp:Label ID="lblInfoOperation" runat="server" Visible="false"></asp:Label>
                                                                    <div class="btn-group" id="divManagProject">
                                                                        <button type="button" visible="true" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Azioni <span class="caret"></span></button>
                                                                        <ul class="dropdown-menu">
                                                                            <li>
                                                                                <asp:LinkButton runat="server" ID="btnSuspendProject" CausesValidation="false" OnClick="btnSuspendProject_Click"><span class="glyphicon glyphicon-share-alt"></span> Sospendi progetto</asp:LinkButton></li>
                                                                            <li>
                                                                                <asp:LinkButton runat="server" ID="btnCloseProject" CausesValidation="false" OnClick="btnCloseProject_Click"><span class="glyphicon glyphicon-play"></span>Chiudi progetto</asp:LinkButton></li>
                                                                        </ul>
                                                                    </div>
                                                                    <asp:Button CausesValidation="false" ID="btnModifyProject" Visible="false" CssClass="btn btn-primary" runat="server" Text="Modifica" OnClick="btnModifyProject_Click" />
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-md-12">

                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Creatore: </asp:Label><asp:Label runat="server"><%#: Item.Organizer.FullName %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Data: </asp:Label><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Ultima modifica: </asp:Label><asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                                        <br />
                                        <asp:Label runat="server"  Font-Bold="true">Tipo: </asp:Label><asp:Label runat="server" ><%#: Item.Type %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Visibilita': </asp:Label><asp:Label runat="server"><%#: Item.Public ? "Pubblica" : "Privata" %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Stato: </asp:Label><asp:Label runat="server"><%#: Item.Status.ToUpperInvariant() %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Budget: </asp:Label><asp:Label runat="server"><%#: GetHoursWorked() %> </asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Descrizione: </asp:Label><asp:Label ID="lblContent" runat="server"></asp:Label>
                                        <br />

                                    </div>
                             
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <br />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                            <div class="row">
                                                               <div class="col-md-12">
                                                                        <ul class="breadcrumb" style="margin-bottom: 1px; margin-top: 1px">
                                                                            <asp:ListView runat="server" ItemType="VALE.Models.Project" SelectMethod="GetProjectHierarchyUp">
                                                                                <ItemTemplate>
                                                                                    <li><div runat="server" Visible='<%# IsVisibleProject(Convert.ToInt32(Eval("ProjectId"))) %>'><a href="/MyVale/ProjectDetails?projectId=<%# Item.ProjectId %>"><%#: Item.ProjectName %></a></div><div runat="server" Visible='<%# !IsVisibleProject(Convert.ToInt32(Eval("ProjectId"))) %>'><%#: Item.ProjectName %></div></li>
                                                                                </ItemTemplate>
                                                                            </asp:ListView>
                                                                            <asp:ListView runat="server" ItemType="VALE.Models.Project" SelectMethod="GetProjectForHierarchy">
                                                                                <ItemTemplate>
                                                                                    <li><span class="label label-success"><%#: Item.ProjectName %></span></li>
                                                                                </ItemTemplate>
                                                                            </asp:ListView>
                                                                        </ul>
                                                                    </div>
                                                            </div>
                                                
                                                        <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <asp:TreeView ID="ProjectTreeView" ExpandDepth="0" runat="server" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  <%--Progetti correlati--%>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Progetti correlati</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button runat="server" Visible="false" Text="Aggiungi" ID="btnAddRelatedProject" CssClass="btn btn-success btn-xs" CausesValidation="false" OnClick="btnAddRelatedProject_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ItemType="VALE.Models.Project" DataKeyNames="ProjectId" AllowPaging="true" PageSize="10" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                                SelectMethod="GetRelatedProjectList" runat="server" OnDataBound="grdRelatedProject_DataBound" ID="grdRelatedProject" CssClass="table table-striped table-bordered" OnRowCommand="grdRelatedProject_RowCommand">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" ID="labelProjectName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>">
                                                                    <asp:Label runat="server" Text="<%#: Item.ProjectName %>"></asp:Label></a></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label ID="lblDescription" runat="server"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" ID="labelCreationDate"><span  class="glyphicon glyphicon-calendar"></span> Data Creazione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="150px" />
                                                                        <ItemStyle Width="150px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server" ID="labelType"><span  class="glyphicon glyphicon-th"></span> Tipo</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Type.Length >= 20 ? Item.Type.Substring(0,20) + "..." : Item.Type %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Status %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Azione" HeaderStyle-Width="50px" ItemStyle-Width="50px" Visible="false">
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Button  runat="server" ID="deleteRelatedProject" Text="Cancella"  CssClass="btn btn-danger btn-xs" CommandArgument="<%# Item.ProjectId %>" CommandName="Cancella" CausesValidation="false"  /></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                                        <ItemStyle Width="50px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <EmptyDataTemplate>
                                                                    <asp:Label runat="server">Nessun Progetto correlato </asp:Label>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  <%--Progetti correlati--%>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-list"></span>&nbsp;&nbsp;Attività correlate</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button Text="" CausesValidation="false" ID="btnAddActivity" runat="server" OnClick="btnAddActivity_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ItemType="VALE.Models.Activity" AllowPaging="true" PageSize="10" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                                SelectMethod="GetRelatedActivities" runat="server" DataKeyNames="ActivityId" ID="ActivitiesGridView" CssClass="table table-striped table-bordered">
                                                                <Columns>
                                                                    
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelActivityName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><a href="/MyVale/ActivityDetails?activityId=<%#:Item.ActivityId%>&From=/MyVale/ProjectDetails?projectId=<%#:Item.RelatedProject.ProjectId%>"><asp:Label runat="server"><%#: Item.ActivityName %></asp:Label></a></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server" ID="lblContentActivity"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Status" CommandName="sort" runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: GetStatus(Item) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="CreatorUserName" CommandName="sort" runat="server" ID="labelCreatorUserName"><span  class="glyphicon glyphicon-user"></span> Gestore</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.CreatorUserName %>"><asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label></a></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <EmptyDataTemplate>
                                                                    <asp:Label runat="server">Nessuna attività correlata.</asp:Label>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </div>
                                                        <div class="panel-footer">
                                                            <ul class="nav nav-pills">
                                                                <li>
                                                                    <span runat="server" class="badge">
                                                                        <asp:Label runat="server" ID="lblHoursWorked" CssClass="control-label"><%#: GetHoursWorked() %></asp:Label>
                                                                    </span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  <%--Attività correlate--%>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-flash"></span>&nbsp;&nbsp;Eventi correlati</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button CausesValidation="false" Text="" ID="btnAddEvent" runat="server" OnClick="btnAddEvent_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ItemType="VALE.Models.Event" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                                SelectMethod="GetRelatedEvents" AllowPaging="true" PageSize="10" DataKeyNames="EventId" runat="server" ID="GridView1" CssClass="table table-striped table-bordered">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Name" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Name %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server" ID="lblContentEvent"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="EventDate" CommandName="sort" runat="server" ID="labelEventDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <EmptyDataTemplate>
                                                                    <asp:Label runat="server">Nessun evento correlato</asp:Label>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>  <%--Eventi correlati--%>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>   <%--ProjectTreeView--%>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Conversazioni</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button CausesValidation="false" CssClass="btn btn-success btn-xs" runat="server" ID="btnAddIntervention" OnClick="btnAddIntervention_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView OnRowCommand="grdInterventions_RowCommand" AllowPaging="true" PageSize="10" OnRowCreated="grdInterventions_RowCreated" DataKeyNames="InterventionId" ItemType="VALE.Models.Intervention" GridLines="Both" AllowSorting="true"
                                                                SelectMethod="GetInterventions" runat="server" ID="grdInterventions" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="InterventionText" CommandName="sort" runat="server" ID="labelInterventionText"><span  class="glyphicon glyphicon-credit-card"></span> Intervento</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label ID="lblInterventionDescription" runat="server"><%#:GetDescription(Item.InterventionText) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="CreatorUserName" CommandName="sort" runat="server" ID="labelCreatorUserName"><span  class="glyphicon glyphicon-user"></span> Creatore</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.CreatorUserName %>"><asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label></a></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="AttachedFiles" CommandName="sort" runat="server" ID="labelDocumentsPath"><span  class="glyphicon glyphicon-paperclip"></span> Ha allegati</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: ContainsDocuments(Item.InterventionId) ? "SI" : "NO" %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:Label runat="server" ID="labelDetails"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Button CssClass="btn btn-info btn-xs" Width="90" runat="server" CommandName="ViewIntervention"
                                                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Visualizza" CausesValidation="false" /></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField Visible="false" HeaderText="DELETE ROW">
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:Label runat="server" ID="labelDelete"><span  class="glyphicon glyphicon-remove"></span> Cancella</asp:Label></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Button ID="btnDeleteIntervention" Visible="false" CssClass="btn btn-danger btn-xs" Width="90" runat="server" CommandName="DeleteIntervention"
                                                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Cancella" CausesValidation="false" /></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <EmptyDataTemplate>
                                                                    <asp:Label runat="server">Non ci sono conversazioni</asp:Label>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>   <%--Conversazioni--%>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button runat="server" CausesValidation="false" Text="Aggiungi Documento" CssClass="btn btn-success btn-xs" ID="btnAddDocument" OnClick="btnAddDocument_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                                ItemType="VALE.MyVale.AttachedFileGridView" AllowPaging="true" PageSize="10" EmptyDataText="Non ci sono file allegati."
                                                                CssClass="table table-striped table-bordered" AllowSorting="true"
                                                                OnRowCommand="grdFilesUploaded_RowCommand">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                         <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileName"><span  class="glyphicon glyphicon-file"></span> Nome File</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:LinkButton ToolTip="<%# Item.FileName %>"  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD_FILE" CausesValidation="false"><%#: Item.FileName.Length < 20 ? Item.FileName : Item.FileName.Substring(0, 18) + "..." %></asp:LinkButton></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="25%"></HeaderStyle>
                                                                        <ItemStyle Width="25%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                         <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileExtension"><span  class="glyphicon glyphicon-tag"></span> Tipo</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><%#: Item.FileExtension %></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="70px"></HeaderStyle>
                                                                        <ItemStyle Width="70px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                         <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileDescription"><span class="glyphicon glyphicon-list"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server" ToolTip="<%#: Item.FileDescription%>"><%#: Item.FileDescription.Length < 20 ? Item.FileDescription : Item.FileDescription.Substring(0, 18) + "..." %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                         <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="Owner"><span  class="glyphicon glyphicon-user"></span> Autore</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.Owner %>"><asp:Label runat="server"><%#: Item.Owner %></asp:Label></a></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="15%"></HeaderStyle>
                                                                        <ItemStyle Width="15%"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                         <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="VersionCount"><span class="glyphicon glyphicon-list-alt"></span> Versioni</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.FileName %>" CommandName="SHOW_VERSIONS" CausesValidation="false"><span runat="server" class="badge"><%#: Item.VersionCount %></span></asp:LinkButton></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="100px"></HeaderStyle>
                                                                        <ItemStyle Width="100px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="CreationDate"><span  class="glyphicon glyphicon-th"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                                        <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <div>
                                                                                    <asp:LinkButton ID="btnDownloadFile" ToolTip="Scarica il file" runat="server" CausesValidation="false" CommandName="DOWNLOAD_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-success"><span class="glyphicon glyphicon-save"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnShowDiscription" ToolTip="Visualiza informazione del file" runat="server" CausesValidation="false" CommandName="SHOW_DESC" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-primary"><span class="glyphicon glyphicon-info-sign"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnUpdateFile" ToolTip="Aggiorna il file" runat="server" CausesValidation="false" CommandName="UPDATE_FILE" CommandArgument="<%# Item.FileName %>"><span class="label label-default"><span class="glyphicon glyphicon-refresh"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnShowVersions" ToolTip="Visualiza i versioni del file" runat="server" CausesValidation="false" CommandName="SHOW_VERSIONS" CommandArgument="<%# Item.FileName %>"><span class="label label-info"><span class="glyphicon glyphicon-list-alt"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="btnDeleteFile" ToolTip="Cancella il file" runat="server" Visible='<%# AllowUpdateOrDelete(Convert.ToInt32(Eval("AttachedFileID"))) %>' CausesValidation="false" CommandName="DELETE_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                                                                </div>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" ><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="155px"></HeaderStyle>
                                                                        <ItemStyle Width="155px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                            </asp:GridView>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>   <%--Documenti Allegati--%>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Collaboratori</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button id="btnAddUsers" Visible="false" CausesValidation="false" runat="server" OnClick="addUsers_Click" CssClass="btn btn-info btn-xs" Text="Gestione utenti" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                SelectMethod="GetRelatedUsers" runat="server" ID="lstUsers" AllowPaging="true" PageSize="10" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.UserName %>"><asp:Label runat="server"><%#: Item.FullName %></asp:Label></a></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings Position="Bottom" />
                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessun collaboratore</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>   <%--Collaboratori--%>                              
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                           
                                            

                                            <asp:ModalPopupExtender ID="ModalPopup" runat="server"
                                                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
                                            </asp:ModalPopupExtender>
                                            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                                            <div class="alert alert-dismissable alert-info" id="pnlPopup" style="width: 25%;">
                                                <fieldset>
                                                    <div class="row">
                                                        <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Inserisci Password</strong></asp:Label>
                                                        <div class="col-md-12">
                                                            <br />
                                                        </div>
                                                        <div class="col-md-12">
                                                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                                                        </div>

                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-12">
                                                                <br />
                                                            </div>
                                                            <div class="col-md-offset-7 col-md-10">
                                                                <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnFilterProjects" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="btnModifyStatusProject_Click" />
                                                                <asp:Button runat="server" Text="Annulla" ID="btnClearFilters" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="CloseButton_Click" />
                                                            </div>

                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>   <%--ManagProject--%>
                                </ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupProject" runat="server"
                PopupControlID="pnlPopupProject" TargetControlID="lnkDummyProject" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyProject" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupProject" style="width: 80%;">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Modifica Progetto</legend>
                            <div class="form-group">
                                <label class="col-md-2 control-label">Nome *</label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtName" />
                                    <asp:RequiredFieldValidator ValidationGroup="ModifyProject" runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il campo Nome progetto è obbligatorio." />
                                </div>
                            </div>
                           <div class="form-group">
                                <Label class="col-md-2 control-label">Data di inizio *</Label>
                                <div class="col-md-10"">
                                    <asp:TextBox runat="server" Width="280px" ID="txtStartDate" CssClass="form-control"  />
                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                     <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="Il campo Data di inizio è obbligatorio." /><br />
                                    <asp:RegularExpressionValidator runat="server" ValidationExpression="\d{1,2}/\d{1,2}/\d{4}" CssClass="text-danger" ErrorMessage="Il formato della data non è corretto." ControlToValidate="txtStartDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Budget</asp:Label>
                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Giorni</asp:Label>
                            <div class="col-md-2">
                                <asp:TextBox ID="TextDay" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                                <asp:RegularExpressionValidator ControlToValidate="TextDay" runat="server" ErrorMessage="Giorni > 0"
                                    CssClass="text-danger" ValidationExpression="^\d*$" Display="Dynamic" ValidationGroup="ModifyProject"></asp:RegularExpressionValidator> 
                            </div>
                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Ore</asp:Label>
                            <div class="col-md-2">
                                <asp:TextBox ID="txtHour" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                                <asp:RegularExpressionValidator ControlToValidate="txtHour" runat="server" ErrorMessage="Ore tra 0..7" ValidationGroup="ModifyProject"
                                    CssClass="text-danger" ValidationExpression="[0-7]" Display="Dynamic"></asp:RegularExpressionValidator> 
                            </div>
                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Min</asp:Label>
                            <div class="col-md-2">
                                <asp:TextBox ID="txtMin" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox> 
                                <asp:RegularExpressionValidator ControlToValidate="txtMin" runat="server" ErrorMessage="Minuti tra 0..59" ValidationGroup="ModifyProject"
                                    CssClass="text-danger" ValidationExpression="[0-5]?[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                                <br />
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Progetto pubblico?</label>
                                        <div class="col-md-10">
                                            <asp:CheckBox runat="server" ID="chkPublic" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <br />
                                <label class="col-md-2 control-label">Descrizione</label>
                                <div class="col-md-10">
                                    <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtDescription" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ValidationGroup="ModifyProject" ErrorMessage="Il campo Descrizione è obbligatorio." />
                                    <%--<asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtDescription">
                                        <Toolbar>
                                            <ajaxToolkit:Undo />
                                            <ajaxToolkit:Redo />
                                            <ajaxToolkit:Bold />
                                            <ajaxToolkit:Italic />
                                            <ajaxToolkit:Underline />
                                            <ajaxToolkit:StrikeThrough />
                                            <ajaxToolkit:Subscript />
                                            <ajaxToolkit:Superscript />
                                            <ajaxToolkit:InsertOrderedList />
                                            <ajaxToolkit:InsertUnorderedList />
                                            <ajaxToolkit:CreateLink />
                                            <ajaxToolkit:Cut />
                                            <ajaxToolkit:Copy />
                                            <ajaxToolkit:Paste />
                                        </Toolbar>
                                    </asp:HtmlEditorExtender>--%>
                                    
                            </div>
                            <div class="form-group">
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Tipo Progetto</asp:Label>
                                    <div class="col-md-10">
                                        <asp:DropDownList CssClass="form-control" runat="server"  ID="ddlSelectType" SelectMethod="GetTypes" Width="300px" ItemType="VALE.Models.ProjectType" DataTextField="ProjectTypeName" DataValueField="ProjectTypeName"></asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ValidationGroup="ModifyProject" ControlToValidate="ddlSelectType" CssClass="text-danger" ErrorMessage="" />
                                    </div>
                                </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <br />
                            </div>
                            <div class="col-md-offset-10 col-md-12">
                                <asp:Button runat="server" Text="Salva" ID="btnConfirmModify" CssClass="btn btn-success btn-sm" ValidationGroup="ModifyProject" CausesValidation="true" OnClick="btnConfirmModify_Click" />
                                <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnClosePopUpButton_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel> <%--ModalPopupModifyProject--%> 
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupListProject" runat="server"
                PopupControlID="pnlListProject" TargetControlID="lnkDummy1" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummy1" runat="server"></asp:LinkButton>
            <div class="panel panel-primary" id="pnlListProject" style="width: 80%;">
                <div class="panel-heading">
                    <asp:Label ID="TitleMpdalView" runat="server" Text="Lista progetti"></asp:Label>
                    <asp:Button runat="server" CssClass="close" CausesValidation="false" OnClick="Unnamed_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 500px; overflow: auto;">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <asp:GridView SelectMethod="GetProjectsList" AllowPaging="true" PageSize="10" ID="OpenedProjectList" DataKeyNames="ProjectId" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                ItemType="VALE.Models.Project" EmptyDataText="Nessun progetto aperto." CssClass="table table-striped table-bordered">
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
                                            <center><div><asp:Label ID="lblOpenedProjects" runat="server"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
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
                                            <center><div><asp:Label runat="server" ID="labelAdd"><span  class="glyphicon glyphicon-saved"></span> Aggiungi</asp:Label></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Button runat="server" CausesValidation="false" Width="120" CommandArgument="<%#: Item.ProjectId %>" Text="Aggiungi" CssClass="btn btn-info btn-xs" ID="btnChooseProject" OnClick="btnChooseProject_Click" /></div></center>
                                        </ItemTemplate>
                                        <HeaderStyle Width="120" />
                                        <ItemStyle Width="120" />
                                    </asp:TemplateField>
                                </Columns>
                                <PagerSettings Position="Bottom" />
                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel> <%--ModalPopupListProject--%>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupAddDocument" runat="server"
                PopupControlID="pnlPopupAddDocument" TargetControlID="lnkDummyPopupAddDocument" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupAddDocument" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupAddDocument" style="width: 60%;">
                <asp:Label runat="server" ID="lblOperatioPopupAddDocument" visible="false" />
                <div class="row">
                    <div class="col-md-12">
                        <legend><asp:Label runat="server" ID="lblInfoPopupAddDocument"/></legend>
                    </div>
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server"></asp:ValidationSummary>
                    </div>
                    <div  runat="server" id="divDocunetPopupAddDocument">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Documento </label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblFileNamePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Versione </label>
                                <div class="col-md-10">
                                    <asp:Label ID="lblVersionPopupAddDocument" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                    <div  runat="server" id="divInfoPopupAddDocument">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Dimensione </label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblSizeFilePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Data</label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblDatePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Data</label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblHourPopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" runat="server" id="divFileUploderPopupAddDocument">
                        <label class="col-md-2 control-label">File *</label>
                        <div class="col-md-10">
                            <asp:FileUpload ID="FileUploadAddDocument" runat="server" CssClass="well well-sm"></asp:FileUpload>
                            <asp:Label ID="LabelPopUpAddDocumentError" CssClass="text-danger" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="col-md-2 control-label">Descrizione *</label>
                        <div class="col-md-10">
                            <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtFileDescription" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFileDescription" ID="validatorFileDescription" CssClass="text-danger" ValidationGroup="AddDocumentPopUp" ErrorMessage="Il campo Descrizione è obbligatorio." />
                        </div>
                    </div>
        
                    <div class="col-md-12">
                        <br />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpAddDocument" CssClass="btn btn-success btn-sm" ValidationGroup="AddDocumentPopUp" OnClick="btnPopUpAddDocument_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpAddDocumentClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpAddDocumentClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnPopUpAddDocument" />
        </Triggers>
    </asp:UpdatePanel> <%--ModalPopupAddDocument--%>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupViewFileVersions" runat="server"
                PopupControlID="pnlPopupViewFileVersions" TargetControlID="lnkDummyPopupViewFileVersions" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupViewFileVersions" runat="server"></asp:LinkButton>
            <div class="panel panel-default" id="pnlPopupViewFileVersions" style="width: 80%;">
                <div class="panel-heading">
                    <asp:LinkButton ID="btnClosePopupViewFileVersions" CausesValidation="false" runat="server" class="close" OnClick="btnClosePopupViewFileVersions_Click">×</asp:LinkButton>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-8">
                                <ul class="nav nav-pills">
                                    <li>
                                        <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Versioni de file : <asp:Label runat="server" ID="lblFileNamePopupViewFileVersions" /></li>
                                </ul>
                            </div>
                            <div class="navbar-right">
                                <%-- <asp:Button runat="server" CausesValidation="false" Text="Aggiungi Documento" CssClass="btn btn-success btn-xs"  />--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                    <asp:GridView ID="ViewFileVersionsGridView" runat="server" AutoGenerateColumns="False"
                        ItemType="VALE.Models.AttachedFile" EmptyDataText="Non ci sono file allegati."
                        CssClass="table table-striped table-bordered"
                        OnRowCommand="ViewFileVersionsGridView_RowCommand">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-barcode"></span> Versione</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD" CausesValidation="false"><span runat="server" class="badge"><%#: Item.Version %></span></asp:LinkButton></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle Width="100px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-tag"></span> Tipo</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><%#: Item.FileExtension %></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                                <ItemStyle Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span class="glyphicon glyphicon-list"></span> Descrizione</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><asp:Label runat="server" ToolTip="<%#: Item.FileDescription%>"><%#: Item.FileDescription.Length < 20 ? Item.FileDescription : Item.FileDescription.Substring(0, 18) + "..." %></asp:Label></div></center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-user"></span> Autore</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><a href="/Account/Profile?Username=<%#: Item.Owner %>"><asp:Label runat="server"><%#: Item.Owner %></asp:Label></a></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="20%"></HeaderStyle>
                                <ItemStyle Width="20%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-th"></span> Data</div></center>
                                </HeaderTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                                <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <center>
                                        <div>
                                            <asp:LinkButton ID="btnDownloadClick" runat="server" CausesValidation="false" CommandName="DOWNLOAD_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-success"><span class="glyphicon glyphicon-save"></span></span></asp:LinkButton>
                                            <asp:LinkButton ID="btnShowDiscClick" runat="server" CausesValidation="false" CommandName="SHOW_DESC" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-primary"><span class="glyphicon glyphicon-info-sign"></span></span></asp:LinkButton>
                                            <asp:LinkButton ID="btnDeleteClick" runat="server" Visible='<%# AllowUpdateOrDelete(Convert.ToInt32(Eval("AttachedFileID"))) %>' CausesValidation="false" CommandName="DELETE_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                        </div>
                                    </center>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-cog"></span> Azioni</div></center>
                                </HeaderTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                                <ItemStyle Width="115px"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>

                    </asp:GridView>

                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel> <%--ModalPopupViewFileVersions--%>
</asp:Content>
