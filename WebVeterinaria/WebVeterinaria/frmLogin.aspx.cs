using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebVeterinaria
{
    public partial class frmLogin : System.Web.UI.Page
    {


        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            string Usuario, CodEmpleado, Acceso;

            Usuario = this.txtUsuario.Text.Trim();
            CodEmpleado = this.txtCodEmpleado.Text.Trim();

            Acceso = "granted"; // accesa:granted, no accesa: denied

            if (Acceso == "granted")
            {
                Session["Usuario"] = Usuario;
                Session["CodEmpleado"] = CodEmpleado;
                Response.Redirect("~/frmControl.aspx");
            } else
            {
                lblMensaje.Text = "Ups ! Ha ocurrido un error ! intenta de nuevo";
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}