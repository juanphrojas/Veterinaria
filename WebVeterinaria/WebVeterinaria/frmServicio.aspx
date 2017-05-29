<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmServicio.aspx.cs" Inherits="WebVeterinaria.Formulario_web11" %>
<asp:Content ID="Content3" ContentPlaceHolderID="CUERPO" runat="server">
    <div class="col-sm-3 col-md-2 sidebar">
        <asp:Menu ID="mnuControl" runat="server" RenderingMode="List" Orientation="Vertical" StaticMenuStyle-CssClass="nav nav-sidebar" IncludeStyleBlock="false" Width="100%" OnMenuItemClick="mnuControl_MenuItemClick">
            <Items>
                <asp:MenuItem Value="opcAggServicio" Text="Nuevo Servicio"></asp:MenuItem>
                <asp:MenuItem Value="opcEditServicio" Text="Editar Servicio"></asp:MenuItem>
                <asp:MenuItem Value="opcBuscarServicio" Text="Buscar Servicio"></asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Servicios</h1>
        <asp:Panel ID="PanelServicio" runat="server">
            <div class="row">
                <div class="col-md-6">
                    <strong>Código:</strong>
                    <div class="row">
                        <div class="col-md-9">
                            <asp:TextBox ID="txtCodigo" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="btnBuscar" Text="Buscar" CssClass="btn btn-success" runat="server"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row tmg-10">
                <div class="col-md-6 tmg-10">
                    <strong>Descripción:</strong>
                    <asp:TextBox ID="txtDescripcion" TextMode="MultiLine" Height="145px" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-6 tmg-10">
                    <div class="row">
                        <strong>Costo:</strong>
                        <asp:TextBox ID="txtCosto" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="row tmg-10">
                        <strong>Cargo:</strong>
                        <asp:DropDownList ID="ddlCargo" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                    <div class="row tmg-10">
                        <asp:Button ID="btnRegServicio" Text="Registrar Nuevo Servicio" CssClass="btn btn-success" runat="server"/>
                        <asp:Button ID="btnModServicio" Text="Modificar Servicio" CssClass="btn btn-warning" runat="server"/>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="panelMensaje" runat="server">
            <div class="row tmg-10">
                <div class="alert alert-info" role="alert">
                    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="PanelResgistros" runat="server">
            <h2 class="sub-header">Registro de Servicios</h2>
            <div class="table-responsive">
                <asp:GridView ID="grvServicios" runat="server" CssClass="table table-striped">
                    <AlternatingRowStyle BackColor="#E1E1E1" />
                </asp:GridView>
            </div>
        </asp:Panel>

</div>
</asp:Content>
