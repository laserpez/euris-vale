<%@ Page Title="Register an external login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterExternalLogin.aspx.cs" Inherits="VALE.Account.RegisterExternalLogin" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
<h3>Register with your <%: ProviderName %> account</h3>

    <asp:PlaceHolder runat="server">
        <div class="form-horizontal">
            <h4>Association Form</h4>
            <hr />
            <asp:ValidationSummary runat="server" ShowModelStateErrors="true" CssClass="text-danger" />
            <p class="text-info">
                You've authenticated with <strong><%: ProviderName %></strong>. Please fill the form and click the Log in button.
            </p>

            

    </div>

   <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>


        <div class="form-group">
             <asp:Label runat="server" AssociatedControlID="TextUserName" CssClass="col-md-1 control-label">UserName</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextUserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextUserName"
                    CssClass="text-danger" ErrorMessage="The UserName field is required." />
            </div>
            <asp:Label runat="server" AssociatedControlID="TextFirstName" CssClass="col-md-1 control-label">First name</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextFirstName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName"
                    CssClass="text-danger" ErrorMessage="The first name field is required." />
            </div>
            <asp:Label runat="server" AssociatedControlID="TextLastName" CssClass="col-md-1 control-label">Last name</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextLastName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLastName"
                    CssClass="text-danger" ErrorMessage="The last name field is required." />
            </div>
            
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="TextAddress" CssClass="col-md-1 control-label">Address</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextAddress" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextAddress"
                    CssClass="text-danger" ErrorMessage="The address field is required." />
            </div>
            <asp:Label runat="server" AssociatedControlID="TextCity" CssClass="col-md-1 control-label">City</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextCity" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextCity"
                    CssClass="text-danger" ErrorMessage="The city field is required." />
            </div>
            <asp:Label runat="server" AssociatedControlID="TextProv" CssClass="col-md-1 control-label">Province</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextProv" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextProv"
                    CssClass="text-danger" ErrorMessage="The province field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="TextCF" CssClass="col-md-1 control-label">Fiscal code</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextCF" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName"
                    CssClass="text-danger" ErrorMessage="The fiscal code field is required." />
            </div>
            

            <asp:Label runat="server" AssociatedControlID="TextEmail" CssClass="col-md-1 control-label">Email</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="TextEmail" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="TextEmail"
                    Display="Dynamic" CssClass="text-danger" ErrorMessage="Email is required" />
                <asp:ModelErrorMessage runat="server" ModelStateKey="email" CssClass="text-error" />
            </div>

        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="checkAssociated" CssClass="col-md-1 control-label">Request to be associated</asp:Label>
            <div class="col-md-3">
                <asp:CheckBox runat="server" ID="checkAssociated" />
            </div>
        </div>


            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button runat="server" Text="Log in" CssClass="btn btn-default" OnClick="LogIn_Click" />
                </div>
            </div>
        </div>
        <div></div>
    </asp:PlaceHolder>


</asp:Content>
