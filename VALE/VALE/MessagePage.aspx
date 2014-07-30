<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MessagePage.aspx.cs" Inherits="VALE.MessagePage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <div class="row">
                <div class="col-lg-12">   
                    <div class="jumbotron" >
                        <h1><%: TitleMessage %></h1>
                        <p class="lead"><%: Message %></p>
                        <p><a href="~/" runat="server" class="btn btn-primary btn-large">Home &raquo;</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

