<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmCliente.aspx.cs" Inherits="WebVeterinaria.Formulario_web16" %>
<asp:Content ID="Content3" ContentPlaceHolderID="CUERPO" runat="server">
    <div class="col-sm-3 col-md-2 sidebar">
        <asp:Menu ID="mnuControl" runat="server" RenderingMode="List" Orientation="Vertical" StaticMenuStyle-CssClass="nav nav-sidebar" IncludeStyleBlock="false" Width="100%">
            <Items>
                <asp:MenuItem Value="opcAggCliente" Text="Registrar Cliente"></asp:MenuItem>
                <asp:MenuItem Value="opcEditCliente" Text="Editar Cliente"></asp:MenuItem>
                <asp:MenuItem Value="opcBuscarCliente" Text="Buscar Cliente"></asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Clientes</h1>
        <asp:Panel ID="PanelCliente" runat="server">
            <div class="row">

                <div class="col-md-6">

                    <strong>Cédula:</strong>
                    <div class="row">
                        <div class="col-md-9">
                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-md btn-success" />
                        </div>
                    </div>

                    <div class="tmg-10">
                        <strong>Nombre:</strong>
                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="tmg-10">
                        <strong>Email:</strong>
                        <asp:TextBox ID="txtNombreCliente" TextMode="Email" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>


                    <asp:Panel ID="PanelTelefono" runat="server">
                        <h3 class="sub-header">Teléfono:</h3>                        
                        <div class="row tmg-10">
                            <div class="col-md-6">
                                <strong>Tipo:</strong>
                                <asp:DropDownList ID="ddlTipoTel" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <strong>Numero:</strong>
                                <asp:TextBox ID="txtNumeroTel" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row tmg-10">
                            <div class="col-md-12">
                                <asp:Button ID="btnAggTel" Text="Agregar Teléfono" CssClass="btn btn-primary" runat="server"/>
                            </div>
                        </div>
                        <div class="row tmg-10">
                            <div class="col-md-12">
                                <asp:Panel ID="PanelRegistroTelefonos" runat="server">
                                    <h4 class="sub-header">Registro de Teléfonos</h4>
                                    <div class="table-responsive">
                                        <asp:GridView ID="grvTelefonos" runat="server" CssClass="table table-striped">
                                            <AlternatingRowStyle BackColor="#E1E1E1" />
                                        </asp:GridView>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </asp:Panel>

                </div>

                <div class="col-md-6">
                    <strong>Fecha de Nacimiento:</strong>
                    <asp:Calendar ID="CalendarFechaNacimiento" runat="server" Width="100%" CellPadding="5" Height="300px">
                        <TitleStyle BackColor="#0F3D64" Font-Bold="True" ForeColor="White" />
                        </asp:Calendar>

                    <asp:Panel ID="PanelDirección" runat="server">
                        <h3 class="sub-header">Dirección:</h3>                        
                        <div class="row tmg-10">
                            <div class="col-md-6">
                                <strong>Ciudad:</strong>
                                <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <strong>Nomenclatura:</strong>
                                <asp:TextBox ID="txtNomenclatura" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row tmg-10">
                            <div class="col-md-12">
                                <asp:Button ID="btnAggDirec" Text="Agregar Dirección" CssClass="btn btn-primary" runat="server"/>
                            </div>
                        </div>
                        <div class="row tmg-10">
                            <div class="col-md-12">
                                <asp:Panel ID="PanelRegistroDirec" runat="server">
                                    <h4 class="sub-header">Registro de Direcciones</h4>
                                    <div class="table-responsive">
                                        <asp:GridView ID="grvDirecciones" runat="server" CssClass="table table-striped">
                                            <AlternatingRowStyle BackColor="#E1E1E1" />
                                        </asp:GridView>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </asp:Panel>

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
            <h2 class="sub-header">Registro de Clientes</h2>
            <div class="table-responsive">
                <asp:GridView ID="grvClientes" runat="server" CssClass="table table-striped">
                    <AlternatingRowStyle BackColor="#E1E1E1" />
                </asp:GridView>
            </div>
        </asp:Panel>
    </div>
</asp:Content>

