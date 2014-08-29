<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BODReports.aspx.cs" Inherits="VALE.MyVale.BOD.BODReports" %>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
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
                                    <div class="col-lg-8">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Articoli del consiglio"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                     <div class="navbar-right">
                                        <asp:Button runat="server" Text="Crea Verbale"  CssClass="btn btn-success" ID="btnAddBODReport" OnClick="btnAddBODReport_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <asp:GridView OnRowCommand="grdBODReport_RowCommand" DataKeyNames="BODReportId" AllowPaging="true" PageSize="10" SelectMethod="GetBODReports" ID="grdBODReport" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                        ItemType="VALE.Models.BODReport" EmptyDataText="Nessun verbale del consiglio direttivo." CssClass="table table-striped table-bordered">
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="Name" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Name %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="Location" CommandName="sort" runat="server" ID="labelLocation"><span  class="glyphicon glyphicon-align-justify"></span> Luogo</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.Location %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="MeetingDate" CommandName="sort" runat="server" ID="labelMeetingDate"><span  class="glyphicon glyphicon-calendar"></span> Data riunione</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.MeetingDate.ToShortDateString() %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                                <center><div><asp:LinkButton CommandArgument="PublishingDate" CommandName="sort" runat="server" ID="labelPublishingDate"><span  class="glyphicon glyphicon-calendar"></span> Data pubblicazione</asp:LinkButton></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Label runat="server"><%#: Item.PublishingDate.ToShortDateString() %></asp:Label></div></center>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                         <HeaderTemplate>
                                                            <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                        </HeaderTemplate>
                                                <ItemTemplate>
                                                            <center><div><asp:Button runat="server" Width="90px" Text="Visualizza" CssClass="btn btn-info btn-xs"
                                                                CommandName="ViewReport" CommandArgument="<%# Item.BODReportId %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <center><div><asp:Label runat="server" ID="labelDelete"><span  class="glyphicon glyphicon-remove"></span> Cancella</asp:Label></div></center>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <center><div><asp:Button runat="server" Width="90" Text="Cancella" CssClass="btn btn-danger btn-xs"
                                CommandName="DeleteBODReport" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" /></div></center>
                                                </ItemTemplate>
                                                <HeaderStyle Width="90px" />
                                                <ItemStyle Width="90px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerSettings Position="Bottom" />
                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:ModalPopupExtender ID="ModalPopup" runat="server"
                                                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
                                            </asp:ModalPopupExtender>
                                            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                                            <div class="alert alert-dismissable alert-info" id="pnlPopup" style="width: 25%;">
                                                <div class="row">
                                                    <asp:Label runat="server" Visible="false" ID="BODReportId" CssClass="col-md-12 control-label"></asp:Label>
                                                    <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Inserisci Password</strong></asp:Label>
                                                    <div class="col-md-12">
                                                        <br />
                                                    </div>
                                                    <div class="col-md-12">
                                                        <asp:TextBox runat="server" ID="PassTextBox" TextMode="Password" CssClass="form-control input-sm" />
                                                    </div>
                                                    <div class="col-md-12">
                                                        <asp:Label runat="server" ID="ErrorDeleteLabel" CssClass="col-md-12 control-label"></asp:Label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="col-md-12">
                                                            <br />
                                                        </div>
                                                        <div class="col-md-offset-8 col-md-10">
                                                            <asp:Button runat="server" Text="Ok"  CssClass="btn btn-success btn-xs" CausesValidation="false" OnClick="DeleteButton_Click" />
                                                            <asp:Button runat="server" Text="Annulla" ID="btnClearFilters" CssClass="btn btn-danger btn-xs" CausesValidation="false" OnClick="CloseButton_Click" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
