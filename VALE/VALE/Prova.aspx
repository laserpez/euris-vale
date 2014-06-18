<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Prova.aspx.cs" Inherits="VALE.Prova" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p><br /></p>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js" type="text/javascript"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".table").sortable({
                items: 'tr:not(tr:first-child)',
                cursor: 'crosshair',
                connectWith: '.table',
                dropOnEmpty: true,
                receive: function (e, ui) {
                    $(this).find("tbody").append(ui.item);
                }
                
            });
        });
       
        
        
    </script>
    <div class="row">
        <div class="col-sm-6 col-md-3">
            <div class="panel panel-default">
            <div class="panel-heading"><span class="glyphicon glyphicon-share-alt"></span>&nbsp;&nbsp;To Be Planned</div>
            <div class="panel-body" style="max-height: 200px; overflow: auto;">
                <asp:GridView ID="ToBePlannedGridView" runat="server" AutoGenerateColumns="False"
                    ItemType="VALE.Models.Activity"
                    CssClass="table table-striped table-bordered"
                    SelectMethod="ToBePlannedGridViewGetData"
                    ShowHeaderWhenEmpty="true">
                   <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
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
                    CssClass="table table-striped table-bordered"
                    SelectMethod="OngoingGridViewGetData"
                    ShowHeaderWhenEmpty="true" 
                   >
                    <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
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
                <asp:GridView ID="SuspendedGridView" runat="server" AutoGenerateColumns="False"
                    ItemType="VALE.Models.Activity"
                    CssClass="table table-striped table-bordered"
                    SelectMethod="SuspendedGridViewGetData"
                    ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
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
            <div class="panel-body" style="max-height: 400px; overflow: auto;">
                <asp:GridView ID="DoneGridView" runat="server" AutoGenerateColumns="False"
                    ItemType="VALE.Models.Activity"
                    CssClass="table table-striped table-bordered"
                    SelectMethod="DoneGridViewGetData"
                    ShowHeaderWhenEmpty="true">
                    <Columns>
                        <asp:BoundField DataField="ActivityId" HeaderText="ID" />
                        <asp:BoundField DataField="ActivityName" HeaderText="Name" />
                        <asp:TemplateField HeaderText="Creation Date">
                            <ItemTemplate>
                                <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "No start date" %></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        </div>
    </div>
    
    
</asp:Content>
