<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProjects.aspx.cs" Inherits="VALE.Admin.ManageProject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Gestione progetti</h3>
    <br />
    <br />
    <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <asp:Button runat="server" CssClass="btn btn-primary btn-xs" Text="Mostra filtri" ID="btnShowFilters" OnClick="btnShowFilters_Click" />
                </div>
                <div runat="server" id="filterPanel" class="panel-body">
                    <asp:Label AssociatedControlID="txtName" CssClass="col-md-2 control-label" runat="server" Text="Name"></asp:Label>
                    <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtName"></asp:TextBox>
                    <asp:Label AssociatedControlID="txtDescription" CssClass="col-md-2 control-label" runat="server" Text="Description"></asp:Label>
                    <asp:TextBox CssClass="form-control" runat="server" ID="txtDescription"></asp:TextBox>
                    <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Created"></asp:Label>
                    <asp:TextBox CssClass="col-md-2 form-control" runat="server" ID="txtCreationDate"></asp:TextBox>
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarCreationDate" TargetControlID="txtCreationDate"></asp:CalendarExtender>
                    <asp:Label CssClass="col-md-2 control-label" runat="server" Text="Modified"></asp:Label>
                    <asp:TextBox CssClass="form-control" runat="server" ID="txtLastModifiedDate"></asp:TextBox>
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarModifiedDate" TargetControlID="txtLastModifiedDate"></asp:CalendarExtender>
                    <asp:Button runat="server" Text="Search" ID="btnFilterProjects" OnClick="btnFilterProjects_Click" CssClass="btn btn-info" />
                    <asp:Button runat="server" Text="Clear filter" ID="btnClearFilters" OnClick="btnClearFilters_Click" CssClass="btn btn-danger" />
                </div>
            </div>

            <asp:GridView OnRowCommand="ProjectList_RowCommand" DataKeyNames="ProjectId" OnSorting="ProjectList_Sorting" AllowSorting="true" ID="ProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both"
                ItemType="VALE.Models.Project" EmptyDataText="Nessun progetto aperto." CssClass="table table-striped table-bordered">
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
                            <center><div><asp:Label runat="server" ID="labelDetails"><span  class="glyphicon glyphicon-th"></span> Vedi</asp:Label></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center><div><asp:Button runat="server" Width="150" Text="Vedi report" CssClass="btn btn-info btn-xs"
                                CommandName="ViewReport" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <center><div><asp:Label runat="server" ID="labelDelete"><span  class="glyphicon glyphicon-th"></span> Cancella</asp:Label></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center><div><asp:Button runat="server" Width="150" Text="Cancella progetto" CssClass="btn btn-danger btn-xs"
                                CommandName="DeleteProject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanelDelete" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <asp:ModalPopupExtender ID="ModalPopup" BehaviorID="mpe" runat="server"
                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <div class="panel panel-primary" id="pnlPopup" style="width: 60%;">
                <div class="panel-heading">
                    <asp:Label ID="TitleModalView" runat="server" Text="Cancella progetto"></asp:Label>
                    <asp:Button runat="server" CssClass="close" OnClick="CloseButton_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 220px">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <%--<legend>Cancella progetto</legend>--%>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Nome progetto</label>
                                <div class="col-lg-10 control-label" runat="server" id="Div1">
                                    <asp:Label runat="server" ID="ProjectName" Text="" />
                                    <asp:Label runat="server" ID="ProjectID" Text="" Visible="false"></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Password</label>
                                <div class="col-lg-10 control-label" runat="server" id="PasswordDiv">
                                    <asp:TextBox TextMode="Password" runat="server" CssClass="form-control" ID="PassTextBox" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <asp:Button runat="server" ID="DeleteButton" CssClass="btn btn-default navbar-btn" Text="Conferma" OnClick="DeleteButton_Click" />
                        <asp:Label runat="server" ID="ErrorDeleteLabel" Text="" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
