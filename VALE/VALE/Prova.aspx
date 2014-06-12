<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Prova.aspx.cs" Inherits="VALE.Prova" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <asp:ModalPopupExtender ID="ModalPopup" BehaviorID="mpe" runat="server"
                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <div class="panel panel-primary" id="pnlPopup" style="width: 80%;">
                <div class="panel-heading">
                    <asp:Label ID="TitleMpdalView" runat="server" Text="Titolo"></asp:Label>
                    <asp:Button runat="server" class="close" OnClick="CloseButton_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 500px; overflow: auto;">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Primo Argumento</legend>
                            <p></p>
                            <legend>Secondo Argumento</legend>
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
