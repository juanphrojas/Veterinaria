<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmMascota.aspx.cs" Inherits="WebVeterinaria.Formulario_web12" %>
<asp:Content ID="Content3" ContentPlaceHolderID="CUERPO" runat="server">
    <div class="col-sm-3 col-md-2 sidebar">
        <asp:Menu ID="mnuControl" runat="server" RenderingMode="List" Orientation="Vertical" StaticMenuStyle-CssClass="nav nav-sidebar" IncludeStyleBlock="false" Width="100%">
            <Items>
                <asp:MenuItem Value="opcAggMascota" Text="Registrar Mascota"></asp:MenuItem>
                <asp:MenuItem Value="opcEditMascota" Text="Editar Mascota"></asp:MenuItem>
                <asp:MenuItem Value="opcBuscarMascota" Text="Buscar Mascota"></asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Mascota</h1>
        <asp:Panel ID="PanelMascota" runat="server">
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

                    <div class="tmg-10">
                        <strong>Cedula Cliente:</strong>
                        <div class="row">
                            <div class="col-md-9">
                                <asp:TextBox ID="txtCcCliente" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="btnBuscarXCedula" runat="server" Text="Buscar" CssClass="btn btn-md btn-success" />
                            </div>
                        </div>
                    </div>

                    <div class="tmg-10">
                        <strong>Nombre Cliente:</strong>
                        <asp:TextBox ID="txtNombreCliente" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>


                    <div class="row tmg-10">
                        <div class="col-md-6">
                            <strong>Tipo de Mascota:</strong>
                            <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <strong>Raza:</strong>
                            <asp:DropDownList ID="ddlRaza" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="tmg-10">
                        <strong>Estado:</strong>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:RadioButtonList ID="rbtnEstado" runat="server" CssClass="form-control" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="opcVivo" Selected="True">Vivo</asp:ListItem>
                                    <asp:ListItem Value="opcMuerto">Muerto</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-md-6">
                    <strong>Próxima Cita:</strong>
                    <asp:Calendar ID="CalendarProxCita" runat="server" Width="100%" CellPadding="5" Height="300px">
                        <TitleStyle BackColor="#0F3D64" Font-Bold="True" ForeColor="White" />
                        </asp:Calendar>
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
            <h2 class="sub-header">Registro de Mascotas</h2>
            <div class="table-responsive">
                <asp:GridView ID="grvMascotas" runat="server" CssClass="table table-striped">
                    <AlternatingRowStyle BackColor="#E1E1E1" />
                </asp:GridView>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
