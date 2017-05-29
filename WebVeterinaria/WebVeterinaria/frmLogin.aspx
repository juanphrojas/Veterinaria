<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmLogin.aspx.cs" Inherits="WebVeterinaria.frmLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Contról Veterinario</title>

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="src/bootstrap/bootstrap.css" />

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="src/bootstrap/dashboard.css" />

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

      <style type="text/css">
          body {
              margin: 0px;
              padding: 0px;
              border: 0px;
              color: white;
          }
          .navbar-blue {
              background: #0f3d64;
              color: white;
              padding: 10px 10px;
          }
          .navbar-blue a {
              color: white;
          }
          .navbar-blue a:hover {
              color: #0f3d64;
          }
          .margin-right-20 {
              margin-right: 20px;
          }
          #MENU_mnuControl {
              float: right !important;
          }
          #CUERPO_mnuControl {
              float: none !important;
          }
          *[role="menu"]{
              float: none !important;
          }
          .tmg-10 {
              margin-top: 10px;
          }
          .splash {
              background: #0f3d64;
              display: flex;
              flex-direction:column;
              justify-content: center;
              align-items: center;
              height: 100vh;
          }
          form {
              width: 300px;
          }
      </style>
  </head>
<body>

<div class="splash">

<asp:Image ImageUrl="~/imagenes/logotipo.png" Height="140px" runat="server"/>

<form id="formLogin" runat="server">
  <div class="form-group">
    <label for="exampleInputEmail1">Usuario</label>
    <asp:TextBox ID="txtUsuario" CssClass="form-control" runat="server"></asp:TextBox>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Cod. Empleado</label>
    <asp:TextBox ID="txtCodEmpleado" TextMode="Password" CssClass="form-control" runat="server"></asp:TextBox>
  </div>
   <asp:Button ID="btnIngresar" Text="Ingresar" CssClass="btn btn-success" runat="server" OnClick="btnIngresar_Click"/>
</form>

<asp:Label ID="lblMensaje" runat="server"></asp:Label>


</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="src/bootstrap/jquery.min.js"><\/script>')</script>
<script src="src/bootstrap/bootstrap.min.js"></script>
</body>
</html>
