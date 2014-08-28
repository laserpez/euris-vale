﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SelectUser.ascx.cs" Inherits="VALE.MyVale.Create.SelectUser" %>
<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Aggiungi utenti</asp:Label>
<div class="col-md-10">
    <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
        <ContentTemplate>
            <div class="input-group col-lg-4">
                <div class="form-group">
                    <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control" />
                </div>
                <div class="input-group-btn">
                    <asp:Button CssClass="btn btn-primary" ID="btnShowPopup" runat="server" Text="Vedi tutti" OnClick="btnShowPopup_Click" CausesValidation="false" />
                    <asp:Button runat="server" Text="Aggiungi" ID="btnSearchUser" CssClass="btn btn-default" CausesValidation="false" OnClick="btnSearchUser_Click" />
                </div>
            </div>
            <asp:AutoCompleteExtender
                ServiceMethod="GetUserNames" ServicePath="/AutoComplete.asmx"
                ID="txtNameAutoCompleter" runat="server"
                Enabled="True" TargetControlID="txtUserName" UseContextKey="True"
                MinimumPrefixLength="2">
            </asp:AutoCompleteExtender>

            <asp:Label runat="server" ID="lblResultSearchUser" CssClass="control-label"></asp:Label>
            <br />
            <asp:Label Font-Bold="true" runat="server" CssClass="control-label" Text="Utenti correlati"></asp:Label><br />
            <asp:GridView ItemType="VALE.Models.UserData" AllowPaging="true" PageSize="3" OnPageIndexChanging="lstUsers_PageIndexChanging" DeleteMethod="DeleteUser" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                SelectMethod="GetRelatedUsers" AutoGenerateDeleteButton="true" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                <Columns>
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
                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <center><div><asp:Label runat="server" Text="<%#: Item.FullName %>"></asp:Label></div></center>
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
                <PagerSettings Position="Bottom" />
                <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                <EmptyDataTemplate>
                    <asp:Label runat="server">Nessun utente correlato.</asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>

            <asp:ModalPopupExtender ID="ModalPopup" runat="server"
                PopupControlID="pnlPopupUser" TargetControlID="lnkDummy" BackgroundCssClass="modalBackground">
            </asp:ModalPopupExtender>
            <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            <div class="panel panel-primary" id="pnlPopupUser" style="width: 80%;">
                <div class="panel-heading">
                    <asp:Label ID="TitleModalView" runat="server" Text="Lista utenti"></asp:Label>
                    <asp:Button runat="server" CssClass="close" CausesValidation="false" OnClick="Unnamed_Click" Text="x" />
                </div>
                <div class="panel-body" style="max-height: 500px; overflow: auto;">
                    <div>
                        <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
                        <div class="form-group">
                            <asp:GridView SelectMethod="GetUsers" ID="UsersList" runat="server" AllowPaging="true" PageSize="10" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                                ItemType="VALE.Models.UserData" EmptyDataText="Nessun utente." CssClass="table table-striped table-bordered">
                                <Columns>
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
                                            <center><div><asp:LinkButton CommandArgument="FullName" CommandName="sort" runat="server" ID="labelFullName"><span  class="glyphicon glyphicon-user"></span> Nome</asp:LinkButton></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Label runat="server" Text="<%#: Item.FullName %>"></asp:Label></div></center>
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
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <center><div><asp:Label runat="server" ID="labelAdd"><span  class="glyphicon glyphicon-saved"></span> Aggiungi</asp:Label></div></center>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <center><div><asp:Button runat="server" Width="120" CausesValidation="false" CommandArgument="<%#: Item.UserName %>" Text="Aggiungi" CssClass="btn btn-info btn-xs" ID="btnChooseUser" OnClick="btnChooseUser_Click" /></div></center>
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
</div>