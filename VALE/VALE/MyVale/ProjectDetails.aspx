<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectDetails.aspx.cs" Inherits="VALE.MyVale.ProjectDetails" %>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio progetto"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Button CausesValidation="false" runat="server" ID="btnWorkOnThis" OnClick="btnWorkOnThis_Click" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body">

                            <asp:FormView Width="100%" OnDataBound="ProjectDetail_DataBound" runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetProject">
                                <ItemTemplate>
                                    <div class="col-md-11">
                                        <h3><%#: Item.ProjectName %></h3>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Creatore: </asp:Label><asp:Label runat="server"><%#: Item.Organizer.FullName %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Data: </asp:Label><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Ultima modifica: </asp:Label><asp:Label runat="server"><%#: Item.LastModified.ToShortDateString() %></asp:Label>
                                        <br />
                                        <asp:Label runat="server"  Font-Bold="true">Tipo: </asp:Label><asp:Label runat="server" ><%#: Item.Type %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Visibilita': </asp:Label><asp:Label runat="server"><%#: Item.Public ? "Pubblica" : "Privata" %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Stato: </asp:Label><asp:Label runat="server"><%#: Item.Status.ToUpperInvariant() %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Descrizione: </asp:Label><asp:Label ID="lblContent" runat="server"></asp:Label>
                                        <br />
                                        <asp:FormView runat="server" ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                                            <EmptyDataTemplate>
                                                <asp:Label runat="server" Font-Bold="true">Progetto correlato: </asp:Label><asp:Label runat="server" Text="Nessun progetto correlato"></asp:Label>
                                            </EmptyDataTemplate>
                                            <ItemTemplate>
                                                <asp:Label runat="server" Font-Bold="true">Progetto correlato: </asp:Label>
                                                <a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>">
                                                    
                                                    <asp:Label runat="server" Text="<%#: Item.ProjectName %>"></asp:Label></a><br />
                                            </ItemTemplate>
                                        </asp:FormView>

                                    </div>
                                    <div class="col-md-1">
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:Button CausesValidation="false" ID="btnModifyProject" Visible="false" CssClass="btn btn-danger" runat="server" Text="Modifica" OnClick="btnModifyProject_Click" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>

                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
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
                                                                                <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;Conversazioni</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button CausesValidation="false" CssClass="btn btn-success btn-sm" runat="server" ID="btnAddIntervention" OnClick="btnAddIntervention_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView OnRowCommand="grdInterventions_RowCommand" OnRowCreated="grdInterventions_RowCreated" DataKeyNames="InterventionId" ItemType="VALE.Models.Intervention" GridLines="Both" AllowSorting="true"
                                                                SelectMethod="GetInterventions" runat="server" ID="grdInterventions" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="InterventionText" CommandName="sort" runat="server" ID="labelInterventionText"><span  class="glyphicon glyphicon-credit-card"></span> Intervento</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: String.IsNullOrEmpty(Item.InterventionText) ? "Nessun commento scritto inserito." : (Item.InterventionText.Length >= 40 ? Item.InterventionText.Substring(0,40) + "..." : Item.InterventionText) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="CreatorUserName" CommandName="sort" runat="server" ID="labelCreatorUserName"><span  class="glyphicon glyphicon-user"></span> Creatore</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="AttachedFiles" CommandName="sort" runat="server" ID="labelDocumentsPath"><span  class="glyphicon glyphicon-paperclip"></span> Ha allegati</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: ContainsDocuments(Item.InterventionId) ? "SI" : "NO" %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:Label runat="server" ID="labelDetails"><span  class="glyphicon glyphicon-open"></span> Dettagli</asp:Label></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Button CssClass="btn btn-info btn-xs" Width="90" runat="server" CommandName="ViewIntervention"
                                                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Visualizza" /></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField Visible="false" HeaderText="DELETE ROW">
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:Label runat="server" ID="labelDelete"><span  class="glyphicon glyphicon-remove"></span> Cancella</asp:Label></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Button CssClass="btn btn-danger btn-xs" Width="90" runat="server" CommandName="DeleteIntervention"
                                                                    CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Cancella" /></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px" />
                                                                        <ItemStyle Width="90px" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <EmptyDataTemplate>
                                                                    <asp:Label runat="server">Non ci sono conversazioni</asp:Label>
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
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Collaboratori</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button id="btnAddUsers" Visible="false" runat="server" OnClick="addUsers_Click" CssClass="btn btn-info btn-sm" Text="Gestione utenti" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                SelectMethod="GetRelatedUsers" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessun collaboratore</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-8">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-flash"></span>&nbsp;&nbsp;Eventi correlati</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button CausesValidation="false" CssClass="btn btn-success btn-sm" Text="Aggiungi evento" ID="btnAddEvent" runat="server" OnClick="btnAddEvent_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ItemType="VALE.Models.Event" OnRowDataBound="GridView1_RowDataBound" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                SelectMethod="GetRelatedEvents" DataKeyNames="EventId" runat="server" ID="GridView1" CssClass="table table-striped table-bordered">
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
                                                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server" ID="lblContentEvent"></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="EventDate" CommandName="sort" runat="server" ID="labelEventDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessun evento correlato</asp:Label>
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
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-list"></span>&nbsp;&nbsp;Attività correlate</li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button CssClass="btn btn-success btn-sm" Text="Aggiungi attività" ID="btnAddActivity" runat="server" OnClick="btnAddActivity_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView ItemType="VALE.Models.Activity" OnRowDataBound="ActivitiesGridView_RowDataBound" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                SelectMethod="GetRelatedActivities" runat="server" DataKeyNames="ActivityId" ID="ActivitiesGridView" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="CreatorUserName" CommandName="sort" runat="server" ID="labelCreatorUserName"><span  class="glyphicon glyphicon-user"></span> Creatore</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelActivityName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.ActivityName %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server" ID="lblContentActivity"></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Status" CommandName="sort" runat="server" ID="labelStatus"><span  class="glyphicon glyphicon-tasks"></span> Stato</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: GetStatus(Item) %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Nessuna attività correlata.</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                    <uc:FileUploader ID="FileUploader" runat="server" />

                                    <h4>Gestisci progetto</h4>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Button runat="server" ID="btnSuspendProject" CausesValidation="false" OnClick="btnSuspendProject_Click" />
                                            <asp:Button runat="server" ID="btnCloseProject" CausesValidation="false" OnClick="btnCloseProject_Click" /><br />
                                            <asp:Label ID="lblInfoOperation" runat="server" Visible="false"></asp:Label><br />

                                            <asp:ModalPopupExtender ID="ModalPopup" runat="server"
                                                PopupControlID="pnlPopup" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
                                            </asp:ModalPopupExtender>
                                            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                                            <div class="alert alert-dismissable alert-info" id="pnlPopup" style="width: 25%;">
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
                                                            <asp:Button runat="server" Text="Ok" ID="btnFilterProjects" CssClass="btn btn-success btn-xs" OnClick="btnModifyStatusProject_Click" />
                                                            <asp:Button runat="server" Text="Annulla" ID="btnClearFilters" CssClass="btn btn-danger btn-xs" OnClick="CloseButton_Click" />
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
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
            <asp:ModalPopupExtender ID="ModalPopupProject" runat="server"
                PopupControlID="pnlPopupProject" TargetControlID="lnkDummyProject" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyProject" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupProject" style="width: 80%;">
                
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Modifica Progetto</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Nome</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" CssClass="form-control" ID="txtName" />
                                </div>
                            </div>
                           <div class="form-group">
                                <br />
                                <Label class="col-lg-7 control-label">Data</Label>
                                <div class="col-lg-7">
                                    <asp:TextBox runat="server" Width="280px" ID="txtStartDate" CssClass="form-control"  />
                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                </div>
                                <br />
                            </div>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Progetto pubblico?</label>
                                <div class="col-lg-10">
                                    <asp:CheckBox runat="server" ID="chkPublic" />
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Descrizione</label>
                                <div class="col-lg-12">
                                    <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtDescription" runat="server"></asp:TextBox>
                                    <asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtDescription">
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
                            </div>
                            <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Tipo Progetto</asp:Label>
                                <div class="col-md-12">
                                    <asp:DropDownList  class="form-control" runat="server"  ID="ddlSelectType" SelectMethod="GetTypes" Width="404px" ItemType="VALE.Models.ProjectType" DataTextField="ProjectTypeName" DataValueField="ProjectTypeName"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlSelectType" CssClass="text-danger" ErrorMessage="" />
                                </div>
                            <br />
                            <br />
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Progetto correlato</label>
                                <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
                                    <ContentTemplate>
                                        <div class="col-lg-12">
                                            <div class="input-group col-md-3">
                                                <div class="form-group">
                                                    <asp:TextBox runat="server" Width="250px" ID="txtProjectName" CssClass="form-control" />

                                                </div>
                                                <div class="input-group-btn">
                                                    <asp:Button CssClass="btn btn-primary" ID="Button1" runat="server" Text="Lista" OnClick="btnShowPopup_Click" CausesValidation="false" />
                                                </div>
                                            </div>
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
                            <div class="row">
                                <div class="col-lg-12">
                                    <br />
                                    </div>
                            </div>
                            <div runat="server" visible="false" id="showChooseProject" class="panel panel-default" style="max-height: 200px; overflow: auto;">
                                <div class="panel-body">
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
