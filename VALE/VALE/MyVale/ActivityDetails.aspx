<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="ActivityDetails.aspx.cs" Inherits="VALE.MyVale.ActivityDetails" %>
<%@ Register Src="~/MyVale/Create/SelectProject.ascx" TagPrefix="uc" TagName="SelectProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:FormView runat="server" ID="ActivityDetail" OnDataBound="ActivityDetail_DataBound" Width="100%" ItemType="VALE.Models.Activity" SelectMethod="GetActivity">
                        <ItemTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <asp:Button ID="btnBack" ToolTip="Torna indietro" runat="server" CausesValidation="false" CssClass="btn btn-primary col-md-1" Font-Bold="true" Text="&#171;" OnClick="btnBack_ServerClick" />
                                            <div class="col-lg-11">
                                                <ul class="nav nav-pills">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Dettaglio attività"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="navbar-right">
                                                <asp:Label ID="ListUsersType" Visible="false" runat="server" Text=""></asp:Label>
                                                <div class="btn-group">
                                                    <button type="button" visible="true"  id="btnStatus" class="<%#: GetStatusColor(Item.Status) %>"  data-toggle="dropdown" runat="server"><%#: GetStatus(Item) %><span class="caret"></span></button>
                                                    <ul class="dropdown-menu">
                                                        <li>
                                                            <asp:LinkButton CommandArgument="ToBePlanned" Visible='<%# ModifyToBePlannedStatusAcces() %>' runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-share-alt"></span> Da Pianificare</asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton CommandArgument="Ongoing" runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-play"></span>  In Corso  </asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton CommandArgument="Suspended" runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-pause"></span> Sospeso  </asp:LinkButton></li>
                                                        <li>
                                                            <asp:LinkButton CommandArgument="Done" runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-stop"></span> Terminato</asp:LinkButton></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-md-11">
                                                <h3><%#: Item.ActivityName %></h3>
                                                <br />
                                                <asp:Label runat="server" Font-Bold="true">Creatore: </asp:Label><asp:Label runat="server"><%#: Item.Creator.FullName %></asp:Label>
                                                <br />
                                                <asp:Label runat="server" Font-Bold="true">Data creazione: </asp:Label><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label>
                                                <br />
                                                <asp:Label runat="server" Font-Bold="true">Data Inizio: </asp:Label><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita"%></asp:Label>
                                                <br />
                                                <asp:Label runat="server" Font-Bold="true">Data Fine: </asp:Label><asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita" %></asp:Label>
                                                <br />
                                                <asp:Label runat="server" Font-Bold="true">Tipo: </asp:Label><asp:Label runat="server"><%#: Item.Type %></asp:Label>
                                                <br />
                                                <asp:Label runat="server" Font-Bold="true">Stato: </asp:Label><asp:Label runat="server"><%#:  GetStatus(Item) %></asp:Label>
                                                <br />
                                                 <asp:Label runat="server" id="lblColorBuget" Font-Bold="true">Budget (Ore): </asp:Label><asp:Label ID="lblBudget" runat="server"></asp:Label>
                                                <br />
                                                <%--<asp:Label runat="server" Font-Bold="true">Avanzamento: </asp:Label>
                                                <div class="progress">
                                                    <div class="progress-bar" style="width: 60%;"></div>
                                                </div>--%>
                                                <asp:Label runat="server" Font-Bold="true">Descrizione: </asp:Label><asp:Label ID="lblContent" runat="server"></asp:Label>
                                                <br />
                                                
                                                <br />
                                            </div>
                                            <div class="col-md-1">
                                                <asp:UpdatePanel runat="server">
                                                    <ContentTemplate>
                                                        <asp:Button CausesValidation="false" ID="btnModifyActivity"  CssClass="btn btn-primary" runat="server" Text="Modifica" OnClick="btnModifyActivity_Click" />
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
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
                                                    <asp:GridView ItemType="VALE.Models.Project" DataKeyNames="ProjectId" AllowPaging="true" PageSize="10" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                        SelectMethod="GetRelatedProject" runat="server" ID="grdRelatedProject" CssClass="table table-striped table-bordered">
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
                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="col-md-6">
                                                                        <ul class="nav nav-pills">
                                                                            <li>
                                                                                <span class="glyphicon glyphicon-briefcase"></span>&nbsp;&nbsp;Interventi
                                                                            </li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button runat="server" CausesValidation="false" Text="Aggiungi intervento" CssClass="btn btn-success btn-xs" ID="btnAddReport" OnClick="btnAddReport_Click" />
                                                                        <div class="btn-group" runat="server" id="divAllOrPersonal" >
                                                                            <asp:Label ID="lblAllOrPersonal" Visible="false" runat="server" Text="Personal"></asp:Label>
                                                                            <button type="button" visible="false" id="btnPersonal" class="btn btn-primary btn-xs dropdown-toggle" data-toggle="dropdown" runat="server">Propri  <span class="caret"></span></button>
                                                                            <button type="button" visible="false" id="btnAllUsers" class="btn btn-info btn-xs dropdown-toggle" data-toggle="dropdown" runat="server">Di tutti <span class="caret"></span></button>
                                                                            <ul class="dropdown-menu">
                                                                                <li>
                                                                                    <asp:LinkButton ID="btnPersonalLinkButton" runat="server" OnClick="btnPersonalLinkButton_Click"><span class="glyphicon glyphicon-tasks"></span> Propri</asp:LinkButton></li>
                                                                                <li>
                                                                                    <asp:LinkButton ID="btnAllUsersLinkButton" runat="server" OnClick="btnAllUsersLinkButton_Click"><span class="glyphicon glyphicon-inbox"></span> Di tutti</asp:LinkButton></li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView runat="server" ID="grdActivityReport" AllowPaging="true" PageSize="10" ItemType="VALE.Models.ActivityReport" AutoGenerateColumns="false" OnRowCommand="grdActivityReport_RowCommand"
                                                                CssClass="table table-striped table-bordered" AllowSorting="true" EmptyDataText="Nessun intervento per questa attività" SelectMethod="grdActivityReport_GetData">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="WorkerUserName" CommandName="sort" runat="server" ><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Worker.FullName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="200px" />
                                                                        <ItemStyle Width="200px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="ActivityDescription" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.ActivityDescription %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" runat="server" ID="labelHoursWorked" CommandArgument="HoursWorked" CommandName="sort"><span  class="glyphicon glyphicon-time"></span> Ore di attività</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.HoursWorked %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="160px" />
                                                                        <ItemStyle Width="160px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Data">
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CausesValidation="false" CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="115px"></HeaderStyle>
                                                                        <ItemStyle Width="115px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <center>
                                                                                <div>
                                                                                    <asp:LinkButton ID="ShowReportClick" runat="server" CausesValidation="false" CommandName="ShowReport" CommandArgument="<%#: Item.ActivityReportId %>"><span class="label label-primary"><span class="glyphicon glyphicon-eye-open"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="EditReportClick" runat="server" Visible='<%# ModifyInterventionsAcces(Item) %>' CausesValidation="false" CommandName="EditReport" CommandArgument="<%#: Item.ActivityReportId %>"><span class="label label-success"><span class="glyphicon glyphicon-pencil"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton ID="DeleteReportclick" runat="server" Visible='<%# ModifyInterventionsAcces(Item) %>' CausesValidation="false" CommandName="DeleteReport" CommandArgument="<%#: Item.ActivityReportId %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                                                                </div>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server" CausesValidation="false" ID="labelBtnGroup"><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="110px"></HeaderStyle>
                                                                        <ItemStyle Width="110px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                            </asp:GridView>
                                                        </div>
                                                        <div class="panel-footer">
                                                            <ul class="nav nav-pills">
                                                                <li>
                                                                    <span runat="server" class="badge">
                                                                        <asp:Label runat="server" ID="lblHoursWorked" CssClass="control-label"></asp:Label>
                                                                    </span>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
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
                                                                <asp:Button runat="server" Text="Invita collaboratori" ID="btnInviteUser" CssClass="btn btn-info btn-xs" CausesValidation="false" OnClick="btnInviteUser_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                                SelectMethod="GetUsersInvolved" AllowPaging="true" PageSize="10" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="30%" />
                                                                        <ItemStyle Width="30%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="60%" />
                                                                        <ItemStyle Width="60%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-ok-sign"></span> Stato</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: GetStatusOfActivityRequest(Item) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="10%" />
                                                                        <ItemStyle Width="10%" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerSettings Position="Bottom" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                                                                <EmptyDataTemplate>
                                                                    <asp:Label runat="server">Nessun collaboratore</asp:Label>
                                                                </EmptyDataTemplate>
                                                            </asp:GridView>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:FormView>
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
            <asp:Label ID="lblAction" runat="server" Text="" Visible="false"></asp:Label>
            <asp:Label ID="lblReportId" runat="server" Text="" Visible="false"></asp:Label>
            <div class="well bs-component" id="pnlPopup" style="width: 50%;">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Nuovo Intervento</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Ore lavorate *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox TextMode="Number" runat="server" ID="txtHours" CssClass="form-control input-sm" Width="100px"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="ReportValidation" CssClass="txt-danger" ControlToValidate="txtHours" ErrorMessage="* campo ore obblligatorio"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator runat="server" ValidationGroup="ReportValidation" ControlToValidate="txtHours" CssClass="text-danger" ValidationExpression="[0-9]{1,4}" ErrorMessage="Numero non valido." Display="Dynamic"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Descrizione *</label>
                                <div class="col-lg-12">
                                    <textarea runat="server" class="form-control input-sm" rows="3" id="txtDescription"></textarea>
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="ReportValidation" CssClass="txt-danger" ControlToValidate="txtDescription" ErrorMessage="* descrizione obbligatoria"></asp:RequiredFieldValidator>
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
                            <asp:Button runat="server" Text="Crea" ID="btnOkGroupButton" CssClass="btn btn-success btn-sm" CausesValidation="true" ValidationGroup="AddGroup" OnClick="btnOkButton_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" OnClick="btnClosePopUpButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupActivity" runat="server"
                PopupControlID="pnlPopupProject" TargetControlID="lnkDummyProject" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyProject" runat="server"></asp:LinkButton>
            <div class="well bs-component" id="pnlPopupProject" style="width: 80%;">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Modifica Attività</legend>
                            <div class="form-group">
                                <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Nome attività *</asp:Label>
                                <div class="col-md-10">
                                    <asp:TextBox runat="server" ID="txtName" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="ModifyActivity" ControlToValidate="txtName" CssClass="text-danger" ErrorMessage="Il nome è obbligatorio" />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Descrizione *</asp:Label>
                                <div class="col-md-10">
                                   <asp:TextBox CssClass="form-control" TextMode="MultiLine" Height="145px"  ID="txtActDescription" runat="server"></asp:TextBox>
                                   <%--  <asp:HtmlEditorExtender EnableViewState="true" EnableSanitization="false" runat="server" TargetControlID="txtActDescription">
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
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="ModifyActivity" ControlToValidate="txtActDescription" CssClass="text-danger" ErrorMessage="La descrizione è obbligatoria" />
                                </div>
                                <asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Tipo Attività</asp:Label>
                                <div class="col-md-10">
                                    <asp:DropDownList  CssClass="form-control" runat="server"  ID="ddlSelectType" SelectMethod="GetTypes" Width="404px" ItemType="VALE.Models.ActivityType" DataTextField="ActivityTypeName" DataValueField="ActivityTypeName"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ValidationGroup="ModifyActivity" ControlToValidate="ddlSelectType" CssClass="text-danger" ErrorMessage="il è obbligatorio" />
                                </div>
                                <%--<asp:UpdatePanel runat="server">
                                    <ContentTemplate>--%>
                                        
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Data inizio</asp:Label>
                                        <div class="col-md-10">
                                            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control"/>
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                            <br />
                                        </div>
                                        <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Data fine</asp:Label>
                                        <div class="col-md-10">
                                            <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" />
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtEndDate"></asp:CalendarExtender>
                                            <br />
                                        </div>
                                        <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Budget</asp:Label>
                                        <div class="col-md-10">
                                                <asp:TextBox TextMode="Number" runat="server" ID="txtBudget" CssClass="form-control" Width="100px"/>
                                                <br />
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-offset-10 col-md-12">
                            <asp:Button runat="server" Text="Salva" ID="btnConfirmModify" CssClass="btn btn-success btn-sm" ValidationGroup="ModifyActivity" CausesValidation="true" OnClick="btnConfirmModify_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="Button2" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="Button2_Click" />
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
                            <asp:GridView SelectMethod="GetProjects" DataKeyNames="ProjectId" AllowPaging="true" PageSize="10" ID="OpenedProjectList" runat="server" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
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
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
