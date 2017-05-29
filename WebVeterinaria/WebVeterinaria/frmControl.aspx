<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmControl.aspx.cs" Inherits="WebVeterinaria.Formulario_web1" %>
<asp:Content ID="Content3" ContentPlaceHolderID="CUERPO" runat="server">
    <div class="col-sm-3 col-md-2 sidebar">
    <asp:Menu ID="mnuControl" runat="server" RenderingMode="List" Orientation="Vertical" StaticMenuStyle-CssClass="nav nav-sidebar" IncludeStyleBlock="false" Width="100%">
        <Items>
            <asp:MenuItem Value="opcAggControl" Text="Nuevo Contról"></asp:MenuItem>
            <asp:MenuItem Value="opcEditControl" Text="Editar Contról"></asp:MenuItem>
            <asp:MenuItem Value="opcBuscarControl" Text="Buscar Contról"></asp:MenuItem>
        </Items>
    </asp:Menu>
</div>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <h1 class="page-header">Control</h1>
    <asp:Panel ID="PanelControl" runat="server">
        <div class="row">
            <div class="col-md-6">
                <strong>Código:</strong>
                <div class="row">
                    <div class="col-md-9">
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-md btn-success" />
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <strong>Fecha:<asp:TextBox ID="txtFecha" runat="server" CssClass="form-control"></asp:TextBox>
                </strong>
            </div>
        </div>
        <div class="row tmg-10">
            <div class="col-md-6">
                <div class="row tmg-10">
                    <div class="col-md-12">
                        <strong>Cédula Cliente:</strong>
                        <asp:TextBox ID="txtCedulaCliente" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-12 tmg-10">
                        <strong>Nombre Cliente:</strong>
                        <asp:TextBox ID="txtNombreCliente" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-12 tmg-10">
                        <strong>Mascota:</strong>
                        <asp:DropDownList ID="ddlMacota" Width="100%" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col-md-12 tmg-10">
                        <strong>Peso de la Mascota:</strong>
                        <asp:TextBox ID="txtPeso" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-12 tmg-10">
                        <strong>Edad de la Mascota:</strong>
                        <asp:TextBox ID="txtEdad" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="col-md-6 tmg-10">
                <strong>Próxima Cita</strong>
                <asp:Calendar ID="CalendarProxCita" runat="server" Width="100%" CellPadding="5" Height="300px" CssClass="tmg-10">
                    <TitleStyle BackColor="#0F3D64" Font-Bold="True" ForeColor="White" />
                    </asp:Calendar>
            </div>
        </div>
    
        <asp:Panel ID="panelServicio" runat="server">
            <h3 class="sub-header">Servicios</h3>
            <div class="row tmg-10">
                <div class="col-md-6">
                    <strong>Servicio:</strong>
                    <asp:TextBox ID="txtServicio" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <strong>Valor del Servicio:</strong>
                    <asp:TextBox ID="txtVlrServicio" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="row tmg-10">
                <div class="col-md-6">
                    <strong>Empleado:</strong>
                    <asp:TextBox ID="txtEmpleado" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-6 tmg-10">
                    <asp:Button ID="btnAgregarServicio" Text="Agregar Servicio" CssClass="btn btn-info" runat="server"/>
                    <asp:Button ID="btnQuitar" Text="Quitar Servicio" CssClass="btn btn-danger" runat="server"/>                    
                </div>
            </div>
        </asp:Panel>

        <div class="row tmg-10">
            <div class="col-md-4">
                <strong>Valor Total</strong>
                <asp:TextBox ID="txtTotalPago" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Button ID="btnAgregarControl" Text="Agregar Control" runat="server" CssClass="btn btn-success tmg-10"/>
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

    <asp:Panel ID="PanelRegistros" runat="server">
        <h2 class="sub-header">Registro de controles</h2>
        <div class="table-responsive">
            <asp:GridView ID="grvControles" runat="server" CssClass="table table-striped">
                <AlternatingRowStyle BackColor="#E1E1E1" />
            </asp:GridView>
        </div>
    </asp:Panel>
</div>
</asp:Content>

