<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OpenAuthProviders.ascx.cs" Inherits="VALE.Account.OpenAuthProviders" %>

<div id="socialLoginList">
    <h4>Usa un altro servizio per loggarti.</h4>
    <hr />
    <asp:ListView runat="server" ID="providerDetails" ItemType="System.String"
        SelectMethod="GetProviderNames" ViewStateMode="Disabled">
        <ItemTemplate>
            <p>
                <button type="submit" class="btn btn-default" name="provider" value="<%#: Item %>"
                    title="Loggarsi con il proprio account <%#: Item %> .">
                    <%#: Item %>
                </button>
            </p>
        </ItemTemplate>
        <EmptyDataTemplate>
            <div>
                <p>Non ci sono servizi esterni di autenticazione configurati. Vedi <a href="http://go.microsoft.com/fwlink/?LinkId=252803">questo articolo</a> per i dettagli su come loggarsi in questa applicazione ASP.NET per i dettagli sul settagio come supporto al loggin  per servizi esterni.</p>
            </div>
        </EmptyDataTemplate>
    </asp:ListView>
</div>
