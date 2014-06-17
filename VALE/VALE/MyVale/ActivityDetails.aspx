<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityDetails.aspx.cs" Inherits="VALE.MyVale.ActivityDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView runat="server" ID="ActivityDetail" ItemType="VALE.Models.Activity" SelectMethod="GetActivity">
        <ItemTemplate>
            <h3><%#: Item.ActivityName.ToUpper() %></h3>
            <h4>Activity details</h4>
            <asp:Label runat="server" CssClass="conrol-label"><%#: String.Format("Created by: {0}", Item.Creator.FullName) %></asp:Label>
            <br />
            <asp:Label runat="server" CssClass="control-label"><%#: String.Format("From: {0} - To: {1}", Item.StartDate.Value.ToShortDateString(), Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "No expire date") %></asp:Label>
            <br />
            
            <asp:Label runat="server"><%#: String.Format("Description: {0}", Item.Description) %></asp:Label><br />

            <h4>Status</h4>
            <asp:Label runat="server" CssClass="control-label"><%#: String.Format("Current: {0}", Item.Status) %></asp:Label>
            <br />
            <%--<div class="btn-group">
                    <asp:Label runat="server" Text="This activity is deleted. You cannot change its status" Visible="false" ID="lblInfoChangeStatus" ></asp:Label>
                    <button type="button" id="btnChangeStatus" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" runat="server">Change status<span class="caret"></span></button>
                    <ul class="dropdown-menu">
                        <li><asp:LinkButton Visible="false" ID="btnOngoing" CommandArgument="Ongoing" runat="server" OnClick="btnChangeStatus_Click">Ongoing</asp:LinkButton></li>
                        <li><asp:LinkButton Visible="false" ID="btnSuspended" CommandArgument="Suspended" runat="server" OnClick="btnChangeStatus_Click">Suspended</asp:LinkButton></li>
                        <li><asp:LinkButton Visible="true" ID="btnDeleted" CommandArgument="Deleted" runat="server" OnClick="btnChangeStatus_Click">Deleted</asp:LinkButton></li>
                    </ul>
                </div>--%>
            <h4>Involved users</h4>
            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                        SelectMethod="GetUsersInvolved" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        </Columns>
                        <EmptyDataTemplate>
                            <asp:Label runat="server">No users inolved</asp:Label>
                        </EmptyDataTemplate>
                    </asp:GridView>

            <h4>Work on this activity</h4>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Label runat="server" ID="lblHoursWorked" CssClass="control-label"><%#: GetHoursWorked() %></asp:Label><br />

                    <asp:Label runat="server" CssClass="control-label" Text="Hours worked"></asp:Label>
                    <asp:TextBox runat="server" ID="txtHours" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="ReportValidation" CssClass="txt-danger" ControlToValidate="txtHours" ErrorMessage="* hours field is required"></asp:RequiredFieldValidator><br />

                    <asp:Label runat="server" CssClass="control-label" Text="Description"></asp:Label>
                    <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="ReportValidation" CssClass="txt-danger" ControlToValidate="txtDescription" ErrorMessage="* description field is required"></asp:RequiredFieldValidator><br />
                    <asp:Button runat="server" ValidationGroup="ReportValidation" Text="Add report" CssClass="btn btn-info" ID="btnAddReport" OnClick="btnAddReport_Click" />

                </ContentTemplate>
            </asp:UpdatePanel>



            <h4>Send activity to other users</h4>
            <div class="col-md-12">
                <asp:UpdatePanel runat="server" ID="SearchUserPanel">
                    <ContentTemplate>

                        <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control" />
                        <asp:AutoCompleteExtender
                            ServiceMethod="GetUserNames" ServicePath="/AutoComplete.asmx"
                            ID="txtNameAutoCompleter" runat="server"
                            Enabled="True" TargetControlID="txtUserName" UseContextKey="True"
                            MinimumPrefixLength="2">
                        </asp:AutoCompleteExtender>

                        <asp:Button runat="server" Text="Add user" ID="btnSearchUser" CssClass="btn btn-info" CausesValidation="false" OnClick="btnSearchUser_Click" />
                        <asp:Label runat="server" ID="lblResultSearchUser" CssClass="control-label"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <br />
            <br />


            <h4>Related project</h4>
            <asp:FormView runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                <%--<EmptyDataTemplate>
                        <p>This activity has no related project. You can add it to an existing project here.</p>
                        <asp:TextBox runat="server" ID="txtProjectName"></asp:TextBox>
                        <asp:Button runat="server" Text="Search" ID="btnSearchProject" OnClick="btnSearchProject_Click" />
                        <asp:Label runat="server" ID="lblResultAddProject"></asp:Label>
                    </EmptyDataTemplate>--%>
                <ItemTemplate>
                    <a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>"><%#: Item.ProjectName %></a>
                    <br />
                </ItemTemplate>
            </asp:FormView>
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
