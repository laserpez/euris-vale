<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Events" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Events.aspx.cs" Inherits="VALE.MyVale.Events" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="col-lg-6">
                                                <ul class="nav nav-pills col-lg-6">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server" Text="Calendario eventi"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">

                                    <asp:UpdatePanel runat="server">
                                        <ContentTemplate>
                                            <div class="row">
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" Text="Da" CssClass="control-label"></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtFromDate" CssClass="form-control" OnTextChanged="txtFromDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ErrorMessage="* obbligatorio" runat="server" ControlToValidate="txtFromDate"></asp:RequiredFieldValidator>
                                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarFrom" TargetControlID="txtFromDate"></asp:CalendarExtender>
                                                </div>
                                                <div class="col-md-2">
                                                    <asp:Label runat="server" Text="A" CssClass="control-label"></asp:Label>
                                                    <asp:TextBox runat="server" ID="txtToDate" CssClass="form-control"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ErrorMessage="* obbligatorio" runat="server" ControlToValidate="txtToDate"></asp:RequiredFieldValidator>
                                                    <asp:CalendarExtender runat="server" Format="dd/MM/yyyy" ID="calendarTo" TargetControlID="txtToDate"></asp:CalendarExtender>
                                                </div>
                                            </div>
                                            <div class="col-md-12">
                                                <asp:Button CausesValidation="true" runat="server" ID="btnShowEvents" CssClass="btn btn-primary btn-xs" Text="Mostra eventi" OnClick="btnShowEvents_Click" />
                                            </div>
                                            <div class="col-md-12">
                                                <br />
                                            </div>
                                            <div class="col-md-12">
                                                <asp:GridView runat="server" ItemType="VALE.Models.Event" DataKeyNames="EventId" AllowSorting="true" OnSorting="grdPlannedEvent_Sorting" AutoGenerateColumns="false" EmptyDataText="Non ci sono eventi per il periodo selezionato"
                                                CssClass="table table-striped table-bordered" ID="grdPlannedEvent">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="EventDate" CommandName="sort" runat="server" ID="labelEventData"><span  class="glyphicon glyphicon-th"></span> Data</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.EventDate.ToShortDateString() %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Name" CommandName="sort" runat="server" ID="labelEventName"><span  class="glyphicon glyphicon-th"></span> Nome</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Name %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:LinkButton CommandArgument="Description" CommandName="sort" runat="server" ID="labelEventDescription"><span  class="glyphicon glyphicon-th"></span> Descrizione</asp:LinkButton></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Label runat="server"><%#: Item.Description %></asp:Label></div></center>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:Label runat="server" ID="labelDetail"><span  class="glyphicon glyphicon-th"></span> Dettagli</asp:Label></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Button ID="btnViewDetails" Width="90" CssClass="btn btn-info btn-xs" Text="Vedi" runat="server" OnClick="btnViewDetails_Click" /></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle Width="90px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            <center><div><asp:Label runat="server" ID="labelAttend"><span  class="glyphicon glyphicon-th"></span> Partecipa</asp:Label></div></center>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <center><div><asp:Button ID="btnAttendEvent" Width="150" runat="server" OnClick="btnAttendEvent_Click" Text="&nbsp;&nbsp;&nbsp;&nbsp;Partecipa&nbsp;&nbsp;&nbsp;&nbsp;" CssClass="btn btn-info btn-xs" /></div></center>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="100px" />
                                                        <ItemStyle Width="100px" />
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                            </div>
                                            
                                        </ContentTemplate>
                                    </asp:UpdatePanel>

                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
