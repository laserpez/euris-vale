<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateIntervention.aspx.cs" Inherits="VALE.MyVale.CreateIntervention" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Register Src="~/MyVale/FileUploader.ascx" TagPrefix="uc" TagName="FileUploader" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Aggiungi conversazione"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div class="col-md-12"></div>
                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-2 control-label">Inserisci commento</asp:Label>
                            <div class="col-md-10">
                                <asp:TextBox CssClass="form-control" TextMode="MultiLine" Width="500px" Height="300px" ID="txtComment" runat="server"></asp:TextBox>
                                    <asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtComment">
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
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtComment" CssClass="text-danger" ErrorMessage="Il campo Inserisci commento è obbligatorio"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                            <div class="col-md-10">
                                <uc:FileUploader ID="FileUploader" Visible="false" runat="server" AllowUpload="true" />
                            </div>
                            <div class="col-md-12">
                                <br />
                            </div>
                            <div class="col-md-12">
                            <asp:Button runat="server" CssClass="btn btn-primary" CausesValidation="false" Text="Aggiungi allegati" ID="btnSaveInterventionWithAttachment" OnClick="btnSaveInterventionWithAttachment_Click" />
                            <asp:Button runat="server" CssClass="btn btn-primary" CausesValidation="false" Text="Salva conversazione" ID="btnSaveIntervention" OnClick="btnSaveIntervention_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
