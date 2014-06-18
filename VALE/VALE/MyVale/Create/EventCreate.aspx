<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventCreate.aspx.cs" Inherits="VALE.MyVale.EventCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Crea un nuovo evento</h3>
    <div class="form-group">
         <asp:Label runat="server" CssClass="col-md-2 control-label">Nome evento *</asp:Label>
         <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il nome è obbligatorio" />
        </div>

        <asp:Label runat="server" CssClass="col-md-2 control-label">Descrizione evento *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtDescription" CssClass="form-control" Height="145px" Width="404px" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="La descrizione è obbligatoria" />
        </div>

        <asp:Label runat="server" CssClass="col-md-2 control-label">Data *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" />
            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="La data è obbligatoria" />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Carica file</asp:Label>
        <div class="col-md-10">
            <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
            <asp:Label runat="server" ID="StatusLabel" Text="" />
            <asp:Button runat="server" Text="Upload" ID="btnUploadFile" CssClass="btn btn-info" OnClick="btnUploadFile_Click" />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">File caricati</asp:Label>
        <div class="col-md-10">
            <asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="No files uploaded" 
                ID="grdFilesUploaded" runat="server">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button CausesValidation="false" CssClass="btn btn-danger btn-sm" runat="server" CommandName="DeleteFile" 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Elimina" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label runat="server" CssClass="col-md-2 control-label">E' un evento pubblico?</asp:Label>
        <div class="col-md-10">
            <asp:CheckBox runat="server" ID="chkPublic" />
        </div>

        <uc:SelectProject runat="server" ID="SelectProject"/>

        <%--<asp:Label runat="server" CssClass="col-md-2 control-label">Related project (optional)</asp:Label>
        <div class="col-md-10">
        <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
                <ContentTemplate>
                    <asp:TextBox runat="server" ID="txtProjectName" CssClass="form-control" />
                     <asp:AutoCompleteExtender 
                        ServiceMethod="GetProjectNames" ServicePath="/AutoComplete.asmx" 
                        ID="txtManufacturer_AutoCompleteExtender" runat="server" 
                        Enabled="True" TargetControlID="txtProjectName" UseContextKey="True"
                        MinimumPrefixLength="2"></asp:AutoCompleteExtender>
                    <asp:Button runat="server" Text="Add" ID="btnSearchProject" CssClass="btn btn-info" CausesValidation="false" OnClick="btnSearchProject_Click" />
                    <asp:Label runat="server" ID="lblResultSearchProject" CssClass="control-label"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <asp:UpdateProgress AssociatedUpdatePanelID="SearchProjectPanel" ID="MyUpdateProgress" runat="server" >
            <ProgressTemplate>
                Checking project name...
            </ProgressTemplate>
        </asp:UpdateProgress>--%>
        <p></p>
        <asp:Button runat="server" Text="Crea evento" ID="btnSaveActivity" CausesValidation="true" CssClass="btn btn-primary"  OnClick="btnSaveEvent_Click" />
    </div>
</asp:Content>
