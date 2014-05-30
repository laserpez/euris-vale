<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectDetails.aspx.cs" Inherits="VALE.MyVale.ProjectDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView OnDataBound="ProjectDetail_DataBound" runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetProject">
        <ItemTemplate>
            <h3><%#: Item.ProjectName.ToUpper() %></h3>
            <h4>Project details</h4>

            <asp:Label runat="server"><%#: String.Format("Status:\t{0}", Item.Status.ToUpperInvariant()) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Description:\t{0}", Item.Description) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Created by:\t{0}", Item.Organizer.FullName) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("On date:\t{0}", Item.CreationDate.ToShortDateString()) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Last modified:\t{0}", Item.LastModified.ToShortDateString()) %></asp:Label><br />

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <h4>Work on this project</h4>
                    <asp:Button runat="server" ID="btnWorkOnThis" OnClick="btnWorkOnThis_Click" />
                    <asp:Button runat="server" ID="btnAddIntervention" OnClick="btnAddIntervention_Click" />


                    <h4>Related users</h4>
                    <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                        SelectMethod="GetRelatedUsers" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        </Columns>
                        <EmptyDataTemplate>
                            <asp:Label runat="server">No related users</asp:Label>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>

            <h4>Related project</h4>
            <asp:FormView runat="server" ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                <EmptyDataTemplate>
                    <asp:Label runat="server" Text="This project is not related to another project"></asp:Label>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>"><%#: Item.ProjectName %></a><br />
                </ItemTemplate>
            </asp:FormView>

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <h4>Related events</h4>
                    <asp:GridView ItemType="VALE.Models.Event" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                        SelectMethod="GetRelatedEvents" DataKeyNames="EventId" runat="server" ID="GridView1" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="EventDate" HeaderText="Date" SortExpression="EventDate" />
                        </Columns>
                        <EmptyDataTemplate>
                            <asp:Label runat="server">No related events</asp:Label>
                        </EmptyDataTemplate>
                    </asp:GridView>

                    <h4>Related activities</h4>
                    <asp:GridView ItemType="VALE.Models.Activity" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                        SelectMethod="GetRelatedActivities" DataKeyNames="ActivityId" runat="server" ID="GridView2" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="ActivityName" HeaderText="Name" SortExpression="ActivityName" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                            <asp:BoundField DataField="CreationDate" DataFormatString="{0:d}" HeaderText="Creation Date" SortExpression="CreationDate" />
                            <asp:TemplateField HeaderText="Expire Date" SortExpression="ExpireDate">
                                <ItemTemplate>
                                    <asp:Label runat="server"><%#: Item.ExpireDate.Year == 9999 ? "No end date" : Item.ExpireDate.ToShortDateString() %></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <asp:Label runat="server">No related activities</asp:Label>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>


            <h4>Documents</h4>
            <asp:ListBox runat="server" CssClass="form-control" Width="400px" ID="lstDocuments" SelectMethod="GetRelatedDocuments"></asp:ListBox>
            <asp:Button runat="server" Text="View document" CssClass="btn btn-info" ID="btnViewDocument" OnClick="btnViewDocument_Click" />

            <h4>Interventions</h4>
            <asp:GridView OnRowCommand="grdInterventions_RowCommand" ItemType="VALE.Models.Intervention" GridLines="Both" AllowSorting="true"
                SelectMethod="GetInterventions" runat="server" ID="grdInterventions" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="InterventionId" HeaderText="ID" SortExpression="InterventionId" />
                    <asp:BoundField DataField="InterventionText" HeaderText="Comment" SortExpression="InterventionText" />
                    <asp:TemplateField HeaderText="Created by">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: GetUserName(Item.CreatorId) %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Has documents">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: ContainsDocuments(Item.DocumentsPath) ? "YES" : "NO" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="View">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-info btn-sm" runat="server" CommandName="ViewIntervention"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View intervention" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label runat="server">No interventions</asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>



            <h4>Manage project</h4>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Label runat="server" ID="lblInfoManage" Text="Here you can manage this project"></asp:Label><br />
                    <asp:Button runat="server" ID="btnSuspendProject" CausesValidation="false" OnClick="btnSuspendProject_Click" />
                    <asp:Button runat="server" ID="btnCloseProject" CausesValidation="false" OnClick="btnCloseProject_Click" /><br />
                    <asp:Panel runat="server" Visible="false" ID="manageProjectPanel">
                        <asp:Label runat="server" Text="Insert password to confirm operation: "></asp:Label>
                        <asp:Label ID="lblInfoOperation" runat="server"></asp:Label><br />
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtPassword" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ErrorMessage="Password is required" ControlToValidate="txtPassword" runat="server"></asp:RequiredFieldValidator>
                        <asp:Button runat="server" ID="btnModifyProject" CssClass="btn btn-info" Text="Confirm" OnClick="btnModifyProject_Click" />
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>



        </ItemTemplate>
    </asp:FormView>
</asp:Content>
