<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityCreate.aspx.cs" Inherits="VALE.MyVale.ActivityCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Crea una nuova attività personale</h3>
    <div class="form-group">
        <asp:Label runat="server" CssClass="col-md-2 control-label">Nome attività *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il nome è obbligatorio" />
        </div>
        <asp:Label runat="server" CssClass="col-md-2 control-label">Descrizione *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtDescription" CssClass="form-control" Height="145px" Width="404px" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="La descrizione è obbligatoria" />
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:Label runat="server" CssClass="col-md-2 control-label">Data inizio</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" OnTextChanged="txtStartDate_TextChanged" AutoPostBack="true" />
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                </div>
                <asp:Label runat="server" CssClass="col-md-2 control-label">Data fine</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" />
                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtEndDate"></asp:CalendarExtender>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
      
        <uc:SelectProject runat="server" ID="SelectProject"/>
        <p></p>
    </div>
    <p></p>
    <asp:Button runat="server" CssClass="btn btn-primary" Text="Salva attività" ID="btnSaveActivity" CausesValidation="true" OnClick="btnSaveActivity_Click" />
    <br />
</asp:Content>
