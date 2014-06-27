<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectDetails.aspx.cs" Inherits="VALE.MyVale.ProjectDetails" %>

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
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio progetto"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:FormView Width="100%" OnDataBound="ProjectDetail_DataBound" runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetProject">
                                <ItemTemplate>
                                    <asp:Label runat="server"><%#: String.Format("Titolo:\t{0}", Item.ProjectName.ToUpper()) %></asp:Label><br />
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Label runat="server"><%#: "Pubblico: " %></asp:Label><asp:CheckBox ID="checkboxPublic" runat="server" AutoPostBack="true" OnCheckedChanged="checkboxPublic_CheckedChanged" /><br />
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    <asp:Label runat="server"><%#: String.Format("Stato:\t{0}", Item.Status.ToUpperInvariant()) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Descrizione:\t{0}", Item.Description) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Creatore:\t{0}", Item.Organizer.FullName) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Data:\t{0}", Item.CreationDate.ToShortDateString()) %></asp:Label><br />
                                    <asp:Label runat="server"><%#: String.Format("Ultima modifica:\t{0}", Item.LastModified.ToShortDateString()) %></asp:Label><br />

                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <h4>Collabora</h4>
                                            <asp:Button CausesValidation="false" runat="server" ID="btnWorkOnThis" OnClick="btnWorkOnThis_Click" />
                                            <asp:Button CausesValidation="false"  runat="server" ID="btnAddIntervention" OnClick="btnAddIntervention_Click" />
                                            <h4>Interventi</h4>
                                            <asp:GridView OnRowCommand="grdInterventions_RowCommand" DataKeyNames="InterventionId" ItemType="VALE.Models.Intervention" GridLines="Both" AllowSorting="true"
                                                SelectMethod="GetInterventions" runat="server" ID="grdInterventions" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="InterventionText" CommandName="sort" runat="server" ID="labelInterventionText"><span  class="glyphicon glyphicon-credit-card"></span> Intervento</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.InterventionText %></asp:Label></div></center>
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
                                                            <center><div><asp:LinkButton CommandArgument="DocumentsPath" CommandName="sort" runat="server" ID="labelDocumentsPath"><span  class="glyphicon glyphicon-paperclip"></span> Ha allegati</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: ContainsDocuments(Item.DocumentsPath) ? "SI" : "NO" %></asp:Label></div></center>
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
                                                </Columns>
                                                <EmptyDataTemplate>
                                                    <asp:Label runat="server">Non ci sono interventi</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>

                                            <h4>Collaboratori</h4>
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
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                    <h4>Progetto correlato</h4>
                                    <asp:FormView runat="server" ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                                        <EmptyDataTemplate>
                                            <asp:Label runat="server" Text="Nessun progetto correlato"></asp:Label>
                                        </EmptyDataTemplate>
                                        <ItemTemplate>
                                            <a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>"><%#: Item.ProjectName %></a><br />
                                        </ItemTemplate>
                                    </asp:FormView>

                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <h4>Eventi correlati</h4>
                                            <asp:Button CausesValidation="false" CssClass="btn btn-success btn-sm" Text="Aggiungi evento" ID="btnAddEvent" runat="server" OnClick="btnAddEvent_Click" />
                                            <asp:GridView ItemType="VALE.Models.Event" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
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
                                                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
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

                                            <h4>Attività correlate</h4>
                                            <asp:Button CssClass="btn btn-success btn-sm" Text="Aggiungi attività" ID="btnAddActivity" runat="server" OnClick="btnAddActivity_Click" />
                                            <asp:GridView ItemType="VALE.Models.Activity" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                SelectMethod="GetRelatedActivities" runat="server" ID="ActivitiesGridView" CssClass="table table-striped table-bordered">
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
                                                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
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
                                                    <asp:Label runat="server">Nessuna ttività correlata.</asp:Label>
                                                </EmptyDataTemplate>
                                            </asp:GridView>

                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                    <%--<asp:Label runat="server" ID="attachmentsLabel" Text="Allegati" CssClass="h4"></asp:Label>
                                    <asp:ListBox runat="server" CssClass="form-control" Width="400px" ID="lstDocuments" SelectMethod="GetRelatedDocuments"></asp:ListBox>
                                    <asp:Button runat="server" Text="Scarica" CssClass="btn btn-info" ID="btnViewDocument" OnClick="btnViewDocument_Click" />--%>

                                    <%--****************************************************PARTE UPLOAD FILE**********************************************--%>
                                    <h4>Documenti Allegati</h4>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="panel panel-default">
                                                <div class="panel-heading"><span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Documenti Allegati</div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:Label ID="allowDelete" runat="server" Text="PROJECT" Visible="false"></asp:Label>
                                                    <asp:Label ID="action" runat="server" Text="CREATE" Visible="false"></asp:Label>
                                                    <asp:Label ID="id" runat="server" Text="" Visible="false"></asp:Label>
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ID="DocumentsGridView" runat="server" AutoGenerateColumns="False" SelectMethod="DocumentsGridView_GetData"
                                                                ItemType="VALE.Models.AttachedFile"
                                                                CssClass="table table-striped table-bordered"
                                                                OnRowCommand="grdFilesUploaded_RowCommand">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="FileName" HeaderStyle-Width="25%">
                                                                        <ItemTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" CommandArgument="<%# Item.AttachedFileID %>" CommandName="DOWNLOAD" CausesValidation="false"><%#: Item.FileName %></asp:LinkButton></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                                        <ItemStyle Width="50px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="FileDescription" HeaderText="Descrizione" HeaderStyle-Width="70%"/>
                                                                    <asp:BoundField DataField="Owner" HeaderText="Autore" HeaderStyle-Width="15%" />
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
                                                                    <asp:TemplateField HeaderText="Azione" HeaderStyle-Width="50px" ItemStyle-Width="50px">
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Button  runat="server" Text="Cancella"  CssClass="btn btn-danger btn-xs" CommandArgument="<%# Item.AttachedFileID %>" CommandName="Cancella" CausesValidation="false" /></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                                        <ItemStyle Width="50px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                                <div class="panel-footer" id="FooterDocuments" runat="server">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="form-group col-lg-5">
                                                                <div class="input-group">
                                                                    <span class="input-group-addon input-sm"><span class="glyphicon glyphicon-file"></span></span>
                                                                    <div runat="server" id="FileTextBox">
                                                                        <asp:FileUpload ID="FileUpload" runat="server" CssClass="form-control input-sm" />
                                                                    </div>
                                                                    <span class="input-group-btn">
                                                                        <asp:Button runat="server" ID="AddFileNameButton" ValidationGroup="UploadFile" CssClass="btn btn-default btn-sm" Text="Aggiungi" OnClick="AddFileNameButton_Click" />
                                                                    </span>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-lg-12">
                                                            <asp:Label ID="Label1" runat="server" Text="Label">Deacrizione * </asp:Label>
                                                            <asp:TextBox ID="txtFileDescription" runat="server" CssClass="form-control" Width="300px"></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server"  ValidationGroup="UploadFile" ControlToValidate="txtFileDescription" CssClass="text-danger" ErrorMessage="Il campo Descrizione è richiesto." />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <%--****************************************************PARTE UPLOAD FILE**********************************************--%>
                                    <h4>Gestisci progetto</h4>
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <asp:Label runat="server" ID="lblInfoManage" Text="Cambia lo stato del tuo progetto"></asp:Label><br />
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
                                                            <asp:Button runat="server" Text="Ok" ID="btnFilterProjects" CssClass="btn btn-success btn-xs" OnClick="btnModifyProject_Click" />
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
</asp:Content>
