﻿<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
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
                                            <div class="col-md-9">
                                                <h3><%#: Item.ActivityName %></h3>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="navbar-right">
                                                    <asp:UpdatePanel runat="server">
                                                        <ContentTemplate>
                                                            <asp:Button runat="server" ID="btnDeleteActivity" Text="Cancella" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnDeleteActivity_Click" />
                                                            <asp:Button CausesValidation="false" ID="btnModifyActivity"  CssClass="btn btn-primary" runat="server" Text="Modifica" OnClick="btnModifyActivity_Click" />
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
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
                                                 <asp:Label runat="server" id="lblColorBuget" Font-Bold="true">Budget: </asp:Label><asp:Label ID="lblBudget" runat="server"></asp:Label>
                                                <br />
                                                 <asp:Label runat="server" Font-Bold="true">Descrizione: </asp:Label><asp:Label ID="lblContent" runat="server"></asp:Label>
                                                <br />
                                                 <asp:Label runat="server" id="lblInfoBlockStatement" Font-Bold="true" ForeColor="OrangeRed" Visible="false">Attenzione: l'attività è sospesa in quanto il progetto che la contiene è </asp:Label><asp:Label runat="server" id="lblProjectStatus" Font-Bold="true" ForeColor="OrangeRed" Visible="false"></asp:Label>
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
                                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.WorkerUserName %>"><asp:Label runat="server"><%#: Item.Worker.FullName %></asp:Label></a></div></center>
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
                                                                            <center><div><asp:Label runat="server"><%#: GetStringFromMinutes(Item.HoursWorked) %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="200px" />
                                                                        <ItemStyle Width="200px" />
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
                                                                            <center><div><a href="/Account/Profile?Username=<%#: Item.UserName %>"><asp:Label runat="server"><%#: Item.FullName %></asp:Label></a></div></center>
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
            <div class="well bs-component" id="pnlPopup" style="width: 70%;">
                <div class="row">
                    <div class="col-md-12">
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <legend>Nuovo Intervento</legend>
                            <div class="form-group">
                                <asp:Label  Font-Bold="true" runat="server" CssClass="col-md-3 control-label">Temp di lavoro</asp:Label>
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Giorni</asp:Label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="txtDaysReport" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                                    <asp:RegularExpressionValidator ControlToValidate="txtDaysReport" runat="server" ErrorMessage="Giorni > 0"
                                        CssClass="text-danger" ValidationExpression="^\d*$" Display="Dynamic" ValidationGroup="ReportValidation"></asp:RegularExpressionValidator> 
                                </div>
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Ore</asp:Label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="txtHoursReport" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                                    <asp:RegularExpressionValidator ControlToValidate="txtHoursReport" runat="server" ErrorMessage="Ore tra 0..7" ValidationGroup="ReportValidation"
                                        CssClass="text-danger" ValidationExpression="[0-7]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                </div>
                                <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Min</asp:Label>
                                <div class="col-md-2">
                                    <asp:TextBox ID="txtMinutesReport" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox> 
                                    <asp:RegularExpressionValidator ControlToValidate="txtMinutesReport" runat="server" ErrorMessage="Minuti tra 0..59" ValidationGroup="ReportValidation"
                                        CssClass="text-danger" ValidationExpression="[0-5]?[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <br />
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Descrizione *</label>
                                <div class="col-lg-12">
                                    <textarea runat="server" class="form-control input-sm" rows="6" id="txtDescription"></textarea>
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
                            <asp:Button runat="server" Text="Crea" ID="btnOkReportButton" CssClass="btn btn-success btn-sm" CausesValidation="true" ValidationGroup="ReportValidation" OnClick="btnOkButton_Click" />
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
                                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Giorni</asp:Label>
                                            <div class="col-md-2">
                                                <asp:TextBox ID="TextDay" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                                                <asp:RegularExpressionValidator ControlToValidate="TextDay" runat="server" ErrorMessage="Giorni > 0"
                                                    CssClass="text-danger" ValidationExpression="^\d*$" Display="Dynamic" ValidationGroup="ModifyActivity"></asp:RegularExpressionValidator> 
                                            </div>
                                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Ore</asp:Label>
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtHour" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox>
                                                <asp:RegularExpressionValidator ControlToValidate="txtHour" runat="server" ErrorMessage="Ore tra 0..7" ValidationGroup="ModifyActivity"
                                                    CssClass="text-danger" ValidationExpression="[0-7]" Display="Dynamic"></asp:RegularExpressionValidator> 
                                            </div>
                                            <asp:Label runat="server" Font-Bold="true" CssClass="col-md-1 control-label">Min</asp:Label>
                                            <div class="col-md-2">
                                                <asp:TextBox ID="txtMin" TextMode="Number" Width="100" runat="server" CssClass="form-control" Text="0"></asp:TextBox> 
                                                <asp:RegularExpressionValidator ControlToValidate="txtMin" runat="server" ErrorMessage="Minuti tra 0..59" ValidationGroup="ModifyActivity"
                                                    CssClass="text-danger" ValidationExpression="[0-5]?[0-9]" Display="Dynamic"></asp:RegularExpressionValidator>
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
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ModalPopupExtender ID="ModalPopupPasswordRequest" runat="server"
                PopupControlID="pnlPasswordRequest" TargetControlID="lnkDummyPasswordRequest" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummyPasswordRequest" runat="server"></asp:LinkButton>
            <div class="alert alert-dismissable alert-info" id="pnlPasswordRequest" style="width: 25%;">
                <fieldset>
                    <div class="row">
                        <asp:Label runat="server" CssClass="col-md-12 control-label"><strong>Inserisci Password</strong></asp:Label>
                        <div class="col-md-12">
                            <br />
                        </div>
                        <div class="col-md-12">
                            <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" />
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="col-md-12">
                                <br />
                            </div>
                            <div class="col-md-offset-7 col-md-10">
                                <asp:Button runat="server" Text="&nbsp;&nbsp;&nbsp;Ok&nbsp;&nbsp;&nbsp;" ID="btnPopUpDeleteActivity" CssClass="btn btn-success btn-sm" CausesValidation="false" OnClick="btnPopUpDeleteActivity_Click" />
                                <asp:Button runat="server" Text="Annulla" ID="btnPopUpDeleteActivityClose" CssClass="btn btn-danger btn-sm" CausesValidation="false" OnClick="btnPopUpDeleteActivityClose_Click" />
                            </div>

                        </div>
                    </div>
                </fieldset>
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
