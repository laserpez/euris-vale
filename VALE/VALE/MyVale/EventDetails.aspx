<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="VALE.MyVale.EventDetails" %>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>
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
                                                <asp:Button CausesValidation="false" ID="btnModifyEvent" Visible="false" CssClass="btn btn-danger" runat="server" Text="Modifica" OnClick="btnModifyEvent_Click" />
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
            <asp:ModalPopupExtender ID="ModalPopupEvent" runat="server"
                PopupControlID="pnlPopupEvent" TargetControlID="lnkDummyEvent" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyEvent" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupEvent" style="width: 50%;">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Modifica Evento</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Nome</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtName" />
                                </div>
                            </div>
                           <div class="form-group">
                                <br />
                                <Label class="col-lg-7 control-label">Data</Label>
                                <Label class="col-lg-2 control-label">Ore</Label>
                                <Label class="col-lg-3 control-label">Min</Label>
                                <div class="col-lg-7">
                                    <asp:TextBox runat="server" Width="280px" ID="txtStartDate" CssClass="form-control input-sm"  />
                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                </div>
                                <div class="col-lg-2">
                                    <asp:TextBox ID="txtHour" TextMode="Number" Width="50" runat="server" CssClass="form-control input-sm"></asp:TextBox> 
                                </div>
                                <div class="col-lg-3">
                                    <asp:TextBox ID="txtMin" TextMode="Number" Width="50" runat="server" CssClass="form-control input-sm"></asp:TextBox> 
                                </div>
                                <br />
                            </div>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Durata(ore)</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" TextMode="Number" Width="280" CssClass="form-control input-sm" ID="txtDurata" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Evento pubblico?</label>
                                <div class="col-lg-10">
                                    <asp:CheckBox runat="server" ID="chkPublic" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Luogo</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtSite" />
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Descrizione</label>
                                <div class="col-lg-12">
                                    <textarea runat="server" class="form-control input-sm" rows="3" id="txtDescription"></textarea>
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Progetto correlato</label>
                                <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
                                    <ContentTemplate>
                                            <div class="form-group col-lg-5">
                                                <asp:TextBox runat="server" Width="250px" ID="txtProjectName" CssClass="form-control" />
                                                
                                            </div>
                                            <div class="input-group-btn">
                                                <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="Lista" OnClick="btnShowPopup_Click" CausesValidation="false" />
                                            </div>
                                        <asp:AutoCompleteExtender
                                            ServiceMethod="GetProjectNames" ServicePath="/AutoComplete.asmx"
                                            ID="txtProjectAutoCompleter" runat="server"
                                            Enabled="True" TargetControlID="txtProjectName" UseContextKey="True"
                                            MinimumPrefixLength="2">
                                        </asp:AutoCompleteExtender>
                                        <br />


                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div runat="server" visible="false" id="showChooseProject">
                                <asp:GridView SelectMethod="GetProjects" ID="OpenedProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                ItemType="VALE.Models.Project" EmptyDataText="Nessun progetto aperto." CssClass="table table-striped table-bordered">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="ProjectName" CommandName="sort" runat="server" ID="labelProjectName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.ProjectName %></asp:Label></div></center>
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
                                            <center><div><asp:LinkButton CommandArgument="CreationDate" CommandName="sort" runat="server" ID="labelCreationDate"><span  class="glyphicon glyphicon-calendar"></span> Data Creazione</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                        </ItemTemplate>
                                        <HeaderStyle Width="150px" />
                                        <ItemStyle Width="150px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:LinkButton CommandArgument="Status" CommandName="sort" runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server"><%#: Item.Status %></asp:Label></div></center>
                                        </ItemTemplate>
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:Label runat="server" ID="labelAdd"><span  class="glyphicon glyphicon-saved"></span> Aggiungi</asp:Label></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Button runat="server" CausesValidation="false" Width="120" CommandArgument="<%#: Item.ProjectName %>" Text="Aggiungi" CssClass="btn btn-info btn-xs" ID="btnChooseProject" OnClick="btnChooseProject_Click" /></div></center>
                                        </ItemTemplate>
                                        <HeaderStyle Width="120" />
                                        <ItemStyle Width="120" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
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
                            <asp:Button runat="server" Text="Crea" ID="btnConfirmModify" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="btnConfirmModify_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" OnClick="btnClosePopUpButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
