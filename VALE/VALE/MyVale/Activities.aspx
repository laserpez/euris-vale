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
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
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
                            <p></p>
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

                                            <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Stato"></asp:Label>
                                            <asp:DropDownList SelectMethod="PopulateDropDown" Width="200" CssClass="col-md-10 form-control" ID="ddlStatus" runat="server"></asp:DropDownList>
                                            <br />
                                            <br />
                                            <br />
                                            <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info btn-xs" />
                                            <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger btn-xs" />
                                        </div>
                                    </asp:Panel>
                                    <h3>Attività in corso</h3>
                                    <asp:GridView OnRowCommand="grdCurrentActivities_RowCommand" DataKeyNames="ActivityId" ID="grdCurrentActivities" runat="server" AutoGenerateColumns="false" GridLines="Both"
                                        ItemType="VALE.Models.Activity" AllowSorting="true" SelectMethod="GetCurrentActivities" EmptyDataText="Nessuna attività in corso." CssClass="table table-striped table-bordered">
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
                                                    <center><div><asp:Label runat="server"><%#: Item.Description.Length >= 20 ? Item.Description.Substring(0,20) + "..." : Item.Description %></asp:Label></div></center>
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
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
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
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <p></p>
                            <h3>Attività in attesa</h3>
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
                                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
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
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
