<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SplashScreen.aspx.cs" Inherits="WebVeterinaria.SplashScreen" %>

<!DOCTYPE html>

<html lang="es-co">
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
          img {
              height: 300px;
              width: 270px;
              margin-bottom: 20px;
          }
          h1 {
              color: white;
              
          }
      </style>
  </head>
  <body>
<div >
    <form class="splash" id="formSpash" runat="server">
    
        <asp:Image ImageUrl="~/imagenes/logotipo.png" runat="server"/>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" Interval="2500" OnTick="Timer1_Tick">
        </asp:Timer>
        <h1>CONTROL VETERINARIO</h1>

    </form>
</div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="src/bootstrap/jquery.min.js"><\/script>')</script>
    <script src="src/bootstrap/bootstrap.min.js"></script>
  </body>
</html>
