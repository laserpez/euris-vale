<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityCreate.aspx.cs" Inherits="VALE.MyVale.ActivityCreate" %>

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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Crea una nuova attività personale"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" >
                            <p>&nbsp;</p>
                            <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                            <div class="form-group">
                                <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Nome attività *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il nome è obbligatorio" />
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
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="La descrizione è obbligatoria" />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Tipo Attività</asp:Label>
                                <div class="col-md-10">
                                    <asp:DropDownList  class="form-control" runat="server"  ID="ddlSelectType" SelectMethod="GetTypes" Width="404px" ItemType="VALE.Models.ActivityType" DataTextField="ActivityTypeName" DataValueField="ActivityTypeName"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlSelectType" CssClass="text-danger" ErrorMessage="il è obbligatorio" />
                                </div>
                                <%--<asp:UpdatePanel runat="server">
                                    <ContentTemplate>--%>
                                        <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Stato</asp:Label>
                                        <div class="col-md-10">
                                            <button type="button" visible="false" id="ToBePlannedStatusButtonDisabled" class="btn btn-primary disabled" runat="server">Da Pianificare  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="OngoingStatusButtonDisabled" class="btn btn-success disabled" runat="server">In Corso  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="SuspendedStatusButtonDisabled" class="btn btn-warning disabled" runat="server">Sospeso  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="DoneStatusButtonDisabled" class="btn btn-default disabled" runat="server">Terminato  <span class="caret"></span></button>
                                            <div class="btn-group">
                                                <asp:Label ID="LabelActivityStatus" runat="server" value="ToBePlanned" Visible="false"></asp:Label>
                                                <button type="button" visible="true" id="ToBePlannedStatusButton" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Da Pianificare  <span class="caret"></span></button>
                                                <button type="button" visible="false" id="OngoingStatusButton" class="btn btn-success dropdown-toggle" data-toggle="dropdown" runat="server">In Corso  <span class="caret"></span></button>
                                                <button type="button" visible="false" id="SuspendedStatusButton" class="btn btn-warning dropdown-toggle" data-toggle="dropdown" runat="server">Sospesa  <span class="caret"></span></button>
                                                <button type="button" visible="false" id="DoneStatusButton" class="btn btn-default dropdown-toggle" data-toggle="dropdown" runat="server">Terminata  <span class="caret"></span></button>
                                                <ul class="dropdown-menu">
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="ToBePlannedStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-share-alt"></span> Da Pianificare</asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="OngoingStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-play"></span>  In Corso  </asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="SuspendedStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-pause"></span> Sospesa  </asp:LinkButton></li>
                                                    <li>
                                                        <asp:LinkButton runat="server" OnClick="DoneStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-stop"></span> Terminata</asp:LinkButton></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <br />
                                        </div>
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Data inizio</asp:Label>
                                        <div class="col-md-10">
                                            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" OnTextChanged="txtStartDate_TextChanged" AutoPostBack="true" />
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                            <asp:RegularExpressionValidator runat="server" ValidationExpression="\d{1,2}/\d{1,2}/\d{4}" CssClass="text-danger" ErrorMessage="Il formato della data non è corretto." ControlToValidate="txtStartDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                            <br />
                                        </div>
                                        <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Data fine</asp:Label>
                                        <div class="col-md-10">
                                            <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control"  />
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtEndDate"></asp:CalendarExtender>
                                            <asp:RegularExpressionValidator runat="server" ValidationExpression="\d{1,2}/\d{1,2}/\d{4}" CssClass="text-danger" ErrorMessage="Il formato della data non è corretto." ControlToValidate="txtEndDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                            <br />
                                        </div>
                                        
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Budget</asp:Label>
                                <div class="col-md-10">
                                            <asp:TextBox TextMode="Number" runat="server" ID="txtBudget" CssClass="form-control" Width="100px"/>
                                        </div>
                                <div class="col-md-12">
                                            <br />
                                        </div>
                                <div>
                                    <uc:SelectProject runat="server" ID="SelectProject" />
                                </div>
                                <p>&nbsp;</p>
                            </div>
                            <p></p>
                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Invita collaboratori" ID="btnSaveActivity" CausesValidation="true" OnClick="btnSaveActivity_Click" />
                            <asp:Button runat="server" CssClass="btn btn-primary" Text="Salva e Chiudi" ID="Button1" CausesValidation="true"  OnClick="btnSaveActivityAndSelectUsers_Click" />
                            <br />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
