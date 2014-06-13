<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SelectProject.ascx.cs" Inherits="VALE.MyVale.Create.SelectProject" %>
<asp:Label Font-Bold="true" runat="server" CssClass="col-md-2 control-label">Related project (optional)</asp:Label>
        <div class="col-md-10">
            PROVA CONTROL USER
            <asp:UpdatePanel ID="SearchProjectPanel" runat="server">
                <ContentTemplate>
                    <asp:TextBox runat="server" ID="txtProjectName" CssClass="form-control" />
                    <asp:AutoCompleteExtender
                        ServiceMethod="GetProjectNames" ServicePath="/AutoComplete.asmx"
                        ID="txtProjectAutoCompleter" runat="server"
                        Enabled="True" TargetControlID="txtProjectName" UseContextKey="True"
                        MinimumPrefixLength="2">
                    </asp:AutoCompleteExtender>
                    <asp:Button runat="server" Text="Save" ID="btnSearchProject" CssClass="btn btn-default" CausesValidation="false" OnClick="btnSearchProject_Click" />
                    <asp:Label runat="server" ID="lblResultSearchProject" CssClass="control-label"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>