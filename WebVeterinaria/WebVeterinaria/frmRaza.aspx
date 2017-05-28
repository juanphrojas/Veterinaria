<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmRaza.aspx.cs" Inherits="WebVeterinaria.Formulario_web13" %>
<asp:Content ID="Content3" ContentPlaceHolderID="CUERPO" runat="server">
    <div class="col-sm-3 col-md-2 sidebar">
        <asp:Menu ID="mnuControl" runat="server" RenderingMode="List" Orientation="Vertical" StaticMenuStyle-CssClass="nav nav-sidebar" IncludeStyleBlock="false" Width="100%">
            <Items>
                <asp:MenuItem Value="opcAggRaza" Text="Registrar Raza"></asp:MenuItem>
                <asp:MenuItem Value="opcEditRaza" Text="Editar Raza"></asp:MenuItem>
                <asp:MenuItem Value="opcBuscarRaza" Text="Buscar Raza"></asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Razas</h1>
        <asp:Panel ID="PanelRaza" runat="server">
            <div class="row">
                <div class="col-md-4">
                    <strong>Código:</strong>
                    <div class="row">
                        <div class="col-md-9">
                            <asp:TextBox ID="txtCodigo" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="btnBuscarXCodigo" Text="Buscar" CssClass="btn btn-success" runat="server"/>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <strong>Nombre:</strong>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <strong>Tipo:</strong>
                    <div class="row">
                        <div class="col-md-9">
                            <asp:DropDownList ID="ddlTipo" CssClass="form-control" runat="server"></asp:DropDownList>
                        </div>
                        <div class="col-md-3">
                            <asp:Button ID="btnBuscarXTipo" Text="Buscar" CssClass="btn btn-success" runat="server"/>
                        </div>
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

        <asp:Panel ID="PanelRegistros" runat="server">
            <h2 class="sub-header">Registro de Razas</h2>
            <div class="table-responsive">
                <asp:GridView ID="grvRazas" runat="server" CssClass="table table-striped">
                    <AlternatingRowStyle BackColor="#E1E1E1" />
                </asp:GridView>
            </div>
        </asp:Panel>

    </div>
</asp:Content>
