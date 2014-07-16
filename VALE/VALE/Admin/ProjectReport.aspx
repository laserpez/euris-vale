<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectReport.aspx.cs" Inherits="VALE.Admin.ProjectReport" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Report progetto"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:FormView OnDataBound="frmProjectReport_DataBound" SelectMethod="GetProject" runat="server" ItemType="VALE.Models.Project" ID="frmProjectReport">
                                <ItemTemplate>
                                    <asp:Label runat="server"><%#: String.Format("Nome: {0}", Item.ProjectName) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Pubblico:\t{0}", Item.Public ? "Si" : "No") %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Stato:\t{0}", Item.Status.ToUpperInvariant()) %></asp:Label><br />
                                    <asp:Label ID="lblContent" runat="server"></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Creatore:\t{0}", Item.Organizer.FullName) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Data:\t{0}", Item.CreationDate.ToShortDateString()) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Ultima modifica:\t{0}", Item.LastModified.ToShortDateString()) %></asp:Label><br />

                                    <h4>Interventi</h4>
                                    <asp:GridView ID="grdUsersInterventions" AllowPaging="true" PageSize="10" OnPageIndexChanging="grd_PageIndexChanging" AutoGenerateColumns="false" OnRowCommand="grid_RowCommand" runat="server" ItemType="VALE.Admin.InterventionReports" CssClass="table table-striped table-bordered" EmptyDataText="Nessun intervento">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <center><div><asp:Button Width="120" CausesValidation="false" CssClass="btn btn-info btn-xs" runat="server" CommandName="ViewUserInterventions" CommandArgument="<%# Item.Email %>"
                                                                         Text="Vedi dettagli" /></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="Username" CommandName="sort" runat="server" ID="labelUsername"><span  class="glyphicon glyphicon-th"></span> Nome</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%# Item.Username %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:LinkButton CommandArgument="InterventionsCount" CommandName="sort" runat="server" ID="labelInterventionsCount"><span  class="glyphicon glyphicon-th"></span> Numero interventi</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%# Item.InterventionsCount %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerTemplate>
                                            <asp:GridPager runat="server"
                                                ShowFirstAndLast="true" ShowNextAndPrevious="true" PageLinksToShow="10"
                                                NextText=">" PreviousText="<" FirstText="Prima" LastText="Ultima" />
                                        </PagerTemplate>
                                    </asp:GridView>
                                    <h4>Report attività</h4>
                                    <asp:Label runat="server" ID="emptyAtcivitiesLabel" CssClass="form-control" Visible="false"></asp:Label>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList CssClass="form-control" runat="server" ID="ddlSelectActivity" SelectMethod="GetActivities" DataTextField="ActivityName" DataValueField="ActivityId">
                                            </asp:DropDownList>
                                            <br />
                                            <asp:Button runat="server" ID="btnShowActivityReport" OnClick="btnShowActivityReport_Click" CssClass="btn btn-info btn-xs" Text="Visualizza report" />
                                            <br />
                                            <br />
                                            <asp:GridView AutoGenerateColumns="false" OnRowCommand="grid_RowCommand" AllowPaging="true" PageSize="10" OnPageIndexChanging="grd_PageIndexChanging" runat="server" EmptyDataText="Nessun report" ItemType="VALE.Admin.UserActivityReport" ID="grdActivitiesReport" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center><div><asp:Button Width="120" CausesValidation="false" CssClass="btn btn-info btn-xs" runat="server" CommandName="ViewActivityReport"
                                                                        CommandArgument="<%# Item.Email %>" Text="Vedi dettagli" /></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="120px" />
                                                        <ItemStyle Width="120px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Username" CommandName="sort" runat="server" ID="labelUsername"><span  class="glyphicon glyphicon-th"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Username %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="HoursWorked" CommandName="sort" runat="server" ID="labelHoursWorked"><span  class="glyphicon glyphicon-th"></span> Ore lavorate</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.HoursWorked %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerTemplate>
                                                    <asp:GridPager runat="server"
                                                        ShowFirstAndLast="true" ShowNextAndPrevious="true" PageLinksToShow="10"
                                                        NextText=">" PreviousText="<" FirstText="Prima" LastText="Ultima" />
                                                </PagerTemplate>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
