<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="VALE.MyVale.EventDetails" %>
<%@ Register Src="~/MyVale/FileUploader.ascx" TagPrefix="uc" TagName="FileUploader" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
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

                                    <div class="col-lg-10">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettagli evento"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="navbar-right">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Button CausesValidation="false" Text="Partecipa" runat="server" ID="btnAttend" OnClick="btnAttend_Click" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="panel-body" >
                            
                            <asp:FormView Width="100%" OnDataBound="EventDetail_DataBound" runat="server" ID="EventDetail" ItemType="VALE.Models.Event" SelectMethod="GetEvent">
                                <ItemTemplate>
                                    <div class="col-md-11">
                                        <h3><%#: Item.Name %></h3>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Organizzatore: </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.Organizer.FullName) %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Data: </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.EventDate.ToString()) %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Durata(ore): </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.Durata) %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Stato: </asp:Label><asp:Label runat="server"><%#: Item.Public ? "Pubblico" : "Privato" %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Luogo: </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.Site) %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Descrizione: </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.Description) %></asp:Label>
                                        <br />
                                        <asp:FormView runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                                            <EmptyDataTemplate>
                                                <asp:Label runat="server" Font-Bold="true">Progetto correlato: </asp:Label><asp:Label runat="server" Text="Nessun progetto correlato"></asp:Label>
                                            </EmptyDataTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" Font-Bold="true">Progetto correlato: </asp:Label>
                                                <a href="ProjectDetails.aspx?projectId=<%#:Item.ProjectId %>"><%#: Item.ProjectName %></a>
                                            </ItemTemplate>
                                        </asp:FormView>
                                    <br />
                                    </div>
                                    <div class="col-md-1">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Button ID="btnModifyEvent" Visible="false" CssClass="btn btn-danger" runat="server" Text="Modifica" OnClick="btnModifyEvent_Click" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">

                                                <div class="panel-heading">
                                                    <div class="row">
                                                        <div class="col-md-12">

                                                            <div class="col-md-8">
                                                                <ul class="nav nav-pills">
                                                                    <li><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Partecipanti</li>
                                                                </ul>
                                                            </div>

                                                            <div class="navbar-right">
                                                                <asp:Button ID="btnAddUsers" runat="server" Visible="false" OnClick="addUsers_Click" CssClass="btn btn-info btn-sm" Text="Aggiungi/Rimuovi" />
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true" AllowPaging="true" PageSize="5"
                                                                SelectMethod="GetRegisteredUsers" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div>
                                                                        <asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton>
                                                                    </div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div>
                                                                    <asp:Label runat="server"><%#: Item.FullName %></asp:Label>
                                                                </div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div>
                                                                    <asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton>
                                                                </div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div>
                                                                    <asp:Label runat="server"><%#: Item.Email %></asp:Label>
                                                                </div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <EmptyDataTemplate>
                                                                    <asp:Label runat="server">Nessun utente registrato.</asp:Label>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>

                                            </div>
                                        </div>
                                    </div>                                   
                                    <br />
                                    <uc:FileUploader runat="server" ID="FileUploader" AllowUpload="true" />

                                </ItemTemplate>
                            </asp:FormView>

                        </div>
                    </div>
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
                            <legend>Nuovo Gruppo</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Nome Gruppo *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" class="form-control input-sm" ID="NameTextBox" />
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="AddGroup" ControlToValidate="NameTextBox" CssClass="text-danger" ErrorMessage="Il campo Nome Gruppo è richiesto." />
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Descrizione *</label>
                                <div class="col-lg-12">
                                    <textarea runat="server" class="form-control input-sm" rows="3" id="DescriptionTextarea"></textarea>
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="AddGroup" ControlToValidate="DescriptionTextarea" CssClass="text-danger" ErrorMessage="Il campo Descrizione è richiesto." />
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
                            <asp:Button runat="server" Text="Crea" ID="btnConfirmModify" CssClass="btn btn-success btn-sm" CausesValidation="true" ValidationGroup="AddGroup" OnClick="btnConfirmModify_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" OnClick="btnClosePopUpButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
