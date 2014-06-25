<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventCreate.aspx.cs" Inherits="VALE.MyVale.EventCreate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-6">
                                                <ul class="nav nav-pills col-lg-6">
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
                                        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Carica file</asp:Label>
                                        <div class="col-md-10">
                                            <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
                                            <asp:Label runat="server" ID="StatusLabel" Text="" />
                                            <asp:Button runat="server" Text="Carica" ID="btnUploadFile" CssClass="btn btn-info btn-xs" OnClick="btnUploadFile_Click" />
                                        </div>
                                        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">File caricati</asp:Label>
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <div class="col-md-10">
                                                    <asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="Nessun file caricato."
                                                        ID="grdFilesUploaded" runat="server">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center>
                                        <div>
                                             <asp:Button CausesValidation="false" Width="90" CssClass="btn btn-danger btn-xs" runat="server" CommandName="DeleteFile"
                                                 CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Elimina" />
                                        </div>
                                    </center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="100px" />
                                                                <ItemStyle Width="100px" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>

                                        <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">E' un evento pubblico?</asp:Label>
                                        <div class="col-md-10">
                                            <asp:CheckBox runat="server" ID="chkPublic" />
                                        </div>
                                        <asp:Label runat="server" CssClass="col-md-12 control-label"><br /></asp:Label>
                                        <uc:SelectProject runat="server" ID="SelectProject" />

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
                                        <div class="col-md-12">
                                            <asp:Button runat="server" Text="Crea evento" ID="btnSaveActivity" CausesValidation="true" CssClass="btn btn-primary" OnClick="btnSaveEvent_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnUploadFile" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
