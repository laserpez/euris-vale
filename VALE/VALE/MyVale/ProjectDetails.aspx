<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectDetails.aspx.cs" Inherits="VALE.MyVale.ProjectDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView OnDataBound="ProjectDetail_DataBound" runat="server" ID="ProjectDetail" ItemType="VALE.Models.Project" SelectMethod="GetProject">
        <ItemTemplate>
            <h3><%#: Item.ProjectName.ToUpper() %></h3>
            <h4>Dettagli progetto</h4>

            <asp:Label runat="server"><%#: String.Format("Stato:\t{0}", Item.Status.ToUpperInvariant()) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Descrizione:\t{0}", Item.Description) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Creatore:\t{0}", Item.Organizer.FullName) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Data:\t{0}", Item.CreationDate.ToShortDateString()) %></asp:Label><br />
            <asp:Label runat="server"><%#: String.Format("Ultima modifica:\t{0}", Item.LastModified.ToShortDateString()) %></asp:Label><br />

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <h4>Collabora</h4>
                    <asp:Button runat="server" ID="btnWorkOnThis" OnClick="btnWorkOnThis_Click" />
                    <asp:Button runat="server" ID="btnAddIntervention" OnClick="btnAddIntervention_Click" />
                    <h4>Interventi</h4>
            <asp:GridView OnRowCommand="grdInterventions_RowCommand" ItemType="VALE.Models.Intervention" GridLines="Both" AllowSorting="true"
                SelectMethod="GetInterventions" runat="server" ID="grdInterventions" AutoGenerateColumns="false" CssClass="table table-striped table-bordered">
                <Columns>
                    <asp:BoundField DataField="InterventionId" HeaderText="ID" SortExpression="InterventionId" />
                    <asp:BoundField DataField="InterventionText" HeaderText="Intervento" SortExpression="InterventionText" />
                    <asp:TemplateField HeaderText="Creatore">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.CreatorUserName %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Data">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: Item.Date.ToShortDateString() %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Ha allegati">
                        <ItemTemplate>
                            <asp:Label runat="server"><%#: ContainsDocuments(Item.DocumentsPath) ? "SI" : "NO" %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dettagli">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-info btn-sm" runat="server" CommandName="ViewIntervention"
                                CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="Vedi" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label runat="server">Non ci sono interventi</asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>

                    <h4>Collaboratori</h4>
                    <asp:GridView ItemType="VALE.Models.UserData" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                        SelectMethod="GetRelatedUsers" runat="server" ID="lstUsers" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="FullName" HeaderText="Nome" SortExpression="FullName" />
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        </Columns>
                        <EmptyDataTemplate>
                            <asp:Label runat="server">Nessun collaboratore</asp:Label>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>

            <h4>Progetto correlato</h4>
            <asp:FormView runat="server" ItemType="VALE.Models.Project" SelectMethod="GetRelatedProject">
                <EmptyDataTemplate>
                    <asp:Label runat="server" Text="Nessun progetto correlato"></asp:Label>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <a href="ProjectDetails.aspx?projectId=<%#: Item.ProjectId %>"><%#: Item.ProjectName %></a><br />
                </ItemTemplate>
            </asp:FormView>

            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <h4>Eventi correlati</h4>
                    <asp:Button CssClass="btn btn-success btn-sm" Text="Aggiungi evento" ID="btnAddEvent" runat="server" OnClick="btnAddEvent_Click" />
                    <asp:GridView ItemType="VALE.Models.Event" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                        SelectMethod="GetRelatedEvents" DataKeyNames="EventId" runat="server" ID="GridView1" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Nome" SortExpression="Name" />
                            <asp:BoundField DataField="Description" HeaderText="Descrizione" SortExpression="Description" />
                            <asp:BoundField DataField="EventDate" HeaderText="Data" SortExpression="EventDate" />
                        </Columns>
                        <EmptyDataTemplate>
                            <asp:Label runat="server">Nessun evento correlato</asp:Label>
                        </EmptyDataTemplate>
                    </asp:GridView>

                    <h4>Attività correlate</h4>
                    <asp:Button CssClass="btn btn-success btn-sm" Text="Aggiungi attività" ID="btnAddActivity" runat="server" OnClick="btnAddActivity_Click" />
                    <asp:GridView ItemType="VALE.Models.Activity" AutoGenerateColumns="false" GridLines="Both" AllowSorting="true"
                        SelectMethod="GetRelatedActivities" DataKeyNames="ActivityId" runat="server" ID="GridView2" CssClass="table table-striped table-bordered">
                        <Columns>
                            <asp:BoundField DataField="ActivityName" HeaderText="Nome" SortExpression="ActivityName" />
                            <asp:BoundField DataField="Description" HeaderText="Descrizione" SortExpression="Description" />
                            <asp:TemplateField HeaderText="Data inizio" SortExpression="StartDate">
                            <ItemTemplate>
                                    <asp:Label runat="server"><%#: Item.StartDate.HasValue ? Item.StartDate.Value.ToShortDateString() : "Non definita"  %></asp:Label>
                                </ItemTemplate>    
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Data fine" SortExpression="ExpireDate">
                                <ItemTemplate>
                                    <asp:Label runat="server"><%#: Item.ExpireDate.HasValue ? Item.ExpireDate.Value.ToShortDateString() : "Non definita"  %></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <asp:Label runat="server">Nessuna attività correlata</asp:Label>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>


            <h4>Allegati</h4>
            <asp:ListBox runat="server" CssClass="form-control" Width="400px" ID="lstDocuments" SelectMethod="GetRelatedDocuments"></asp:ListBox>
            <asp:Button runat="server" Text="Scarica" CssClass="btn btn-info" ID="btnViewDocument" OnClick="btnViewDocument_Click" />

            



            <h4>Gestisci progetto</h4>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Label runat="server" ID="lblInfoManage" Text="Cambia lo stato del tuo progetto"></asp:Label><br />
                    <asp:Button runat="server" ID="btnSuspendProject" CausesValidation="false" OnClick="btnSuspendProject_Click" />
                    <asp:Button runat="server" ID="btnCloseProject" CausesValidation="false" OnClick="btnCloseProject_Click" /><br />
                    <asp:Panel runat="server" Visible="false" ID="manageProjectPanel">
                        <asp:Label runat="server" Text="Insert password to confirm operation: "></asp:Label>
                        <asp:Label ID="lblInfoOperation" runat="server"></asp:Label><br />
                        <asp:TextBox CssClass="form-control" runat="server" ID="txtPassword" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ErrorMessage="La password è richiesta" ControlToValidate="txtPassword" runat="server"></asp:RequiredFieldValidator>
                        <asp:Button runat="server" ID="btnModifyProject" CssClass="btn btn-info" Text="Confirm" OnClick="btnModifyProject_Click" />
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>



        </ItemTemplate>
    </asp:FormView>
</asp:Content>
