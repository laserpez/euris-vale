<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonalProjects.aspx.cs" Inherits="VALE.MyVale.PersonalProjects" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Progetti personali"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">

                                        <div class="btn-group">
                                            <button type="button" id="btnCurrentView" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Progetti <%--<span class="caret"></span>--%></button>
                                            <ul class="dropdown-menu">
                                                <li>
                                                    <asp:LinkButton ID="btnAttending" CommandArgument="Attending" runat="server" OnClick="btnViewProjects_Click">A cui sei registrato</asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton ID="btnCreated" CommandArgument="Created" runat="server" OnClick="btnViewProjects_Click">Creati da te</asp:LinkButton></li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                                <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
                                    <ContentTemplate>
                                      
                                        <asp:GridView OnRowCommand="grid_RowCommand" DataKeyNames="ProjectId" ID="grdProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                            ItemType="VALE.Models.Project" EmptyDataText="Nessun progetto pianificato." CssClass="table table-striped table-bordered" SelectMethod="GetPersonalProjects" AllowPaging="true" PageSize="10">
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
                                                    <HeaderStyle Width="140px" />
                                                    <ItemStyle Width="140px" />
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
                                                        <center><div><asp:Label runat="server" ID="labelView"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Button CssClass="btn btn-info btn-xs"  Width="90" runat="server" CommandName="ViewDetails"
                                                            CommandArgument="<%# Item.ProjectId %>" Text="Visualizza" />
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
