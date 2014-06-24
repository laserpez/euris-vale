<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageEvents.aspx.cs" Inherits="VALE.Admin.ManageEvents" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Gestione eventi</h3>
    <br />
    <br />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:GridView OnRowCommand="grdEventList_RowCommand" DataKeyNames="EventId" ID="grdEventList" SelectMethod="GetEvents" runat="server" AutoGenerateColumns="false" GridLines="Both"
                ItemType="VALE.Models.Event" EmptyDataText="Nessun evento aperto." CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <center><div><asp:LinkButton CommandArgument="Name" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-th"></span> Nome</asp:LinkButton></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center><div><asp:Label runat="server"><%#: Item.Name %></asp:Label></div></center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <center><div><asp:LinkButton CommandArgument="EventDate" CommandName="sort" runat="server" ID="labelEventDate"><span  class="glyphicon glyphicon-th"></span> Data di creazione</asp:LinkButton></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="90px" />
                        <ItemStyle Width="90px" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <center><div><asp:LinkButton CommandArgument="OrganizerUserName" CommandName="sort" runat="server" ID="labelOrganizerUserName"><span  class="glyphicon glyphicon-th"></span>Creatore</asp:LinkButton></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center><div><asp:Label runat="server"><%#: Item.OrganizerUserName %></asp:Label></div></center>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <center><div><asp:Label runat="server" ID="labelView"><span  class="glyphicon glyphicon-th"></span>Vedi</asp:Label></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <div>
                                    <asp:Button runat="server" Text="Vedi report" CssClass="btn btn-info btn-xs" Width="150px"
                                        CommandName="ViewReport" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                                </div>
                            </center>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <center><div><asp:Label runat="server" ID="labelDelete"><span  class="glyphicon glyphicon-th"></span>Cancella</asp:Label></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center>
                                <div>
                                    <asp:Button runat="server" Text="Cancella evento" CssClass="btn btn-danger btn-xs" Width="150px"
                                        CommandName="DeleteProject" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" />
                                </div>
                            </center>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanelDelete" runat="server">
        <ContentTemplate>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <asp:ModalPopupExtender ID="ModalPopup" BehaviorID="mpe" runat="server"
                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <div class="panel panel-primary" id="pnlPopup" style="width: 60%;">
                <div class="panel-heading">
                    <asp:Label ID="TitleModalView" runat="server" Text="Cancella evento"></asp:Label>
                    <asp:Button runat="server" CssClass="close" OnClick="CloseButton_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 220px">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Nome evento</label>
                                <div class="col-lg-10 control-label" runat="server" id="Div1">
                                    <asp:Label runat="server" ID="EventName" Text="" />
                                    <asp:Label runat="server" ID="EventID" Text="" Visible="false"></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Password</label>
                                <div class="col-lg-10 control-label" runat="server" id="PasswordDiv">
                                    <asp:TextBox TextMode="Password" runat="server" CssClass="form-control" ID="PassTextBox" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <asp:Button runat="server" ID="DeleteButton" CssClass="btn btn-default navbar-btn" Text="Conferma" OnClick="DeleteButton_Click" />
                        <asp:Label  runat="server" ID="ErrorDeleteLabel" Text="" Visible="false" ></asp:Label>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
