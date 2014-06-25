<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BODReportCreate.aspx.cs" Inherits="VALE.MyVale.BOD.BODReportCreate" %>
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
                                            <div class="col-lg-12">
                                                <ul class="nav nav-pills col-lg-6">
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

                                        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Carica file</asp:Label>
                                        <div class="col-md-10">
                                            <asp:FileUpload AllowMultiple="false" ID="FileUploadControl" runat="server" />
                                            <asp:Label runat="server" ID="StatusLabel" Text="" />
                                            <asp:Button runat="server" CausesValidation="false" Text="Carica" ID="btnUploadFile" CssClass="btn btn-info btn-xs" OnClick="btnUploadFile_Click" />
                                        </div>

                                        <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">File caricato</asp:Label>
                                        <%--<asp:GridView OnRowCommand="grdFilesUploaded_RowCommand" CssClass="table table-striped table-bordered" EmptyDataText="Nessun file caricato"
                                        ID="grdFilesUploaded" runat="server">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button CausesValidation="false" CssClass="btn btn-danger btn-sm" runat="server" CommandName="DeleteFile"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Cancella file" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>--%>
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
                                        <br />
                                        <div class="col-md-12"><br /></div>
                                        <div class="col-md-12">
                                            <asp:Button runat="server" ID="btnSubmit" Text="Salva verbale" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
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
