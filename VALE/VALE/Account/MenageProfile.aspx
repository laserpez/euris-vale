<%@ Page Title="Menage Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MenageProfile.aspx.cs" Inherits="VALE.MenageProfile" %>
<%@ Register Src="~/MyVale/FileUploader.ascx" TagPrefix="uc" TagName="FileUploader" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="bs-docs-section">
            <br />
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="col-lg-12">
                                        <ul class="nav nav-pills">
                                            <li>
                                                <h4>
                                                    <asp:Label ID="HeaderName" runat="server" Text="Modifica il tuo profilo"></asp:Label>
                                                </h4>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-body" style="overflow: auto;">
                            <div class="col-md-12 form-group">
                                <legend class="h5"><b>Foto profilo</b></legend>
                                <div class="col-md-12">
                                    <br />
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="form-group col-lg-5">
                                            <div class="input-group">
                                                <span class="input-group-addon input-sm"><span class="glyphicon glyphicon-file"></span></span>
                                                <div runat="server" id="FileTextBox">
                                                    <asp:FileUpload ID="FileUpload" runat="server" CssClass="form-control input-sm" />
                                                </div>
                                                <span class="input-group-btn">
                                                    <asp:Button runat="server" ID="AddFileNameButton" ValidationGroup="UploadFile" CssClass="btn btn-default btn-sm" Text="Aggiungi" OnClick="AddFileNameButton_Click" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="photoEdit" class="col-md-2">
                                    <div style="border: ridge; height: 122px; width: 112px">
                                        <div id="photo" style="border: thin; height: 114px; width: 104px">
                                            <asp:Image ID="photoProfile" runat="server" Height="114px" Width="104px" ImageUrl="~/Images/User.jpg" ToolTip="Foto profilo di.." ImageAlign="Left" />
                                        </div>
                                    </div>
                                </div>
                                <div id="groupBtn" class="col-md-10">
                                    <asp:Button runat="server" ID="EditPhoto" CssClass="btn btn-warning btn-xs" Text="Modifica" OnClick="EditPhoto_Click" /><br />
                                    <p></p>
                                    <asp:Button runat="server" ID="RemovePhoto" CssClass="btn btn-danger btn-xs" Text="Cancella" OnClick="RemovePhoto_Click" />
                                </div>
                            </div>

                            <div class="col-md-12 form-group">
                                <div id="PersonalData">
                                    <legend class="h4" ><b>Dati personali</b></legend>
                                    <div class="col-md-12"><br /></div>
                                    <asp:FormView runat="server" ID="PersonalDataFormView" CssClass="col-md-12" ItemType="VALE.Models.ApplicationUser" EmptyDataText="Nessun dato presente." SelectMethod="GetUserData">
                                        <ItemTemplate>
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Nome utente:\t{0}", Item.UserName) %></asp:Label><br />
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Nome:\t{0}", Item.FirstName) %></asp:Label><br />
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Cognome:\t{0}", Item.LastName) %></asp:Label><br />
                                            <asp:Label runat="server" CssClass="col-md-12"><%#: String.Format("Codice fiscale:\t{0}", Item.CF) %></asp:Label><br />
                                            <legend class="h5" ><b>Contatti</b></legend>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="E-mail: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditEmail" CssClass="form-control" runat="server" Text="<%#: Item.Email %>"></asp:TextBox></div><br />
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Telefono: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditTelephone" CssClass="form-control" runat="server" Text="<%#: Item.Telephone %>"></asp:TextBox></div><br />
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Cellulare: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditCellPhone" CssClass="form-control" runat="server" Text="<%#: Item.CellPhone %>"></asp:TextBox></div><br />
                                            <legend class="h5" ><b>Recapito</b></legend>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Residenza: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditAdress" CssClass="form-control" runat="server" Text="<%#: Item.Address %>"></asp:TextBox></div><br />
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Regione: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditRegion" CssClass="form-control" runat="server" Text="<%#: Item.Region %>"></asp:TextBox></div><br />
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Provincia: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditProvince" CssClass="form-control" runat="server" Text="<%#: Item.Province %>"></asp:TextBox></div><br />
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Città: "></asp:Label><div class="col-md-11"><asp:TextBox ID="EditCity" runat="server" CssClass="form-control" Text="<%#: Item.City %>"></asp:TextBox></div><br />
                                            <legend class="h5" ><b>Descrizione</b></legend>
                                            <asp:Label runat="server" CssClass="col-md-1" Text="Descrizione: "></asp:Label><div class="col-md-7"><asp:TextBox ID="EditDescription" runat="server" CssClass="form-control" Text="<%#: Item.Description %>"></asp:TextBox></div><br />
                                            <legend class="h5" ><b>Curriculum Vitae</b></legend>
                                        </ItemTemplate>
                                    </asp:FormView>
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="col-md-12 form-group">
                                <div id="SaveChanges">
                                    <asp:Button runat="server" ID="SaveChangesProfile" CssClass="btn btn-info btn-sm" Text="Salva" CausesValidation="false" Visible="true" OnClick="SaveChangesProfile_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
