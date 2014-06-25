<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Activities" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Activities.aspx.cs" Inherits="VALE.MyVale.Activities" %>
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
                                                            <asp:Label ID="HeaderName" runat="server" Text="To do"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">
                                    <asp:Button runat="server" Text="Esporta CSV" Width="90" CssClass="btn btn-info btn-xs" ID="btnExportCSV" OnClick="btnExportCSV_Click" />
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Panel ID="ExternalPanelDefault" runat="server" CssClass="panel panel-default">
                                                <asp:Panel ID="InternalPanelHeading" runat="server" CssClass="panel-heading">
                                                    <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Mostra filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                                                </asp:Panel>
                                                <div runat="server" id="filterPanel" class="panel-body">
                                                    <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                                                    <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                                                    <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Descrizione"></asp:Label>
                                                    <asp:TextBox CssClass="form-control" runat="server" ID="txtDescription"></asp:TextBox>

                                                    <%--<asp:Label CssClass="col-md-2 control-label" runat="server" Text="Creato il"></asp:Label>
                                                        <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtCreationDate"></asp:TextBox>
                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtCreationDate"></asp:CalendarExtender>
                                                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Ultima modifica"></asp:Label>
                                                        <asp:TextBox CssClass="form-control" runat="server" ID="txtLastModifiedDate"></asp:TextBox>
                                                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtLastModifiedDate"></asp:CalendarExtender>--%>

                                                    <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Stato"></asp:Label>
                                                    <asp:DropDownList SelectMethod="PopulateDropDown" Width="200" CssClass="col-md-10 form-control" ID="ddlStatus" runat="server"></asp:DropDownList>
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info" />
                                                    <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                                                </div>
                                            </asp:Panel>
                                            <h3>Attività in corso</h3>
                                            <asp:GridView OnRowCommand="grdCurrentActivities_RowCommand" DataKeyNames="ActivityId" ID="grdCurrentActivities" runat="server" AutoGenerateColumns="false" GridLines="Both"
                                                ItemType="VALE.Models.Activity" AllowSorting="true" SelectMethod="GetCurrentActivities" EmptyDataText="Nessuna attività in corso." CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <%--<asp:BoundField DataField="ActivityId" HeaderText="ID" SortExpression="ActivityId" />

                                                        <asp:TemplateField>
                                                            <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="ActivityId" CommandName="sort" runat="server" ID="labelActivityId">ID</asp:LinkButton></div></center>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <center><div><asp:Label runat="server"><%#: Item.ActivityId %></asp:Label></div></center>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="30px" />
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>--%>

                                                    <%--<asp:BoundField DataField="ActivityName" HeaderText="Nome" SortExpression="ActivityName" />--%>

                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelActivityName"><span  class="glyphicon glyphicon-th"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.ActivityName %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>

                                                    <%--<asp:BoundField DataField="Description" HeaderText="Descrizione" SortExpression="Description" />--%>

                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="120px" />
                                                        <ItemStyle Width="120px" />
                                                    </asp:TemplateField>

                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-th"></span> Data di inizio</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita" %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="140px" />
                                                        <ItemStyle Width="140px" />
                                                    </asp:TemplateField>

                                                    <%--<asp:TemplateField HeaderText="Data inizio" SortExpression="StartDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>

                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="ExpireDate" CommandName="sort" runat="server" ID="labelExpireDate"><span  class="glyphicon glyphicon-th"></span> Data fine</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita" %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="140px" />
                                                        <ItemStyle Width="140px" />
                                                    </asp:TemplateField>

                                                    <%--<asp:TemplateField HeaderText="Data fine" SortExpression="ExpireDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>

                                                    <%--<asp:BoundField DataField="Status" HeaderText="Stato" SortExpression="Status" />--%>

                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Status" CommandName="sort" runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-th"></span> Stato</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Status %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>

                                                    <%--<asp:TemplateField HeaderText="Dettagli">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-info" runat="server" CommandName="ViewDetails"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Vedi" />
                        </ItemTemplate>
                    </asp:TemplateField>--%>

                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-th"></span> Dettagli</asp:Label></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Button Width="90" CssClass="btn btn-info btn-xs" runat="server" CommandName="ViewDetails"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Vedi" /></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>

                                                </Columns>
                                            </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <p></p>
                                    <h3>Attività in attesa</h3>
                                    <asp:GridView OnRowCommand="grdPendingActivities_RowCommand" ID="grdPendingActivities" runat="server" AutoGenerateColumns="false" ShowFooter="true" GridLines="Both"
                                        ItemType="VALE.Models.Activity" SelectMethod="GetPendingActivities" EmptyDataText="Nessuna attività in attesa." CssClass="table table-striped table-bordered">
                                        <Columns>
                                            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                            <asp:BoundField DataField="ActivityName" HeaderText="Nome" />
                                            <asp:BoundField DataField="Description" HeaderText="Descrizione" />
                                            <asp:TemplateField HeaderText="Data inizio">
                                                <ItemTemplate>
                                                    <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita" %></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Data fine">
                                                <ItemTemplate>
                                                    <asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita" %></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Accetta">
                                                <ItemTemplate>
                                                    <asp:Button CssClass="btn btn-success" runat="server" CommandName="AcceptActivity"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Accept" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Rifiuta">
                                                <ItemTemplate>
                                                    <asp:Button CssClass="btn btn-danger" runat="server" CommandName="RefuseActivity"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Refuse" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
