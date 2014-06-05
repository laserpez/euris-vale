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
                <asp:Label runat="server" AssociatedControlID="TextEmail" CssClass="col-md-1 control-label">Email</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextEmail" CssClass="form-control" TextMode="Email" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextEmail"
                        CssClass="text-danger" ErrorMessage="The email field is required." />
                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="TextFirstName" CssClass="col-md-1 control-label">FirstName</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextFirstName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName"
                        CssClass="text-danger" ErrorMessage="The first name field is required." />
                </div>
                <asp:Label runat="server" AssociatedControlID="TextLastName" CssClass="col-md-1 control-label">LastName</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextLastName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextLastName"
                        CssClass="text-danger" ErrorMessage="The last name field is required." />
                </div>
            </div>

            <div class="form-group">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>

                        <asp:Label runat="server" AssociatedControlID="DropDownRegion" CssClass="col-md-1 control-label">Region</asp:Label>
                        <div class="col-md-3">
                            <asp:DropDownList runat="server" class="form-control" ID="DropDownRegion" AutoPostBack="True" OnSelectedIndexChanged="Region_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator InitialValue="Select" runat="server" ControlToValidate="DropDownRegion"
                                CssClass="text-danger" ErrorMessage="Province the Region." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="DropDownProvince" CssClass="col-md-1 control-label">Province</asp:Label>
                        <div class="col-md-3">
                            <asp:DropDownList runat="server" class="form-control" ID="DropDownProvince" AutoPostBack="True" OnSelectedIndexChanged="State_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator InitialValue="Select" runat="server" ControlToValidate="DropDownProvince"
                                CssClass="text-danger" ErrorMessage="Select the Province." />
                        </div>
                        <asp:Label runat="server" AssociatedControlID="DropDownCity" CssClass="col-md-1 control-label">City</asp:Label>
                        <div class="col-md-3">
                            <asp:DropDownList runat="server" class="form-control" ID="DropDownCity">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator InitialValue="Select" runat="server" ControlToValidate="DropDownCity"
                                CssClass="text-danger" ErrorMessage="Select the City." />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="TextAddress" CssClass="col-md-1 control-label">Address</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextAddress" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextAddress"
                        CssClass="text-danger" ErrorMessage="The address field is required." />
                </div>
                <asp:Label runat="server" AssociatedControlID="TextCF" CssClass="col-md-1 control-label">FiscalCode</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="TextCF" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TextFirstName"
                        CssClass="text-danger" ErrorMessage="The fiscal code field is required." />
                </div>
            </div>

            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-1 control-label">Password</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                        CssClass="text-danger" ErrorMessage="The password field is required." />
                </div>
                <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-1 control-label">Confirm password</asp:Label>
                <div class="col-md-3">
                    <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                    <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                </div>
            </div>
            <br />
            <br />
            <div class="col-md-5"></div>
            <asp:Label runat="server" AssociatedControlID="checkAssociated">Request to be associated</asp:Label>
            <asp:CheckBox runat="server" ID="checkAssociated" />
            <br />
            <div class="col-md-5"></div>
            <asp:Button runat="server" Text="Log in" CssClass="btn btn-info col-md-2" OnClick="LogIn_Click" />
        </div>
    </asp:PlaceHolder>
    <br />
    <br />

</asp:Content>
