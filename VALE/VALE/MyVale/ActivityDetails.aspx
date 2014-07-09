<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ActivityDetails.aspx.cs" Inherits="VALE.MyVale.ActivityDetails" %>
<%@ Register Src="~/MyVale/Create/SelectUser.ascx" TagPrefix="ux" TagName="SelectUser" %>

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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Dettaglio attività"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <asp:FormView runat="server" ID="ActivityDetail"  Width="100%" ItemType="VALE.Models.Activity" SelectMethod="GetActivity">
                                <ItemTemplate>
                                    <legend >Nome</legend>
                                    <h3><%#: Item.ActivityName %></h3>
                                    <legend >Creato da</legend>
                                    <asp:Label runat="server" CssClass="conrol-label"><%#: Item.Creator.FullName %></asp:Label>
                                    <legend >Descrizione</legend>
                                    <textarea runat="server" class="form-control input-sm" rows="3" id="txtActivityDescription"><%#: Item.Description %></textarea>

                                    <legend >Data</legend>
                                    <asp:Label runat="server" CssClass="col-md-2 control-label">Data inizio</asp:Label>
                                        <div class="col-md-10">
                                            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control"  />
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtStartDate"></asp:CalendarExtender>
                                            <br />
                                        </div>
                                        <asp:Label runat="server" CssClass="col-md-2 control-label">Data fine</asp:Label>
                                        <div class="col-md-10">
                                            <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" />
                                            <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtEndDate" ></asp:CalendarExtender>
                                            <br />
                                        </div>
                                    <legend >Stato</legend>
                                    <div class="btn-group">
                                        <asp:Label ID="ListUsersType" Visible="false" runat="server" Text=""></asp:Label>
                                        <button type="button" visible="true" id="btnStatus" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server"><%#: GetStatus(Item) %><span class="caret"></span></button>
                                        <ul class="dropdown-menu">
                                            <li>
                                                <asp:LinkButton CommandArgument="ToBePlanned" runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-share-alt"></span> Da Pianificare</asp:LinkButton></li>
                                            <li>
                                                <asp:LinkButton CommandArgument="Ongoing" runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-play"></span>  In Corso  </asp:LinkButton></li>
                                            <li>
                                                <asp:LinkButton CommandArgument="Suspended" runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-pause"></span> Sospeso  </asp:LinkButton></li>
                                            <li>
                                                <asp:LinkButton CommandArgument="Done" runat="server" OnClick="ChangeActivityStatus_Click" CausesValidation="false"><span class="glyphicon glyphicon-stop"></span> Terminato</asp:LinkButton></li>
                                        </ul>
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
                                                            <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                                                SelectMethod="GetUsersInvolved" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="528px" />
                                                                        <ItemStyle Width="528px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Email" CommandName="sort" runat="server" ID="labelEmail"><span  class="glyphicon glyphicon-envelope"></span> Email</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.Email %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="528px" />
                                                                        <ItemStyle Width="528px" />
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
                                                                               <span runat="server" class="badge"><asp:Label runat="server" ID="lblHoursWorked" CssClass="control-label"><%#: GetHoursWorked() %></asp:Label></span></li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="navbar-right">
                                                                        <asp:Button runat="server" CausesValidation="false" Text="Aggiungi intervento" CssClass="btn btn-success btn-xs" ID="btnAddReport" OnClick="btnAddReport_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" style="max-height: 200px; overflow: auto;">
                                                            <asp:GridView runat="server" ID="grdActivityReport" ItemType="VALE.Models.ActivityReport" AutoGenerateColumns="false" OnRowCommand="grdActivityReport_RowCommand"
                                                                CssClass="table table-striped table-bordered" AllowSorting="true" EmptyDataText="Nessun intervento per questa attività" SelectMethod="grdActivityReport_GetData">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="ActivityDescription" CommandName="sort" runat="server" ID="labelDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.ActivityDescription %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server" ID="labelHoursWorked" CommandArgument="HoursWorked" CommandName="sort"><span  class="glyphicon glyphicon-time"></span> Ore di attività</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.HoursWorked %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="160px" />
                                                                        <ItemStyle Width="160px" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Data">
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="Date" CommandName="sort" runat="server" ID="labelDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
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
                                                                                    <asp:LinkButton runat="server" CausesValidation="false" CommandName="ShowReport" CommandArgument="<%#: Item.ActivityReportId %>"><span class="label label-primary"><span class="glyphicon glyphicon-eye-open"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton runat="server" CausesValidation="false" CommandName="EditReport" CommandArgument="<%#: Item.ActivityReportId %>"><span class="label label-success"><span class="glyphicon glyphicon-pencil"></span></span></asp:LinkButton>
                                                                                    <asp:LinkButton runat="server" CausesValidation="false" CommandName="DeleteReport" CommandArgument="<%#: Item.ActivityReportId %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
                                                                                </div>
                                                                            </center>
                                                                        </ItemTemplate>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server" ID="labelBtnGroup"><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <HeaderStyle Width="110px"></HeaderStyle>
                                                                        <ItemStyle Width="110px"></ItemStyle>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            </div>
                                           
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                   
                                    <legend >Progetto correlato</legend>
                                    <asp:FormView runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" EmptyDataText="Nessun progetto correlato." SelectMethod="GetRelatedProject">
                                        <ItemTemplate>
                                            <a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>"><%#: Item.ProjectName %></a>
                                            <br />
                                        </ItemTemplate>
                                    </asp:FormView>
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
                                    <asp:RegularExpressionValidator runat="server" ValidationGroup="ReportValidation" ControlToValidate="txtHours" CssClass="text-danger" ValidationExpression="[0-9]{1,4}" ErrorMessage="Numero non valido."  Display="Dynamic"></asp:RegularExpressionValidator>
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
</asp:Content>
