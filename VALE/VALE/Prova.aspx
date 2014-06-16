<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Prova.aspx.cs" Inherits="VALE.Prova" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p><br /></p>
    
    <div class="row">

        <div class="col-sm-6 col-md-3">
            <div class="panel panel-default">
            <div class="panel-heading"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;&nbsp;To Be Planned</div>
            <div class="panel-body" style="max-height: 200px; overflow: auto;">
                <asp:GridView ID="ToBePlannedGridView" runat="server" 
                    ItemType="VALE.Models.Activity"
                    CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        </div>
        <div class="col-sm-6 col-md-3">
            <div class="panel panel-default">
            <div class="panel-heading"><span class="glyphicon glyphicon-play"></span>&nbsp;&nbsp;Ongoing</div>
            <div class="panel-body" style="max-height: 200px; overflow: auto;">
                <asp:GridView ID="OngoingGridView" runat="server" AutoGenerateColumns="False"
                    ItemType="VALE.Models.Activity"
                    CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        </div>
        <div class="col-sm-6 col-md-3">
            <div class="panel panel-default">
            <div class="panel-heading"><span class="glyphicon glyphicon-pause"></span>&nbsp;&nbsp;Suspended</div>
            <div class="panel-body" style="max-height: 200px; overflow: auto;">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                    ItemType="VALE.Models.Activity"
                    CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        </div>
        <div class="col-sm-6 col-md-3">
            <div class="panel panel-default">
            <div class="panel-heading"><span class="glyphicon glyphicon-stop"></span>&nbsp;&nbsp;Done</div>
            <div class="panel-body" style="max-height: 200px; overflow: auto;">
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False"
                    ItemType="VALE.Models.Activity"
                    CssClass="table table-striped table-bordered">
                    <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        </div>
    </div>
</asp:Content>
