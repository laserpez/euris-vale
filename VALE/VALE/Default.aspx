<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VALE._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2>Benvenuto in VALE, ambiente virtuale di collaborazione</h2>
    </div>

    <div class="row">
        <asp:UpdatePanel ID="UpdatePanel" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="col-md-10" style="font-size: x-large">
                    <p>
                        &nbsp;Fai il log-in per accedere alle sezioni interne <a runat="server" href="~/Account/Login">Qui</a>.
                <br />
                        &nbsp;Puoi anche fare il log-in attraverso google, facebook, twitter o linkedin.
                    </p>
                    <p>
                        &nbsp;Se non sei ancora registrato clicca <a runat="server" href="~/Account/Register">Qui</a>
                    </p>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
