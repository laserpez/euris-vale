<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>
<%@ Register Src="~/MyVale/Create/SelectUser.ascx" TagPrefix="ux" TagName="SelectUser" %>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectCreate.aspx.cs" Inherits="VALE.MyVale.ProjectCreate" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Crea un nuovo progetto"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div class="col-md-12 form-group">
                                <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Nome progetto *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il campo Nome progetto è obbligatorio." />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Descrizione *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox CssClass="form-control" TextMode="MultiLine" Width="500px" Height="300px" ID="txtDescription" runat="server"></asp:TextBox>
                                    <asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtDescription">
                                        <Toolbar>
                                            <ajaxToolkit:Undo />
                                            <ajaxToolkit:Redo />
                                            <ajaxToolkit:Bold />
                                            <ajaxToolkit:Italic />
                                            <ajaxToolkit:Underline />
                                            <ajaxToolkit:StrikeThrough />
                                            <ajaxToolkit:Subscript />
                                            <ajaxToolkit:Superscript />
                                            <ajaxToolkit:InsertOrderedList />
                                            <ajaxToolkit:InsertUnorderedList />
                                            <ajaxToolkit:CreateLink />
                                            <ajaxToolkit:Cut />
                                            <ajaxToolkit:Copy />
                                            <ajaxToolkit:Paste />
                                        </Toolbar>
                                    </asp:HtmlEditorExtender>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="Il campo Descrizione è obbligatorio." />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Tipo Progetto</asp:Label>
                                <div class="col-md-10">
                                    <asp:DropDownList  class="form-control" runat="server"  ID="ddlSelectType" SelectMethod="GetTypes" Width="404px" ItemType="VALE.Models.ProjectType" DataTextField="ProjectTypeName" DataValueField="ProjectTypeName"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlSelectType" CssClass="text-danger" ErrorMessage="il è obbligatorio" />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Data di inizio *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" />
                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="Il campo Data di inizio è obbligatorio." /><br />
                                    <asp:RegularExpressionValidator runat="server" ValidationExpression="\d{1,2}/\d{1,2}/\d{4}" CssClass="text-danger" ErrorMessage="Il formato della data non è corretto." ControlToValidate="txtStartDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                                <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Budget</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox TextMode="Number" runat="server" ID="txtBudget" CssClass="form-control" Width="100px"/>
                                    <br />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">E' un progetto pubblico?</asp:Label>
                                <div class="col-md-10">
                                    <asp:CheckBox runat="server" ID="chkPublic" />
                                </div>
                                <asp:Label runat="server" CssClass="col-md-12 control-label"><br /></asp:Label>
                                <uc:SelectProject runat="server" ID="SelectProject" />
                                <asp:Label runat="server" CssClass="col-md-12 control-label"><br /></asp:Label>

                                <div class="col-md-12">
                                    <asp:Button runat="server" Text="Invita persone" ID="btnAddUsers" CausesValidation="true" CssClass="btn btn-primary" OnClick="btnAddUsers_Click" />
                                    <asp:Button runat="server" Text="Salva e Chiudi" ID="btnSaveProject" CausesValidation="true" CssClass="btn btn-primary" OnClick="btnSaveProject_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
