<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventCreate.aspx.cs" Inherits="VALE.MyVale.EventCreate" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Crea un nuovo evento"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" >
                            <div class="row"><div class="col-md12"><br /></div></div>
                            <div class="col-md-12 form-group">
                                <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Nome *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" Width="350px" ID="txtName" CssClass="form-control"  />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il nome è obbligatorio" />
                                </div>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Descrizione *</asp:Label>
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

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Data *</asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox runat="server" Width="350px" ID="txtStartDate" CssClass="form-control"  />
                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="La data è obbligatoria" />
                                    <asp:RegularExpressionValidator runat="server" ValidationExpression="\d{1,2}/\d{1,2}/\d{4}" CssClass="text-danger" ErrorMessage="Il formato della data non è corretto." ControlToValidate="txtStartDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Ore</asp:Label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="txtHour" TextMode="Number" Width="100" runat="server" CssClass="form-control"></asp:TextBox> 
                                </div>
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Min</asp:Label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="txtMin" TextMode="Number" Width="100" runat="server" CssClass="form-control"></asp:TextBox> 
                                    <br />
                                </div>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Luogo *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox  runat="server" ID="txtSite" CssClass="form-control"  />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSite" CssClass="text-danger" ErrorMessage="Il luogo è obbligatorio" /> 
                                    <br />
                                </div>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Durata(in ore)</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox ID="txtDurata" Width="280px" TextMode="Number" runat="server" CssClass="form-control"></asp:TextBox> 
                                    <br />
                                </div>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">E' un evento pubblico?</asp:Label>
                                <div class="col-md-10">
                                    <asp:CheckBox runat="server" ID="chkPublic" />
                                </div>
                                <asp:Label runat="server" CssClass="col-md-12 control-label"><br /></asp:Label>
                                <uc:SelectProject runat="server" ID="SelectProject" />
                                <div class="row"><div class="col-md12"><br /></div></div>
                                <div class="row"><div class="col-md12"><br /></div></div>

                                <div class="col-md-12">
                                    <asp:Button runat="server" Text="Invita persone" ID="btnAddUsers" CausesValidation="true" CssClass="btn btn-primary" OnClick="btnAddUsers_Click" />
                                    <asp:Button runat="server" Text="Salva e Chiudi" ID="caefa" CausesValidation="true" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                                    <asp:Button runat="server" CssClass="btn btn-danger"  Text="Annulla" ID="btnCancel" CausesValidation="false"  OnClick="btnCancel_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
