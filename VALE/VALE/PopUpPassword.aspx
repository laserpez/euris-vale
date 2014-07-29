<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PopUpPassword.aspx.cs" Inherits="VALE.PopUpPassword" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanelPasswordPopUp" runat="server">
        <ContentTemplate>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
            <asp:ModalPopupExtender ID="ModalPopup" runat="server"
                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <div class="alert alert-dismissable alert-info" id="pnlPopup" style="width: 25%;">
                <asp:LinkButton runat="server" CssClass="close" OnClick="CloseButton_Click">×</asp:LinkButton>
                <div class="row">

                    <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Inserisci Password</strong></asp:Label>
                    <div class="col-md-12">
                        <br />
                    </div>
                    <div class="col-md-12">
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control input-sm" />
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-8 col-md-10">
                            <asp:Button runat="server" Text="Ok" ID="btnFilterProjects" CssClass="btn btn-success btn-xs" OnClick="OkButton_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClearFilters" CssClass="btn btn-danger btn-xs" OnClick="CloseButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
