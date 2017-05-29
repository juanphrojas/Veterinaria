using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebVeterinaria
{
    public partial class Formulario_web13 : System.Web.UI.Page
    {

        string Usuario, CodEmpleado;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {

                    Usuario = Session["Usuario"].ToString();
                    CodEmpleado = Session["CodEmpleado"].ToString();

                    if (string.IsNullOrEmpty(Usuario) || string.IsNullOrEmpty(CodEmpleado))
                    {
                        Response.Redirect("~/SplashScreen.aspx");
                    }

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SplashScreen.aspx");
                }
            }
        }
    }
}