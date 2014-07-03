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
                        <div class="panel-body" style="overflow: auto;">
                            <div class="col-md-12 form-group">
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Nome evento *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il nome è obbligatorio" />
                                </div>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Descrizione evento *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox TextMode="MultiLine" runat="server" ID="txtDescription" CssClass="form-control" Height="145px" Width="404px" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="La descrizione è obbligatoria" />
                                </div>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Data *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" />
                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="La data è obbligatoria" />
                                </div>
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">E' un evento pubblico?</asp:Label>
                                <div class="col-md-10">
                                    <asp:CheckBox runat="server" ID="chkPublic" />
                                </div>
                                <asp:Label runat="server" CssClass="col-md-12 control-label"><br /></asp:Label>
                                <uc:SelectProject runat="server" ID="SelectProject" />
                                <div class="col-md-12">
                                    <asp:Button runat="server" Text="Crea evento" ID="btnSaveActivity" CausesValidation="true" CssClass="btn btn-primary" OnClick="btnSaveEvent_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
