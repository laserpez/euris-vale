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
                                    <asp:Button runat="server" CausesValidation="false" Text="Carica" ID="btnUploadFile" CssClass="btn btn-info btn-xs" OnClick="btnUploadFile_Click" />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">File caricato</asp:Label>

                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <div class="col-md-10">
                                            <asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="Nessun file caricato."
                                                ID="grdFilesUploaded" runat="server">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button CausesValidation="false" Width="90" CssClass="btn btn-danger btn-xs" runat="server" CommandName="DeleteFile"
                                                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Cancella file" />
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">E' un progetto pubblico?</asp:Label>
                                <div class="col-md-10">
                                    <asp:CheckBox runat="server" ID="chkPublic" />
                                </div>
                                <asp:Label runat="server" CssClass="col-md-12 control-label"><br /></asp:Label>
                                <uc:SelectProject runat="server" ID="SelectProject" />
                                <asp:Label runat="server" CssClass="col-md-12 control-label"><br /></asp:Label>
                                <ux:SelectUser runat="server" ID="SelectUser" />

                                <div class="col-md-12">
                                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Salva" ID="btnSaveActivity" CausesValidation="true" OnClick="btnSaveProject_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
