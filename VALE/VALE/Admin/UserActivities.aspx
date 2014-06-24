<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserActivities.aspx.cs" Inherits="VALE.Admin.UserActivities" %>
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
                                                <ul class="nav nav-pills">
                                                    <li>
                                                        <h4>
                                                            <asp:Label ID="HeaderName" runat="server"></asp:Label>
                                                        </h4>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body" style="overflow: auto;">
                                   <!-- <br />
                                    <asp:Label ID="lblSummary" Font-Size="Large" Font-Bold="true" ForeColor="#317eac" runat="server"></asp:Label>
                                    <p></p>-->
                                    <asp:GridView ID="grdReports" OnDataBound="grdReports_DataBound" runat="server" SelectMethod="GetUserActivities" AutoGenerateColumns="false" GridLines="Both"
                                        ItemType="VALE.Models.ActivityReport" EmptyDataText="Nessun progetto aperto" CssClass="table table-striped table-bordered">
                                        <Columns>
                                            <asp:BoundField HeaderText="Descrizione" DataField="ActivityDescription" />
                                            <asp:BoundField HeaderText="Ore di attività" DataField="HoursWorked" />
                                            <asp:BoundField HeaderText="Data" DataFormatString="{0:d}" DataField="Date" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
