<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EventDetails.aspx.cs" Inherits="VALE.MyVale.EventDetails" %>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>
<%@ Register Src="~/MyVale/GridPager.ascx" TagPrefix="asp" TagName="GridPager" %>
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
                                        <asp:Label runat="server" Font-Bold="true">Utenti Partecipanti: </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.RegisteredUsers.Count()) %></asp:Label>
                                        <br />
                                        <asp:Label runat="server" Font-Bold="true">Utenti In Attesa Di Adesione: </asp:Label><asp:Label runat="server"><%#: String.Format("{0}", Item.PendingUsers.Count()) %></asp:Label>
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
                                    </div>  <%--Progetto correlato--%>
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
                                                                        <asp:LinkButton CausesValidation="false" CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton>
                                                                    </div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div>
                                                                    <a href="/Account/Profile?Username=<%#: Item.UserName %>"><asp:Label runat="server"><%#: Item.FullName %></asp:Label></a>
                                                                </div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div>
                                                                    <asp:LinkButton CommandArgument="Email" CausesValidation="false" CommandName="sort" runat="server" ><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton>
                                                                </div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div>
                                                                    <asp:Label runat="server"><%#: Item.Email %></asp:Label>
                                                                </div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" CommandName="sort" runat="server" ><span  class="glyphicon glyphicon-ok-sign"></span> Stato</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: GetStatusOfEventRequest(Item) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="10%" />
                                                                        <ItemStyle Width="10%" />
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
                                    </div>  <%--Partecipanti--%>
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
                                                                        <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</li>
                                                                </ul>
                                                            </div>
                                                            <div class="navbar-right">
                                                                <asp:Button runat="server" CausesValidation="false" Text="Aggiungi Documento" CssClass="btn btn-success btn-xs" ID="btnAddDocument" OnClick="btnAddDocument_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                        ItemType="VALE.MyVale.AttachedFileGridView" AllowPaging="true" PageSize="10" EmptyDataText="Non ci sono file allegati."
                                                        CssClass="table table-striped table-bordered" AllowSorting="true"
                                                        OnRowCommand="grdFilesUploaded_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileName"><span  class="glyphicon glyphicon-file"></span> Nome File</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:LinkButton ToolTip="<%# Item.FileName %>"  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD_FILE" CausesValidation="false"><%#: Item.FileName.Length < 20 ? Item.FileName : Item.FileName.Substring(0, 18) + "..." %></asp:LinkButton></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="25%"></HeaderStyle>
                                                                <ItemStyle Width="25%"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileExtension"><span  class="glyphicon glyphicon-tag"></span> Tipo</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><%#: Item.FileExtension %></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="70px"></HeaderStyle>
                                                                <ItemStyle Width="70px"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="FileDescription"><span class="glyphicon glyphicon-list"></span> Descrizione</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server" ToolTip="<%#: Item.FileDescription%>"><%#: Item.FileDescription.Length < 20 ? Item.FileDescription : Item.FileDescription.Substring(0, 18) + "..." %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="Owner"><span  class="glyphicon glyphicon-user"></span> Autore</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><a href="/Account/Profile?Username=<%#: Item.Owner %>"><asp:Label runat="server"><%#: Item.Owner %></asp:Label></a></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="15%"></HeaderStyle>
                                                                <ItemStyle Width="15%"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="VersionCount"><span class="glyphicon glyphicon-list-alt"></span> Versioni</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.FileName %>" CommandName="SHOW_VERSIONS" CausesValidation="false"><span runat="server" class="badge"><%#: Item.VersionCount %></span></asp:LinkButton></div></center>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                                <ItemStyle Width="100px"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CausesValidation="false" runat="server" CommandName="Sort" CommandArgument="CreationDate"><span  class="glyphicon glyphicon-th"></span> Data</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="115px"></HeaderStyle>
                                                                <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <div>
                                                                            <asp:LinkButton ID="btnDownloadFile" ToolTip="Scarica il file" runat="server" CausesValidation="false" CommandName="DOWNLOAD_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-success"><span class="glyphicon glyphicon-save"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton ID="btnShowDiscription" ToolTip="Visualiza informazione del file" runat="server" CausesValidation="false" CommandName="SHOW_DESC" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-primary"><span class="glyphicon glyphicon-info-sign"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton ID="btnUpdateFile" ToolTip="Aggiorna il file" runat="server" CausesValidation="false" CommandName="UPDATE_FILE" CommandArgument="<%# Item.FileName %>"><span class="label label-default"><span class="glyphicon glyphicon-refresh"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton ID="btnShowVersions" ToolTip="Visualiza i versioni del file" runat="server" CausesValidation="false" CommandName="SHOW_VERSIONS" CommandArgument="<%# Item.FileName %>"><span class="label label-info"><span class="glyphicon glyphicon-list-alt"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton ID="btnDeleteFile" ToolTip="Cancella il file" runat="server" Visible='<%# AllowUpdateOrDelete(Convert.ToInt32(Eval("AttachedFileID"))) %>' CausesValidation="false" CommandName="DELETE_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                                                        </div>
                                                                    </center>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CausesValidation="false" runat="server" ><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="155px"></HeaderStyle>
                                                                <ItemStyle Width="155px"></ItemStyle>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <PagerSettings Position="Bottom" />
                                                        <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                    </asp:GridView>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>   <%--Documenti Allegati--%>                                  
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
                                    <asp:TextBox CssClass="form-control" TextMode="MultiLine" Height="150px" ID="txtDescription" runat="server"></asp:TextBox>
                               <%--     <asp:HtmlEditorExtender EnableSanitization="false" runat="server" TargetControlID="txtDescription">
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
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupAddDocument" runat="server"
                PopupControlID="pnlPopupAddDocument" TargetControlID="lnkDummyPopupAddDocument" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupAddDocument" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupAddDocument" style="width: 60%;">
                <asp:Label runat="server" ID="lblOperatioPopupAddDocument" visible="false" />
                <div class="row">
                    <div class="col-md-12">
                        <legend><asp:Label runat="server" ID="lblInfoPopupAddDocument"/></legend>
                    </div>
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server"></asp:ValidationSummary>
                    </div>
                    <div  runat="server" id="divDocunetPopupAddDocument">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Documento </label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblFileNamePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-md-2 control-label">Versione </label>
                                <div class="col-md-10">
                                    <asp:Label ID="lblVersionPopupAddDocument" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                    <div  runat="server" id="divInfoPopupAddDocument">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Dimensione </label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblSizeFilePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Data</label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblDatePopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Data</label>
                                    <div class="col-md-10">
                                        <asp:Label ID="lblHourPopupAddDocument" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" runat="server" id="divFileUploderPopupAddDocument">
                        <label class="col-md-2 control-label">File *</label>
                        <div class="col-md-10">
                            <asp:FileUpload ID="FileUploadAddDocument" runat="server" CssClass="well well-sm"></asp:FileUpload>
                            <asp:Label ID="LabelPopUpAddDocumentError" CssClass="text-danger" runat="server" Visible="false"></asp:Label>
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="col-md-2 control-label">Descrizione *</label>
                        <div class="col-md-10">
                            <asp:TextBox CssClass="form-control input-sm" TextMode="MultiLine" Height="150px" ID="txtFileDescription" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFileDescription" ID="validatorFileDescription" CssClass="text-danger" ValidationGroup="AddDocumentPopUp" ErrorMessage="Il campo Descrizione è obbligatorio." />
                        </div>
                    </div>
        
                    <div class="col-md-12">
                        <br />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-9 col-md-10">
                            <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpAddDocument" CssClass="btn btn-success btn-sm" ValidationGroup="AddDocumentPopUp" OnClick="btnPopUpAddDocument_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnPopUpAddDocumentClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpAddDocumentClose_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnPopUpAddDocument" />
        </Triggers>
    </asp:UpdatePanel> <%--ModalPopupAddDocument--%>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupViewFileVersions" runat="server"
                PopupControlID="pnlPopupViewFileVersions" TargetControlID="lnkDummyPopupViewFileVersions" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPopupViewFileVersions" runat="server"></asp:LinkButton>
            <div class="panel panel-default" id="pnlPopupViewFileVersions" style="width: 80%;">
                <div class="panel-heading">
                    <asp:LinkButton ID="btnClosePopupViewFileVersions" CausesValidation="false" runat="server" class="close" OnClick="btnClosePopupViewFileVersions_Click">×</asp:LinkButton>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-8">
                                <ul class="nav nav-pills">
                                    <li>
                                        <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Versioni de file : <asp:Label runat="server" ID="lblFileNamePopupViewFileVersions" /></li>
                                </ul>
                            </div>
                            <div class="navbar-right">
                                <%-- <asp:Button runat="server" CausesValidation="false" Text="Aggiungi Documento" CssClass="btn btn-success btn-xs"  />--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                    <asp:GridView ID="ViewFileVersionsGridView" runat="server" AutoGenerateColumns="False"
                        ItemType="VALE.Models.AttachedFile" EmptyDataText="Non ci sono file allegati."
                        CssClass="table table-striped table-bordered"
                        OnRowCommand="ViewFileVersionsGridView_RowCommand">
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-barcode"></span> Versione</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD" CausesValidation="false"><span runat="server" class="badge"><%#: Item.Version %></span></asp:LinkButton></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                                <ItemStyle Width="100px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-tag"></span> Tipo</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><%#: Item.FileExtension %></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="70px"></HeaderStyle>
                                <ItemStyle Width="70px"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span class="glyphicon glyphicon-list"></span> Descrizione</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><asp:Label runat="server" ToolTip="<%#: Item.FileDescription%>"><%#: Item.FileDescription.Length < 20 ? Item.FileDescription : Item.FileDescription.Substring(0, 18) + "..." %></asp:Label></div></center>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-user"></span> Autore</div></center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <center><div><a href="/Account/Profile?Username=<%#: Item.Owner %>"><asp:Label runat="server"><%#: Item.Owner %></asp:Label></a></div></center>
                                </ItemTemplate>
                                <HeaderStyle Width="20%"></HeaderStyle>
                                <ItemStyle Width="20%"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-th"></span> Data</div></center>
                                </HeaderTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                                <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <center>
                                        <div>
                                            <asp:LinkButton ID="btnDownloadClick" runat="server" CausesValidation="false" CommandName="DOWNLOAD_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-success"><span class="glyphicon glyphicon-save"></span></span></asp:LinkButton>
                                            <asp:LinkButton ID="btnShowDiscClick" runat="server" CausesValidation="false" CommandName="SHOW_DESC" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-primary"><span class="glyphicon glyphicon-info-sign"></span></span></asp:LinkButton>
                                            <asp:LinkButton ID="btnDeleteClick" runat="server" Visible='<%# AllowUpdateOrDelete(Convert.ToInt32(Eval("AttachedFileID"))) %>' CausesValidation="false" CommandName="DELETE_FILE" CommandArgument="<%# Item.AttachedFileID %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                        </div>
                                    </center>
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <center><div><span  class="glyphicon glyphicon-cog"></span> Azioni</div></center>
                                </HeaderTemplate>
                                <HeaderStyle Width="115px"></HeaderStyle>
                                <ItemStyle Width="115px"></ItemStyle>
                            </asp:TemplateField>
                        </Columns>

                    </asp:GridView>

                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel> <%--ModalPopupViewFileVersions--%>
</asp:Content>
