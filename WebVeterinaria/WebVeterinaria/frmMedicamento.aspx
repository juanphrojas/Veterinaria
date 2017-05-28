<%@ Page Title="" Language="C#" MasterPageFile="~/frmPrincipal.Master" AutoEventWireup="true" CodeBehind="frmMedicamento.aspx.cs" Inherits="WebVeterinaria.Formulario_web14" %>
<asp:Content ID="Content3" ContentPlaceHolderID="CUERPO" runat="server">
    <div class="col-sm-3 col-md-2 sidebar">
        <asp:Menu ID="mnuControl" runat="server" RenderingMode="List" Orientation="Vertical" StaticMenuStyle-CssClass="nav nav-sidebar" IncludeStyleBlock="false" Width="100%">
            <Items>
                <asp:MenuItem Value="opcAggMedicamento" Text="Registrar Medicamento"></asp:MenuItem>
                <asp:MenuItem Value="opcEditMedicamento" Text="Editar Medicamento"></asp:MenuItem>
                <asp:MenuItem Value="opcBuscarMedicamento" Text="Buscar Medicamento"></asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        <h1 class="page-header">Medicamentos</h1>
        <asp:Panel ID="PanelMedicamento" runat="server">
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

                <div class="col-md-8">
                    <strong>Nombre:</strong>
                    <asp:TextBox ID="txtNombre" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

            </div>

            <div class="row">
                <div class="col-md-4">
                    <asp:Button ID="btnRegistrar" Text="Registrar Medicamento" CssClass="btn btn-primary" runat="server"/>
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
            <h2 class="sub-header">Registro de Medicamentos</h2>
            <div class="table-responsive">
                <asp:GridView ID="grvMedicamentos" runat="server" CssClass="table table-striped">
                    <AlternatingRowStyle BackColor="#E1E1E1" />
                </asp:GridView>
            </div>
        </asp:Panel>

    </div>
</asp:Content>
