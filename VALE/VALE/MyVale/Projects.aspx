<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Projects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="VALE.MyVale.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Progetti</h3>
    <p>
        <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
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
                </asp:Panel>

                <asp:GridView OnDataBound="OpenedProjectList_DataBound" ID="OpenedProjectList" DataKeyNames="ProjectId" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                    ItemType="VALE.Models.Project" EmptyDataText="Non sono presenti progetti aperti." CssClass="table table-striped table-bordered" OnSorting="OpenedProjectList_Sorting">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="ProjectName" CommandName="sort" runat="server" ID="labelProjectName"><span  class="glyphicon glyphicon-th"></span> Nome</asp:LinkButton></div></center>
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
                                <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="CreationDate" CommandName="sort" runat="server" ID="labelCreationDate"><span  class="glyphicon glyphicon-th"></span> Data Creazione</asp:LinkButton></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                            </ItemTemplate>
                            <HeaderStyle Width="140px" />
                            <ItemStyle Width="140px" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:LinkButton CommandArgument="LastModified" CommandName="sort" runat="server" ID="labelLastModified"><span  class="glyphicon glyphicon-th"></span> Ultima modifica</asp:LinkButton></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label></div></center>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                            <ItemStyle Width="150px" />
                        </asp:TemplateField>
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
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:Label runat="server" ID="labelAttend"><span  class="glyphicon glyphicon-th"></span> Partecipa</asp:Label></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Button runat="server" Width="150" Text="&nbsp;&nbsp;&nbsp;&nbsp;Partecipa&nbsp;&nbsp;&nbsp;&nbsp;" CssClass="btn btn-info btn-xs" ID="btnWorkOnThis"  OnClick="btnWorkOnThis_Click" /></div></center>
                            </ItemTemplate>
                            <HeaderStyle Width="100px" />
                            <ItemStyle Width="100px" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <center><div><asp:Label runat="server" ID="labelDetails"><span  class="glyphicon glyphicon-th"></span> Dettagli</asp:Label></div></center>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <center><div><asp:Button runat="server" Width="90" Text="Vedi" CssClass="btn btn-info btn-xs" ID="btnViewDetails" OnClick="btnViewDetails_Click" /></div></center>
                            </ItemTemplate>
                            <HeaderStyle Width="90px" />
                            <ItemStyle Width="90px" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </p>
</asp:Content>
