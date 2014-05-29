<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="VALE.Admin.ManageUsers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <ul class="nav nav-tabs" style="margin-bottom: 15px;">
        <li class="active"><a href="#approve" data-toggle="tab">Approvals</a></li>
        <li class=""><a href="#manage" data-toggle="tab">Manage users</a></li>
    </ul>

    <div id="myTabContent" class="tab-content">
        <div class="tab-pane fade active in" id="approve">
            <br />
            <h3>Associated users waiting for approval</h3>
            <br />
            <br />
            <asp:UpdatePanel ID="UpdatePanelApproval" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="grdWaitingUsers" runat="server" AutoGenerateColumns="false" ShowFooter="true" SelectMethod="GetWaitingUsers" GridLines="Both"
                        ItemType="VALE.Models.ApplicationUser" EmptyDataText="No waiting users" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="Id" HeaderText="ID" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="FirstName" HeaderText="First name" />
                            <asp:BoundField DataField="LastName" HeaderText="Last name" />
                            <asp:BoundField DataField="CF" HeaderText="Fiscal code" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkSelectUser" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:Button ID="btnConfirmUser" runat="server" Text="Confirm selected user(s)" CssClass="btn btn-primary" OnClick="btnConfimUser_Click" />
        </div>

        <div class="tab-pane fade" id="manage">
            <br />
            <h3>Manage users</h3>
            <br />
            <br />
            <asp:UpdatePanel ID="UpdatePanelUserManager" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" ShowFooter="true" SelectMethod="GetUsers" GridLines="Both"
                        ItemType="VALE.Models.ApplicationUser" EmptyDataText="No waiting users" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="UserName" HeaderText="UserName" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="FirstName" HeaderText="First name" />
                            <asp:BoundField DataField="LastName" HeaderText="Last name" />
                            <asp:BoundField DataField="CF" HeaderText="Fiscal code" />
                            <asp:TemplateField HeaderText="Current role">
                                <ItemTemplate>
                                    <%# GetRoleName(Item.Id) %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="btn-group">
                                        <button type="button" id="AllListRoles" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Change Role<span class="caret"></span></button>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <asp:LinkButton ID="btnAdministrator" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click">Administrator</asp:LinkButton></li>
                                            <li>
                                                <asp:LinkButton ID="btnBoard" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click">BoardMember</asp:LinkButton></li>
                                            <li>
                                                <asp:LinkButton ID="btnAssociated" CommandArgument='<%#: Item.UserName %>' runat="server" OnClick="btnChangeUser_Click">AssociatedUser</asp:LinkButton></li>
                                        </ul>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
            <asp:Label ID="lblChangeRole" runat="server" Visible="false" Text="" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
