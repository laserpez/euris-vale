<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageGroups.aspx.cs" Inherits="VALE.MyVale.Create.ManageGroups" %>

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
                                                            <asp:Label ID="HeaderName" runat="server" Text="Gestione Gruppi"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="navbar-right">
                                                <asp:Button ID="btnAddGroupButton" CssClass="btn btn-success" runat="server" Text="Aggiungi" OnClick="btnAddGroupButton_Click" />
                                                <asp:Button ID="btnGroupsListButton" CssClass="btn btn-default" runat="server" Text="Gruppi" Visible="false" OnClick="btnGroupsListButton_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <asp:Label ID="lblGroupAction" runat="server" Visible="false" Text=""></asp:Label>
                                    <div class="row" runat="server" id="pnlGroupList">
                                        <div class="col-md-12">
                                            <asp:GridView ID="grdGroups" runat="server" AutoGenerateColumns="False"
                                                ItemType="VALE.Models.Group"
                                                CssClass="table table-striped table-bordered"
                                                ShowHeaderWhenEmpty="true"
                                                SelectMethod="grdGroups_GetData"
                                                AllowSorting="true"
                                                OnRowCommand="grdGroups_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <center><div><asp:LinkButton runat="server"  CommandName="OpenGroup" CommandArgument="<%#: Item.GroupId %>"> <%#: Item.GroupName %></asp:LinkButton></div></center>
                                                        </ItemTemplate>
                                                        <HeaderTemplate>
                                                            <center><div><asp:Linkbutton runat="server" id="labelname" commandargument="groupid" commandname="sort"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:Linkbutton></div></center>
                                                        </HeaderTemplate>
                                                        <HeaderStyle Width="20%" />
                                                        <ItemStyle Font-Bold="true" Width="20%"/>
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
                                                                            <asp:LinkButton runat="server"  CommandName="ShowGroup" CommandArgument="<%#: Item.GroupId %>"><span class="label label-primary"><span class="glyphicon glyphicon-eye-open"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" CommandName="EditGroup" CommandArgument="<%#: Item.GroupId %>"><span class="label label-success"><span class="glyphicon glyphicon-pencil"></span></span></asp:LinkButton>
                                                                            <asp:LinkButton runat="server" CommandName="DeleteGroup" CommandArgument="<%#: Item.GroupId %>"><span class="label label-danger"><span class="glyphicon glyphicon-trash"></span></span></asp:LinkButton>
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
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="row" runat="server" id="pnlManageGroupPanel" visible="false">
                                        <asp:Label ID="grdUsersSelectAllLabel" runat="server" Visible="false" Text="False"></asp:Label>
                                        <asp:Label ID="grdGroupUsersSelectAllLabel" runat="server" Visible="false" Text="False"></asp:Label>
                                        <div class="col-sm-6 col-md-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Utenti
                                                     <div class="navbar-right">
                                                         <asp:Button ID="btnAddSelectedUsersToGroupButton" CssClass="btn btn-success btn-xs" runat="server" Text="Aggiungi->" OnClick="btnAddSelectedUsersToGroupButton_Click" />
                                                     </div>
                                                </div>
                                                <div class="panel-body">

                                                    <asp:GridView ID="grdUsers" runat="server" AllowSorting="true" AutoGenerateColumns="false"
                                                        ItemType="VALE.Models.UserData" CssClass="table table-striped table-bordered" ShowHeaderWhenEmpty="true" SelectMethod="grdUsers_GetData">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" OnClick="grdUsersSelectDeselectAllLinkButton_Click"><span  class="glyphicon glyphicon-screenshot"></span></asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:CheckBox runat="server" ID="chkSelectUser"/></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" CommandArgument="UserName" CommandName="sort" ID="labelUserName"><span  class="glyphicon glyphicon-credit-card"></span> UserName</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label ID="labelUserName" runat="server" Text="<%#: Item.UserName %>"></asp:Label></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" CommandArgument="FullName" CommandName="sort" ID="labelFirstName"><span  class="glyphicon glyphicon-user"></span> Nome Cognome</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelRuolo"><span  class="glyphicon glyphicon-cog"></span> Ruolo</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><%# GetRoleName(Item.UserName) %></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>

                                                </div>
                       
                                            </div>
                                        </div>
                                        <asp:UpdatePanel runat="server">
                                            <ContentTemplate>
                                                <asp:HiddenField ID="lblGroupId" runat="server" Value="" />
                                                <div class="col-sm-6 col-md-6">
                                                    <div class="panel panel-default">
                                                        <div class="panel-heading">
                                                           <asp:Button ID="btnRemoveSelectedUsersFromGroupButton" CssClass="btn btn-danger btn-xs" runat="server" Text="<-Rimuovi" OnClick="btnRemoveSelectedUsersFromGroupButton_Click" />
                                                            <div class="navbar-right">
                                                                <asp:Label ID="lblHeaderGroupPanel" runat="server" Text="Gruppi"></asp:Label>&nbsp;&nbsp;<span class="glyphicon glyphicon-th-large"></span>
                                                            </div>
                                                        </div>
                                                        <div class="panel-body" >
                                                            <asp:GridView ID="grdGroupUsers" AllowSorting="true" runat="server" AutoGenerateColumns="false"
                                                                ItemType="VALE.Models.UserData" CssClass="table table-striped table-bordered" ShowHeaderWhenEmpty="true" SelectMethod="grdGroupUsers_GetData">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton  runat="server" OnClick="grdGroupUsersSelectDeselectAllLinkButton_Click"><span  class="glyphicon glyphicon-screenshot"></span></asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:CheckBox runat="server" ID="chkSelectUser" /></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton CommandArgument="UserName" CommandName="sort" runat="server" ID="labelUserName"><span  class="glyphicon glyphicon-credit-card"></span> UserName</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label ID="labelUserName" runat="server" Text="<%#: Item.UserName %>"></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server" CommandArgument="FullName" CommandName="sort" ID="labelFirstName"><span  class="glyphicon glyphicon-user"></span> Nome Cognome</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><asp:Label runat="server"><%#: Item.FullName %></asp:Label></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <HeaderTemplate>
                                                                            <center><div><asp:LinkButton runat="server" ID="labelRuolo"><span  class="glyphicon glyphicon-cog"></span> Ruolo</asp:LinkButton></div></center>
                                                                        </HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <center><div><%# GetRoleName(Item.UserName) %></div></center>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
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
                            <legend>Nuovo Gruppo</legend>
                            <div class="form-group">
                                <label class="col-lg-12 control-label">Nome Gruppo *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox runat="server" class="form-control input-sm" ID="NameTextBox" />
                                </div>
                            </div>
                            <div class="form-group">
                                <br />
                                <label class="col-lg-12 control-label">Descrizione *</label>
                                <div class="col-lg-12">
                                    <textarea runat="server" class="form-control input-sm" rows="3" id="DescriptionTextarea"></textarea>
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
                            <asp:Button runat="server" Text="Crea" ID="btnOkGroupButton" CssClass="btn btn-success btn-sm" OnClick="btnOkForNewGroupButton_Click" />
                            <asp:Button runat="server" Text="Annulla" ID="btnClosePopUpButton" CssClass="btn btn-danger btn-sm" OnClick="btnClosePopUpButton_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
