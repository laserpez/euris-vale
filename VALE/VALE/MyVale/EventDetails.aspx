<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="VALE.MyVale.EventDetails" %>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>
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
                                <div class="col-md-6">
                                    <asp:Button ID="btnBack" ToolTip="Torna indietro" runat="server" CausesValidation="false" CssClass="btn btn-primary col-md-1" Font-Bold="true" Text="&#171;" OnClick="btnBack_Click" />
                                    <div class="col-lg-11">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettagli evento"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-6">
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
                                        <asp:Label runat="server" Font-Bold="true">Visibilita': </asp:Label><asp:Label runat="server"><%#: Item.Public ? "Pubblica" : "Privata" %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Luogo: </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.Site) %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Descrizione: </asp:Label><asp:Label ID="lblContent" runat="server"></asp:Label>
                                        <br />
                                        
                                        <br />
                                    </div>
                                    <div class="col-md-1">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Button CausesValidation="false" ID="btnModifyEvent" Visible="false" CssClass="btn btn-primary" runat="server" Text="Modifica" OnClick="btnModifyEvent_Click" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <br />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="col-md-8">
                                                                <ul class="nav nav-pills">
                                                                    <li>
                                                                        <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Progetto correlato</li>
                                                                </ul>
                                                            </div>
                                                            <div class="navbar-right">
                                                                <asp:Button runat="server" Text="Elimina" ID="btnDeleteRelatedProject" CssClass="btn btn-danger btn-xs" CausesValidation="false" OnClick="btnDeleteRelatedProject_Click" />
                                                                <asp:Button runat="server" Text="Aggiungi" ID="btnAddRelatedProject" CssClass="btn btn-success btn-xs" CausesValidation="false" OnClick="btnAddRelatedProject_Click"  />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:GridView ItemType="VALE.Models.Project" DataKeyNames="ProjectId"  AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                        SelectMethod="GetRelatedProject" AllowPaging="true" PageSize="10" runat="server" ID="grdRelatedProject" CssClass="table table-striped table-bordered">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelProjectName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>">
                                                                    <asp:Label runat="server" Text="<%#: Item.ProjectName %>"></asp:Label></a></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label ID="lblContentRelatedProject" runat="server"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelCreationDate"><span  class="glyphicon glyphicon-calendar"></span> Data Creazione</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="150px" />
                                                                <ItemStyle Width="150px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" ID="labelType"><span  class="glyphicon glyphicon-th"></span> Tipo</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.Type.Length >= 20 ? Item.Type.Substring(0,20) + "..." : Item.Type %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="90px" />
                                                                <ItemStyle Width="90px" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.Status %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="90px" />
                                                                <ItemStyle Width="90px" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerSettings Position="Bottom" />
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                        <EmptyDataTemplate>
                                                            <asp:Label runat="server">Nessun Progetto correlato </asp:Label>
                                                        </EmptyDataTemplate>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
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
                                                                <asp:Button ID="btnAddUsers" runat="server" CausesValidation="false" Visible="false" OnClick="addUsers_Click" CssClass="btn btn-info btn-xs" Text="Aggiungi/Rimuovi" />
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true" AllowPaging="true" PageSize="10"
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
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
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
            <div class="well bs-component" id="pnlPopupEvent" style="width: 80%;">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Modifica Evento</legend>
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Nome *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtName" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il nome è obbligatorio" />
                                </div>
                            </div>
                           
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="col-lg-2 control-label">Data *</label>
                                        <div class="col-lg-4">
                                            <asp:TextBox runat="server" Width="280px" ID="txtStartDate" CssClass="form-control " />
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtStartDate" CssClass="text-danger" ErrorMessage="La data è obbligatoria" />
                                            <asp:RegularExpressionValidator runat="server" ValidationExpression="\d{1,2}/\d{1,2}/\d{4}" CssClass="text-danger" ErrorMessage="Il formato della data non è corretto." ControlToValidate="txtStartDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                        </div>
                                        <label class="col-lg-1 control-label">Ore</label>
                                        <div class="col-lg-2">
                                            <asp:TextBox ID="txtHour" TextMode="Number" Width="80" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <label class="col-lg-1 control-label">Min</label>
                                        <div class="col-lg-2">
                                            <asp:TextBox ID="txtMin" TextMode="Number" Width="80" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <br />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Durata(ore)</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" TextMode="Number" Width="280" CssClass="form-control" ID="txtDurata" />
                                    <br />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Luogo *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtSite" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSite" CssClass="text-danger" ErrorMessage="Il luogo è obbligatorio" /> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Evento pubblico?</label>
                                <div class="col-lg-10">
                                    <asp:CheckBox runat="server" ID="chkPublic" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <br />
                                </div>
                                <div class="col-md-12">
                                      <label class="col-lg-2 control-label">Descrizione *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox CssClass="form-control" TextMode="MultiLine" Height="100px" ID="txtDescription" runat="server"></asp:TextBox>
                                    <%--<asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtDescription">
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
                                    </asp:HtmlEditorExtender>--%>
                                </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                              
                            </div>
                            <br />
                            <br />
                            
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-10 col-md-12">
                            <asp:Button runat="server" Text="Salva" ID="btnConfirmModify" CssClass="btn btn-success btn-sm" CausesValidation="false"  OnClick="btnConfirmModify_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnClosePopUpButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupListProject" runat="server"
                PopupControlID="pnlListProject" TargetControlID="lnkDummy1" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummy1" runat="server"></asp:LinkButton>
            <div class="panel panel-primary" id="pnlListProject" style="width: 80%;">
                <div class="panel-heading">
                    <asp:Label ID="TitleMpdalView" runat="server" Text="Lista progetti"></asp:Label>
                    <asp:Button runat="server" CssClass="close" CausesValidation="false" OnClick="Unnamed_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 500px; overflow: auto;">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <asp:UpdatePanel runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:GridView SelectMethod="GetProjects" AllowPaging="true" PageSize="10" DataKeyNames="ProjectId" ID="OpenedProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
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
                                                    <center><div><asp:Label ID="lblContentOpenProjects" runat="server"><%#:GetDescription(Item.Description) %></asp:Label></div></center>
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
                                        <PagerSettings Position="Bottom" />
                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
