<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>
<%@ Register Src="~/MyVale/Create/SelectUser.ascx" TagPrefix="ux" TagName="SelectUser" %>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectCreate.aspx.cs" Inherits="VALE.MyVale.ProjectCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Crea un nuovo progetto</h3>
    <div class="form-group">
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Nome progetto *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il campo Nome progetto è obbligatorio." />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Descrizione *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox TextMode="MultiLine" runat="server" ID="txtDescription" CssClass="form-control" Height="145px" Width="404px" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDescription" CssClass="text-danger" ErrorMessage="Il campo Descrizione è obbligatorio." />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Data di inizio *</asp:Label>
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" />
            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="Il campo Data di inizio è obbligatorio." />
        </div>

        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Carica file</asp:Label>
        <div class="col-md-10">
            <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
            <asp:Label runat="server" ID="StatusLabel" Text="" />
            <asp:Button runat="server" CausesValidation="false" Text="Carica" ID="btnUploadFile" CssClass="btn btn-info" OnClick="btnUploadFile_Click" />
        </div>
        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">File caricato</asp:Label>
        <div class="col-md-10">
            <asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="Nessun file caricato." 
                ID="grdFilesUploaded" runat="server">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button CausesValidation="false" CssClass="btn btn-danger btn-sm" runat="server" CommandName="DeleteFile" 
                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Cancella file" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <asp:Label runat="server" CssClass="col-md-2 control-label">E' un progetto pubblico?</asp:Label>
        <div class="col-md-10">
            <asp:CheckBox runat="server" ID="chkPublic" />
        </div>

        <p></p>
        <uc:SelectProject runat="server" ID="SelectProject"/>       

        <ux:SelectUser runat="server" ID="SelectUser"/>

        <p></p>
        <asp:Button runat="server" CssClass="btn btn-primary" Text="Salva" ID="btnSaveActivity" CausesValidation="true" OnClick="btnSaveProject_Click" />
        <br />
    </div>
</asp:Content>
