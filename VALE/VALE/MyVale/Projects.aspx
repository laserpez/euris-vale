<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="VALE.MyVale.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Progetti</h3>
    <p>
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Show filters" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                     </div>
                    <div runat="server" id="filterPanel" class="panel-body">
                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Nome"></asp:Label>
                        <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Descrizione"></asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtDescription"></asp:TextBox>
                        
                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Creato il"></asp:Label>
                        <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtCreationDate"></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtCreationDate"></asp:CalendarExtender>
                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Ultima modifica"></asp:Label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtLastModifiedDate"></asp:TextBox>
                        <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtLastModifiedDate"></asp:CalendarExtender>

                        <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Stato"></asp:Label>
                        <asp:DropDownList SelectMethod="PopulateDropDown" Width="200" CssClass="col-md-10 form-control" ID="ddlStatus" runat="server"></asp:DropDownList>
                        <br /><br /><br />
                        <asp:Button runat="server" Text="Cerca" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info" />
                        <asp:Button runat="server" Text="Pulisci filtri" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                    </div>
                </div>

                <asp:GridView OnDataBound="OpenedProjectList_DataBound" ID="OpenedProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                    ItemType="VALE.Models.Project" EmptyDataText="No open projects" CssClass="table table-striped table-bordered" OnSorting="OpenedProjectList_Sorting">
                    <Columns>
                        <asp:BoundField DataField="ProjectID" HeaderText="ID" SortExpression="ProjectId" />
                        <asp:BoundField DataField="ProjectName" HeaderText="Nome" SortExpression="ProjectName" />
                        <asp:BoundField DataField="Description" HeaderText="Descrizione" SortExpression="Description" />
                        <asp:TemplateField HeaderText="Creato il" SortExpression="CreationDate">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ultime modifica" SortExpression="LastModified">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Status" HeaderText="Stato" SortExpression="Status" />
                        <asp:TemplateField HeaderText="Partecipa">
                            <ItemTemplate>
                                <asp:Button runat="server" Text="Partecipa" CssClass="btn btn-info btn-sm" ID="btnWorkOnThis"  OnClick="btnWorkOnThis_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Dettagli">
                            <ItemTemplate>
                                <asp:Button runat="server" Text="Vedi" CssClass="btn btn-info btn-sm" ID="btnViewDetails" OnClick="btnViewDetails_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>
