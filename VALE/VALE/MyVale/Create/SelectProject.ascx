<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SelectProject.ascx.cs" Inherits="VALE.MyVale.Create.SelectProject" %>
<asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Related project (optional)</asp:Label>
<div class="col-md-10">
    <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
        <ContentTemplate>
            <asp:TextBox runat="server" ID="txtProjectName" CssClass="form-control" />
            <asp:AutoCompleteExtender
                ServiceMethod="GetProjectNames" ServicePath="/AutoComplete.asmx"
                ID="txtProjectAutoCompleter" runat="server"
                Enabled="True" TargetControlID="txtProjectName" UseContextKey="True"
                MinimumPrefixLength="2">
            </asp:AutoCompleteExtender>
            <asp:Button runat="server" Text="Save" ID="btnSearchProject" CssClass="btn btn-default" CausesValidation="false" OnClick="btnSearchProject_Click" />
            <asp:Label runat="server" ID="lblResultSearchProject" CssClass="control-label"></asp:Label>
            <asp:Button CssClass="btn btn-primary" ID="btnShowPopup" runat="server" Text="View all" OnClick="btnShowPopup_Click" CausesValidation="false" />
            <asp:ModalPopupExtender ID="ModalPopup" BehaviorID="mpe" runat="server"
                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <div class="panel panel-primary" id="pnlPopup" style="width: 80%;">
                <div class="panel-heading">
                    <asp:Label ID="TitleMpdalView" runat="server" Text="Titolo"></asp:Label>
                    <asp:Button runat="server" class="close" CausesValidation="false" OnClick="Unnamed_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 500px; overflow: auto;">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <asp:GridView SelectMethod="GetProjects" ID="OpenedProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                ItemType="VALE.Models.Project" EmptyDataText="No open projects" CssClass="table table-striped table-bordered" >
                                <Columns>
                                    <asp:BoundField DataField="ProjectID" HeaderText="ID" SortExpression="ProjectId" />
                                    <asp:BoundField DataField="ProjectName" HeaderText="Name" SortExpression="ProjectName" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                    <asp:TemplateField HeaderText="Created" SortExpression="CreationDate">
                                        <ItemTemplate>
                                            <asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                                    <asp:TemplateField HeaderText="Details">
                                        <ItemTemplate>
                                            <asp:Button runat="server" CausesValidation="false" CommandArgument="<%#: Item.ProjectName %>" Text="Relate" CssClass="btn btn-info btn-sm" ID="btnChooseProject" OnClick="btnChooseProject_Click"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>