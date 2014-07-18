<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Activities" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Activities.aspx.cs" Inherits="VALE.MyVale.Activities" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Tutte"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">
                                        <asp:Button runat="server" Text="Esporta CSV"  CssClass="btn btn-info" ID="btnExportCSV" OnClick="btnExportCSV_Click" />
                                        <asp:Label ID="ListUsersType" Visible="true" runat="server" Text=""></asp:Label>
                                        <div class="btn-group">
                                            <asp:Label ID="ActivityListType" runat="server" Text="AllActivities" Visible="false"></asp:Label>
                                            <button type="button" visible="true" id="btnList" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Tutte <span class="caret"></span></button>
                                            <ul class="dropdown-menu">
                                                <li>
                                                    <asp:LinkButton CommandArgument="AllActivities" runat="server" OnClick="ChangeSelectedActivities_Click" CausesValidation="false"><span class="glyphicon glyphicon-hdd"></span> Tutte  </asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton CommandArgument="RequestActivities" runat="server" OnClick="ChangeSelectedActivities_Click" CausesValidation="false"><span class="glyphicon glyphicon-ok-sign"></span> Richieste</asp:LinkButton></li>
                                              <li>
                                                    <asp:LinkButton CommandArgument="ProjectActivities" runat="server" OnClick="ChangeSelectedActivities_Click" CausesValidation="false"><span class="glyphicon glyphicon-inbox"></span> Per Progetto</asp:LinkButton></li>
                                              <li>
                                                    <asp:LinkButton CommandArgument="NotRelatedActivities" runat="server" OnClick="ChangeSelectedActivities_Click" CausesValidation="false"><span class="glyphicon glyphicon-resize-full"></span> Non Correlate</asp:LinkButton></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:UpdatePanel runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="panel panel-default" runat="server" id="filters">
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
                                                    <div class="row">
                                                         <div  class="col-md-12"><br /></div>
                                                        <div  class="col-md-12">
                                                            <div class="col-md-6">
                                                                <asp:Label Font-Bold="true" CssClass="col-md-2 control-label" runat="server" Text="Stato"></asp:Label>
                                                                <asp:DropDownList SelectMethod="PopulateDropDown" Width="200" CssClass="col-md-10 form-control input-sm" ID="ddlStatus" runat="server"></asp:DropDownList>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label" Text="Tipo"></asp:Label>
                                                                <asp:DropDownList Width="250" CssClass=" col-md-10 col-md-offset-2 form-control input-sm" runat="server" ID="ddlSelectType" SelectMethod="GetTypes" ItemType="VALE.Models.ActivityType" DataTextField="ActivityTypeName" DataValueField="ActivityTypeName"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                     
                                                    </div>
                                                      
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                     <div class="row">
                                        <div class="col-lg-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="col-lg-10">
                                                                <ul class="nav nav-pills">
                                                                    <li>
                                                                        
                                                                            <asp:Label ID="ActivityListName" runat="server" Text="Attività"></asp:Label>
                                                                        
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                            <div class="navbar-right">
                                                                
                                                                <asp:Button runat="server" Text="Crea Attività"  CssClass="btn btn-success btn-xs" ID="btnAddActivity" OnClick="btnAddActivity_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="overflow: auto;">
                                                    <asp:GridView OnRowCommand="grdCurrentActivities_RowCommand" DataKeyNames="ActivityId"
                                                        ID="grdCurrentActivities" runat="server" AutoGenerateColumns="false"
                                                        ItemType="VALE.Models.Activity" AllowSorting="true" SelectMethod="GetActivities" EmptyDataText="Nessuna attività in corso."
                                                        CssClass="table table-striped table-bordered" AllowPaging="true" PageSize="10">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelActivityName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.ActivityName %></asp:Label></div></center>
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
                                                                    <center><div><asp:LinkButton runat="server" ID="labelDescription"  CommandArgument="Type" CommandName="sort"><span  class="glyphicon glyphicon-th"></span> Tipo</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.Type.Length >= 20 ? Item.Type.Substring(0,20) + "..." : Item.Type %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="90px" />
                                                                <ItemStyle Width="90px" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data di inizio</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita" %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="140px" />
                                                                <ItemStyle Width="140px" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="ExpireDate" CommandName="sort" runat="server" ID="labelExpireDate"><span  class="glyphicon glyphicon-calendar"></span> Data fine</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita" %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="140px" />
                                                                <ItemStyle Width="140px" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="Status" CommandName="sort" runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: GetStatus(Item) %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="150px" />
                                                                <ItemStyle Width="150px" />
                                                            </asp:TemplateField>

                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Button Width="90" CssClass="btn btn-info btn-xs" runat="server" CommandName="ViewDetails"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Visualizza" /></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="90px" />
                                                                <ItemStyle Width="90px" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerSettings Position="Bottom" />
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                    </asp:GridView>
                            <asp:GridView OnRowCommand="grdPendingActivities_RowCommand" DataKeyNames="ActivityId" ID="grdPendingActivities" runat="server" AutoGenerateColumns="false" GridLines="Both"
                                                        ItemType="VALE.Models.Activity" SelectMethod="GetPendingActivities" EmptyDataText="Nessuna attività in attesa." CssClass="table table-striped table-bordered">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelActivityName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.ActivityName %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="120px" />
                                                                <ItemStyle Width="120px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label ID="lblContentPendingActivity" runat="server"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="120px" />
                                                                <ItemStyle Width="120px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data di inizio</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita" %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15px" />
                                                                <ItemStyle Width="150px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="ExpireDate" CommandName="sort" runat="server" ID="labelExpireDate"><span  class="glyphicon glyphicon-calendar"></span> Data di  fine</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita" %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="150px" />
                                                                <ItemStyle Width="150px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:Label runat="server" ID="labelAccept"><span  class="glyphicon glyphicon-ok-circle"></span> Accetta</asp:Label></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Button CssClass="btn btn-success btn-xs" Width="120" runat="server" CommandName="AcceptActivity"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Accetta" /></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="120px" />
                                                                <ItemStyle Width="120px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:Label runat="server" ID="labelReject"><span  class="glyphicon glyphicon-remove-circle"></span> Rifiuta</asp:Label></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Button CssClass="btn btn-danger btn-xs" Width="120" runat="server" CommandName="RefuseActivity"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Rifiuta" /></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="120px" />
                                                                <ItemStyle Width="120px" />
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
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

            