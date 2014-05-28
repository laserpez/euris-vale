<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="VALE.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h4>Create a new account.</h4>
        <hr />
        <!--<asp:ValidationSummary runat="server" CssClass="text-danger" />-->
        <div class="form-group">
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
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-1 control-label">Email</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="The email field is required." />
            </div>
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
            <asp:Label runat="server" AssociatedControlID="checkAssociated" CssClass="col-md-1 control-label">Request to be associated</asp:Label>
            <div class="col-md-3">
                <asp:CheckBox runat="server" ID="checkAssociated" />
            </div>
        </div>
        <div class="form-group">
            
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
</asp:Content>
