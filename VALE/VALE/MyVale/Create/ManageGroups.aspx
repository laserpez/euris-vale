<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageGroups.aspx.cs" Inherits="VALE.MyVale.Create.ManageGroups" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script type="text/javascript">
        function ManageGroup(action, userName, groupId) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            var url = "ManageGroups.aspx?Mode=Group&Action=" + action + "&UserName=" + userName + "&GroupId=" + groupId;
            xmlhttp.open("Get", url, false);
            xmlhttp.send(null);
            var result = xmlhttp.responseText;
        }

        function ManageSetGroups(action, groupId, setGroupsId) {
            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            var url = "ManageGroups.aspx?Mode=SetGroups&Action=" + action + "&GroupId=" + groupId + "&SetGroupsId=" + setGroupsId;
            xmlhttp.open("Get", url, false);
            xmlhttp.send(null);
            var result = xmlhttp.responseText;
        }
    </script>
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
                                                    <asp:Label ID="HeaderName" runat="server" Text="Gestione Gruppi"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="navbar-right">
                                        <div class="btn-group">
                                            <button type="button" id="btnManageGroupButton" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" runat="server">Gruppo  <span class="caret"></span></button>
                                            <button type="button" visible="false" id="btnManageSetGroupsButton" class="btn btn-success dropdown-toggle" data-toggle="dropdown" runat="server">Insieme di Gruppi  <span class="caret"></span></button>
                                            <ul class="dropdown-menu" style="text-align: initial">
                                                <li>
                                                    <asp:LinkButton ID="btnManageGroupLinkButton" runat="server" OnClick="btnManageGroupLinkButton_Click"><span class="glyphicon glyphicon-th-large"></span> Gruppo</asp:LinkButton></li>
                                                <li>
                                                    <asp:LinkButton ID="btnManageSetGroupsLinkButton" runat="server" OnClick="btnManageSetGroupsLinkButton_Click"><span class="glyphicon glyphicon-folder-open"></span> Insieme di Gruppi</asp:LinkButton></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="max-height: 700px; overflow: auto;">
                            <asp:Label ID="lblGroupAction" runat="server" Visible="false" Text=""></asp:Label>
                            <div class="row" runat="server" id="pnlManageGroupPanel">
                                <div class="col-sm-6 col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Utenti
                                                     <div class="navbar-right">
                                                         <%--<button type="button" runat="server" class="btn btn-success btn-xs" title="Crea nuova attività (stato: da pianificare)"><span class="glyphicon glyphicon-plus"></span></button>--%>
                                                     </div>
                                        </div>
                                        <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                            <asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="grdUsers" runat="server" AutoGenerateColumns="false" SelectMethod="grdUsers_GetData"
                                                        ItemType="VALE.Models.UserData"  CssClass="table table-striped table-bordered">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><span  class="glyphicon glyphicon-screenshot"></span></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox runat="server" ID="chkSelectUser" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelUserName"><span  class="glyphicon glyphicon-credit-card"></span> UserName</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label ID="labelUserName" runat="server" Text="<%#: Item.UserName %>"></asp:Label></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" ID="labelFirstName"><span  class="glyphicon glyphicon-user"></span> Nome Cognome</asp:LinkButton></div></center>
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
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:HiddenField ID="lblGroupId" runat="server" />
                                        <asp:HiddenField ID="lblMode" runat="server" Value="Group" />
                                        <div class="col-sm-6 col-md-6">
                                            <div class="panel panel-default">
                                                <div class="panel-heading">
                                                    <span class="glyphicon glyphicon-th-large"></span>&nbsp;&nbsp;<asp:Label ID="lblHeaderGroupPanel" runat="server" Text="Gruppi"></asp:Label>
                                                    <div class="navbar-right">
                                                        <asp:Button ID="btnAddGroupButton" CssClass="btn btn-success btn-xs" runat="server" Text="Aggiungi" OnClick="btnAddGroupButton_Click" />
                                                        <asp:Button ID="btnGroupsListButton" CssClass="btn btn-default btn-xs" runat="server" Text="Gruppi" Visible="false" OnClick="btnGroupsListButton_Click" />
                                                    </div>
                                                </div>
                                                <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                                    <asp:GridView ID="grdGroups" runat="server" AutoGenerateColumns="False"
                                                        ItemType="VALE.Models.Group"
                                                        CssClass="table table-striped table-bordered"
                                                        ShowHeaderWhenEmpty="true"
                                                        SelectMethod="grdGroups_GetData"
                                                        OnRowCommand="grdGroups_RowCommand">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center><div><asp:LinkButton runat="server"  CommandName="OpenGroup" CommandArgument="<%#: Item.GroupId %>"> <%#: Item.GroupName %></asp:LinkButton></div></center>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemStyle Font-Bold="true" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Descrizione</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.CreationDate.ToShortDateString() %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
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
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-cog"></span> Azioni</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="100px"></HeaderStyle>
                                                                <ItemStyle Width="100px"></ItemStyle>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:GridView ID="grdGroupUsers" runat="server" AutoGenerateColumns="false"  SelectMethod="grdGroupUsers_GetData"
                                                        ItemType="VALE.Models.UserData"  CssClass="table table-striped table-bordered" ShowHeaderWhenEmpty="true">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><span  class="glyphicon glyphicon-screenshot"></span></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox runat="server" ID="chkSelectUser" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton  runat="server" ID="labelUserName"><span  class="glyphicon glyphicon-credit-card"></span> UserName</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label ID="labelUserName" runat="server" Text="<%#: Item.UserName %>"></asp:Label></div></center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton runat="server" ID="labelFirstName"><span  class="glyphicon glyphicon-user"></span> Nome Cognome</asp:LinkButton></div></center>
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
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="row" runat="server" id="pnlManageSetGroupsPanel" visible="false">
                                <div class="col-sm-6 col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <span class="glyphicon glyphicon-th-large"></span>&nbsp;&nbsp;Gruppi
                                                     <div class="navbar-right">
                                                         <%--<button type="button" class="btn btn-success btn-xs" runat="server" title="Crea nuova attività (stato: sospeso)" onserverclick="btnCreateActivitySuspendedStatus_Click"><span class="glyphicon glyphicon-plus"></span></button>--%>
                                                     </div>
                                        </div>
                                        <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                            <%--<asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="SuspendedGridView2" runat="server" AutoGenerateColumns="False"
                                                        ItemType="VALE.Models.Activity"
                                                        CssClass="table table-striped table-bordered"
                                                        AllowSorting ="true" OnSorting="GridView_Sorting"
                                                        ShowHeaderWhenEmpty="true">
                                                        <Columns>
                                                            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="/MyVale/ActivityDetails?activityId=<%#: Item.ActivityId %>"><%#: Item.ActivityName %></a>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemStyle Font-Bold="true"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server" ><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Nessuna Data" %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="115px"></HeaderStyle>
                                                                <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-md-6">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <span class="glyphicon glyphicon-folder-open"></span>&nbsp;&nbsp;Insiemi di gruppi
                                                     <div class="navbar-right">
                                                         <%--<button type="button" class="btn btn-success btn-xs" runat="server" title="Crea nuova attività (stato: terminato)" onserverclick="btnCreateActivityDoneStatus_Click"><span class="glyphicon glyphicon-plus"></span></button>--%>
                                                     </div>
                                        </div>
                                        <div class="panel-body" style="max-height: 170px; overflow: auto;">
                                            <%--<asp:UpdatePanel runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="DoneGridView3" runat="server" AutoGenerateColumns="False"
                                                        ItemType="VALE.Models.Activity"
                                                        CssClass="table table-striped table-bordered"
                                                        AllowSorting="true" OnSorting="GridView_Sorting"
                                                        ShowHeaderWhenEmpty="true">
                                                        <Columns>
                                                            <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <a href="/MyVale/ActivityDetails?activityId=<%#: Item.ActivityId %>"><%#: Item.ActivityName %></a>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="ActivityName" CommandName="sort" runat="server" ID="labelName"><span  class="glyphicon glyphicon-credit-card"></span> Nome</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <ItemStyle Font-Bold="true"></ItemStyle>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <center><div><asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Nessuna Data" %></asp:Label></div></center>
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <center><div><asp:LinkButton CommandArgument="StartDate" CommandName="sort" runat="server" ID="labelStartDate"><span  class="glyphicon glyphicon-calendar"></span> Data</asp:LinkButton></div></center>
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="115px"></HeaderStyle>
                                                                <ItemStyle Width="115px" Font-Bold="true"></ItemStyle>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
