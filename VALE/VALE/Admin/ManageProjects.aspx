<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProjects.aspx.cs" Inherits="VALE.Admin.ManageProject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
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

            <asp:GridView OnRowCommand="ProjectList_RowCommand" ID="ProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" 
                ItemType="VALE.Models.Project" EmptyDataText="Nessun progetto aperto." CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="ProjectID" HeaderText="ID" SortExpression="ProjectId" />
                    <asp:BoundField DataField="ProjectName" HeaderText="Name" SortExpression="ProjectName" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Created" SortExpression="CreationDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last modified" SortExpression="LastModified">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="View report" CssClass="btn btn-info btn-sm"
                                CommandName="ViewReport" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Delete project" CssClass="btn btn-danger btn-sm"
                                CommandName="DeleteProject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
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
                    <asp:Label ID="TitleModalView" runat="server" Text="DeletePanel"></asp:Label>
                    <asp:Button runat="server" class="close" OnClick="CloseButton_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 300px; overflow: auto;">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Remove Project</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Project name</label>
                                <div class="col-lg-10 control-label" runat="server" id="Div1">
                                    <asp:Label runat="server" ID="ProjectName" Text="" />
                                    <asp:Label runat="server" ID="ProjectID" Text="" Visible="false"></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Password</label>
                                <div class="col-lg-10 control-label" runat="server" id="PasswordDiv">
                                    <asp:TextBox TextMode="Password" runat="server" class="form-control" ID="PassTextBox" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <asp:Button runat="server" ID="DeleteButton" class="btn btn-default navbar-btn" Text="Confirm" OnClick="DeleteButton_Click" />
                    <asp:Label  runat="server" ID="ErrorDeleteLabel" Text="" Visible="false" ></asp:Label>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
