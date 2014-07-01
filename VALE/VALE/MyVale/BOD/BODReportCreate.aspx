﻿<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/FileUploader.ascx" TagPrefix="uc" TagName="FileUploader" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BODReportCreate.aspx.cs" Inherits="VALE.MyVale.BOD.BODReportCreate" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Crea un nuovo verbale del consiglio direttivo"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div class="col-md-12 form-group">
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Nome:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox CssClass="form-control" ID="txtReportName" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtReportName" ErrorMessage="* campo Nome obbligatorio"></asp:RequiredFieldValidator><br />
                                </div>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Luogo:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox CssClass="form-control" ID="txtLocation" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtLocation" ErrorMessage="* campo Luogo obbligatorio"></asp:RequiredFieldValidator><br />
                                </div>
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Data riunione:</asp:Label>
                                <asp:UpdatePanel ID="MeetingDateUpdatePanel" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <div class="col-md-10">
                                            <asp:TextBox CssClass="form-control" ID="txtMeetingDate" runat="server" OnTextChanged="txtMeetingDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarMeetingDate" TargetControlID="txtMeetingDate" runat="server" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                            <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtMeetingDate" ErrorMessage="* campo Data riunione obbligatorio"></asp:RequiredFieldValidator><br />
                                        </div>
                                        <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Data di pubblicazione:</asp:Label>
                                        <div class="col-md-10">
                                            <asp:TextBox CssClass="form-control" ID="txtPublishDate" runat="server"></asp:TextBox>
                                            <asp:CalendarExtender ID="CalendarPublishDate" TargetControlID="txtPublishDate" runat="server" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                            <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtPublishDate" ErrorMessage="* campo Data di pubblicazione obbligatorio"></asp:RequiredFieldValidator><br />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Scrivi verbale:</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox CssClass="form-control" TextMode="MultiLine" Width="500px" Height="300px" ID="txtReportText" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" CssClass="text-danger" ControlToValidate="txtReportText" ErrorMessage="* campo Scrivi verbale obbligatorio"></asp:RequiredFieldValidator><br />
                                    <br />
                                </div>

                                
                                
                                <div class="col-md-12">
                                    <asp:Button runat="server" ID="btnSubmit" Text="Salva verbale" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                                </div>

                                <asp:Label Visible="false" ID="lblUploadFile" runat="server" Text="Se vuoi puoi caricare dei documenti relativi a questo verbale"></asp:Label>
                                <uc:FileUploader runat="server" ID="FileUploader" Visible="false" />


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
