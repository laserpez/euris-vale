<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="VALE.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <asp:literal runat="server" id="TreeCode" />
                </div>
            </div>
        </div>
    </div>
    <button type="button" runat="server" class="btn btn-success"  onserverclick="Button1_Click" causesvalidation="false"><span class="glyphicon glyphicon-plus"></span></button>
</asp:Content>
