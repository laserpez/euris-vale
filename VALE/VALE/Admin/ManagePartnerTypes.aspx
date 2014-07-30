<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagePartnerTypes.aspx.cs" Inherits="VALE.Admin.ManagePartnerTypes" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-10">
                                                <ul class="nav nav-pills">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Gestione Tipi Soci"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="navbar-right">
                                                <asp:Button ID="btnAddTypeButton" CssClass="btn btn-success" runat="server" Text="Aggiungi" OnClick="btnAddTypeButton_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <asp:HiddenField ID="lblTypeId" runat="server" Value="" />
                                    <asp:Label ID="lblTypeAction" runat="server" Visible="false" Text=""></asp:Label>
                                    <div class="row" runat="server" id="pnlTypeList">
                                        <div class="col-md-12">
                                            <asp:GridView ID="grdTypes" runat="server" AutoGenerateColumns="False"
                                                ItemType="VALE.Models.PartnerType"
                                                CssClass="table table-striped table-bordered"
                                                SelectMethod="grdTypes_GetData"
                                                AllowSorting="true" AllowPaging="true" PageSize="10"
                                                OnRowCommand="grdTypes_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center><div><asp:LinkButton runat="server"  CommandName="ShowType" CommandArgument="<%#: Item.PartnerTypeId %>"> <%#: Item.PartnerTypeName %></asp:LinkButton></div></center>
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <center><div><asp:Linkbutton runat="server" id="labelname" commandargument="groupid" commandname="sort"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:Linkbutton></div></center>
                                                        </HeaderTemplate>
                                                        <HeaderStyle Width="20%" />
                                                        <ItemStyle Font-Bold="true" Width="20%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton runat="server" CommandArgument="Description" CommandName="Sort" ID="labelDescription"><span  class="glyphicon glyphicon-credit-card"></span> Descrizione</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton  runat="server" CommandArgument="CreationDate" CommandName="sort" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                        <ItemStyle Width="115px"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center>
                                                                <div>
                                                                            <asp:LinkButton runat="server"  CommandName="ShowType" CommandArgument="<%#: Item.PartnerTypeId %>"><span class="label label-primary"><span class="glyphicon glyphicon-eye-open"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" CommandName="EditType" Visible='<%# AllowManage(Convert.ToInt32(Eval("PartnerTypeId"))) %>' CommandArgument="<%#: Item.PartnerTypeId %>"><span class="label label-success"><span class="glyphicon glyphicon-pencil"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" CommandName="DeleteType" Visible='<%# AllowManage(Convert.ToInt32(Eval("PartnerTypeId"))) %>' CommandArgument="<%#: Item.PartnerTypeId %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                                                        </div>
                                                            </center>
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton runat="server" ID="labelBtnGroup"><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <HeaderStyle Width="100px"></HeaderStyle>
                                                        <ItemStyle Width="100px"></ItemStyle>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <PagerSettings Position="Bottom" />
                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Non ci sono tipi</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
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
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopup" runat="server"
                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopup" style="width: 50%;">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Nuovo Tipo di socio</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Nome Tipo *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" class="form-control input-sm" ID="NameTextBox" />
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="AddType" ControlToValidate="NameTextBox" CssClass="text-danger" ErrorMessage="Il campo Nome tipo è richiesto." />
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Descrizione *</label>
                                <div class="col-lg-12">
                                    <textarea runat="server" class="form-control input-sm" rows="3" id="DescriptionTextarea"></textarea>
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="AddType" ControlToValidate="DescriptionTextarea" CssClass="text-danger" ErrorMessage="Il campo Descrizione è richiesto." />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="Crea" ID="btnOkButton" CssClass="btn btn-success btn-sm" CausesValidation="true" ValidationGroup="AddType" OnClick="btnOkButton_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" OnClick="btnClosePopUpButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
