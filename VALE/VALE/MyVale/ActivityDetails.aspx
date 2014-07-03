<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityDetails.aspx.cs" Inherits="VALE.MyVale.ActivityDetails" %>
<%@ Register Src="~/MyVale/Create/SelectUser.ascx" TagPrefix="ux" TagName="SelectUser" %>

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
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio attività"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:FormView runat="server" ID="ActivityDetail" ItemType="VALE.Models.Activity" SelectMethod="GetActivity">
                                <ItemTemplate>
                                    <h3><%#: Item.ActivityName.ToUpper() %></h3>
                                    <asp:Label runat="server" CssClass="conrol-label"><%#: String.Format("Creato da: {0}", Item.Creator.FullName) %></asp:Label>
                                    <br />
                                    <asp:Label runat="server" CssClass="control-label"><%#: String.Format("Da: {0} - A: {1}", Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita", Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita") %></asp:Label>
                                    <br />

                                    <asp:Label runat="server"><%#: String.Format("Descrizione: {0}", Item.Description) %></asp:Label><br />

                                    <h4>Stato</h4>
                                            <asp:Label runat="server" CssClass="control-label"><%#: String.Format("Corrente: {0}", GetStatus(Item)) %></asp:Label>
                                    <br />
                                    <h4>Collaboratori</h4>
                                                <asp:GridView ItemType="VALE.Models.UserData" Width="528px" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                        SelectMethod="GetUsersInvolved" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
                                                </ItemTemplate>
                                                        <HeaderStyle Width="528px" />
                                                        <ItemStyle Width="528px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                                </ItemTemplate>
                                                        <HeaderStyle Width="528px" />
                                                        <ItemStyle Width="528px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessun collaboratore</asp:Label>
                                        </EmptyDataTemplate>
                                    </asp:GridView>

                                    <asp:Button runat="server" Text="Invita collaboratori" ID="btnInviteUser" CssClass="btn btn-info btn-xs" CausesValidation="false" OnClick="btnInviteUser_Click" />

                                    <h4>Lavoro svolto per l'attività</h4>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Label runat="server" ID="lblHoursWorked" CssClass="control-label"><%#: GetHoursWorked() %></asp:Label>
                                            <p></p>
                                            <asp:Label runat="server" CssClass="control-label" Text="Ore lavorate"></asp:Label>
                                            <asp:TextBox runat="server" ID="txtHours" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="ReportValidation" CssClass="txt-danger" ControlToValidate="txtHours" ErrorMessage="* campo ore obblligatorio"></asp:RequiredFieldValidator><br />

                                            <asp:Label runat="server" CssClass="control-label" Text="Descrizione"></asp:Label>
                                            <asp:TextBox runat="server" ID="txtDescription" CssClass="form-control"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ValidationGroup="ReportValidation" CssClass="txt-danger" ControlToValidate="txtDescription" ErrorMessage="* descrizione obbligatoria"></asp:RequiredFieldValidator><br />
                                            <asp:Button runat="server" ValidationGroup="ReportValidation" Text="Aggiungi report" CssClass="btn btn-info btn-xs" ID="btnAddReport" OnClick="btnAddReport_Click" />
                                            <asp:Label ID="addReportLabel" runat="server" Text=""></asp:Label>

                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <div class="col-md-12">
                                        <br />
                                    </div>

                                    <h4>Progetto correlato</h4>
                                    <asp:FormView runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" EmptyDataText="Nessun progetto correlato." SelectMethod="GetRelatedProject">
                                        <ItemTemplate>
                                            <a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>"><%#: Item.ProjectName %></a>
                                            <br />
                                        </ItemTemplate>
                                    </asp:FormView>
                                </ItemTemplate>
                            </asp:FormView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
