<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectReport.aspx.cs" Inherits="VALE.Admin.ProjectReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
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
                                            <asp:Label runat="server"><%#: String.Format("Descrizione:\t{0}", Item.Description) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Creatore:\t{0}", Item.Organizer.FullName) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Data:\t{0}", Item.CreationDate.ToShortDateString()) %></asp:Label><br />
                                            <asp:Label runat="server"><%#: String.Format("Ultima modifica:\t{0}", Item.LastModified.ToShortDateString()) %></asp:Label><br />

                                            <h4>Interventi</h4>
                                            <asp:GridView OnRowCommand="grid_RowCommand" runat="server" ID="grdUsersInterventions" CssClass="table table-striped table-bordered" EmptyDataText="Nessun intervento">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button CausesValidation="false" CssClass="btn btn-info btn-xs" runat="server" CommandName="ViewUserInterventions"
                                                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Vedi dettagli" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
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
                                                    <asp:GridView OnRowCommand="grid_RowCommand" runat="server" EmptyDataText="Nessun report" ID="grdActivitiesReport" CssClass="table table-striped table-bordered">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button CausesValidation="false" CssClass="btn btn-info btn-xs" runat="server" CommandName="ViewActivityReport"
                                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Vedi dettagli" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </ItemTemplate>
                                    </asp:FormView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
