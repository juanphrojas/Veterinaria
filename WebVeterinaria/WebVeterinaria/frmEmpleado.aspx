<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmEmpleado.aspx.cs" Inherits="WebVeterinaria.Formulario_web15" %>
<asp:Content ID="Content3" ContentPlaceHolderID="CUERPO" runat="server">
    <div class="col-sm-3 col-md-2 sidebar">
        <asp:Menu ID="mnuControl" runat="server" RenderingMode="List" Orientation="Vertical" StaticMenuStyle-CssClass="nav nav-sidebar" IncludeStyleBlock="false" Width="100%">
            <Items>
                <asp:MenuItem Value="opcAggEmpleado" Text="Nuevo Empleado"></asp:MenuItem>
                <asp:MenuItem Value="opcEditEmpleado" Text="Editar Empleado"></asp:MenuItem>
                <asp:MenuItem Value="opcBuscarEmpleado" Text="Buscar Empleado"></asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Empleados</h1>
        <asp:Panel ID="PanelEmpleado" runat="server">
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
                <div class="col-md-6">
                    <strong>Estado:</strong>
                    <asp:CheckBox Text="Activo" Checked="true" CssClass="form-control" runat="server"/>
                </div>
            </div>
            <div class="row tmg-10">
                <div class="col-md-6 tmg-10">
                    <strong>Cédula:</strong>
                    <asp:TextBox ID="txtCedula" runat="server" CssClass="form-control"></asp:TextBox>

                    <div class="row tmg-10">
                        <div class="col-md-6">
                            <strong>Usuario:</strong>
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <div class="row">
                                <div class="col-md-12">
                                    <strong>Contraseña:</strong>
                                    <asp:TextBox ID="txtContrasenia" TextMode="Password" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row tmg-10">
                                <div class="col-md-12">
                                    <strong>Confirmar Contraseña:</strong>
                                    <asp:TextBox ID="txtConfContrasenia" TextMode="Password" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row tmg-10">
                        <div class="col-md-12 col-md-offset-8">
                            <asp:Button ID="btnRegistrar" Text="Registrar Empleado" CssClass="btn btn-success" runat="server"/>
                            <asp:Button ID="btnModificar" Text="Modificar Empleado" CssClass="btn btn-warning" runat="server"/>
                        </div>
                    </div>

                </div>
                <div class="col-md-6 tmg-10">
                    <div class="row">
                        <strong>Nombre:</strong>
                        <asp:TextBox ID="txtNombre" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="row tmg-10">
                        <strong>Cargo:</strong>
                        <asp:DropDownList ID="ddlCargo" CssClass="form-control" runat="server"></asp:DropDownList>
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
            <h2 class="sub-header">Registro de Empleados</h2>
            <div class="table-responsive">
                <asp:GridView ID="grvEmpleados" runat="server" CssClass="table table-striped">
                    <AlternatingRowStyle BackColor="#E1E1E1" />
                </asp:GridView>
            </div>
        </asp:Panel>

</div>
</asp:Content>

