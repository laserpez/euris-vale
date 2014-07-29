<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="VALE.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-12">
            <br />
        </div>
    </div>
    <div class="row">
        <h2>Multi level dropdown menu in Bootstrap 3</h2>
        <hr>
        <div class="dropdown">
            <a id="dLabel" role="button" data-toggle="dropdown" class="btn btn-primary" data-target="#" href="/page.html">
                Dropdown <span class="caret"></span>
            </a>
    		<ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
              <li><a href="#">Some action</a></li>
              <li><a href="#">Some other action</a></li>
              <li class="divider"></li>
              <li class="dropdown-submenu">
                <a tabindex="-1" href="#">Hover me for more options</a>
                <ul class="dropdown-menu">
                  <li><a tabindex="-1" href="#">Second level</a></li>
                  <li class="dropdown-submenu">
                    <a href="#">Even More..</a>
                    <ul class="dropdown-menu">
                        <li><a href="#">3rd level</a></li>
                    	<li><a href="#">3rd level</a></li>
                    </ul>
                  </li>
                  <li><a href="#">Second level</a></li>
                  <li><a href="#">Second level</a></li>
                </ul>
              </li>
            </ul>
        </div>
	</div>
    <div class="row">
        <div class="col-md-12">
            <br />
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <asp:TreeView ID="TreeView1" OnTreeNodePopulate="TreeView1_TreeNodePopulate" Width="250" ExpandDepth="0" runat="server">
                       
                    </asp:TreeView>

                </div>
            </div>
        </div>
    </div>
    <button type="button" runat="server" class="btn btn-success"  onserverclick="Button1_Click" causesvalidation="false"><span class="glyphicon glyphicon-plus"></span></button>
</asp:Content>
