<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageEvents.aspx.cs" Inherits="VALE.Admin.ManageEvents" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="ProjectGrid" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView OnRowCommand="grdEventList_RowCommand" ID="grdEventList" SelectMethod="GetEvents" runat="server" AutoGenerateColumns="false" GridLines="Both"
                ItemType="VALE.Models.Event" EmptyDataText="No open projects" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="EventId" HeaderText="ID" SortExpression="EventId" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                    <asp:TemplateField HeaderText="Created" SortExpression="EventDate">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Creator" SortExpression="OrganizerId">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.OrganizerUserName %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="View report" CssClass="btn btn-info btn-sm"
                                CommandName="ViewReport" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:Button runat="server" Text="Delete event" CssClass="btn btn-danger btn-sm"
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
                            <legend>Remove Event</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Event name</label>
                                <div class="col-lg-10 control-label" runat="server" id="Div1">
                                    <asp:Label runat="server" ID="EventName" Text="" />
                                    <asp:Label runat="server" ID="EventID" Text="" Visible="false"></asp:Label>
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
