using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebVeterinaria
{
    public partial class Formulario_web11 : System.Web.UI.Page
    {

        string strUsuario, strDescripcion;
        int intCodEmpleado, intCodigo, intCosto, intCargo;

        static string strApp;
        static int intOpcion = -1;

        protected void mnuControl_MenuItemClick(object sender, MenuEventArgs e)
        {
            txtCodigo.Text = "CAMBIO!";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {

                    strUsuario = Session["Usuario"].ToString();
                    intCodEmpleado = Convert.ToInt32(Session["CodEmpleado"]);

                    if (string.IsNullOrEmpty(strUsuario) || intCodEmpleado <= 0)
                    {
                        Response.Redirect("~/SplashScreen.aspx");
                    }

                }
                catch (Exception ex)
                {
                    Response.Redirect("~/SplashScreen.aspx");
                }
                strApp = System.Reflection.Assembly.GetExecutingAssembly().GetName().Name;
                LlenarGridCliente();
            }
        }

        #region Metodos Personalizados
        private void Limpiar()
        {
            txtApellido.Text = string.Empty;
            txtCodigo.Text = string.Empty;
            txtEmpleado.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtNroDoc.Text = string.Empty;
        }

        private void Mensaje(string Mensaje)
        {
            lblMensaje.Text = Mensaje;
        }

        private bool Buscar()
        {
            try
            {

                Mensaje(string.Empty);
                intCodigo =Convert.ToInt32(txtCodigo.Text.Trim());
                if (intCodigo <= 0)
                {
                    Mensaje("El codigo del servicio no es valido");
                    this.txtCodigo.Focus();
                    return false;
                }

                clsServicio objSER = new clsServicio(strApp);

                if (!objSER.BuscarCliente(strCedula, grvClientes, grvDirecciones, grvTelefonos))
                {
                    Mensaje(objCLI.strError);
                    objCLI = null;
                    this.txtCodigo.Focus();
                    return false;
                }
                this.txtCodigo.Text = objCLI.Cedula;
                this.txtNombre.Text = objCLI.Nombre;
                this.txtEmail.Text = objCLI.Email;
                this.txtEmpleado.Text = objCLI.NombreEmpleado;
                objCLI = null;
                return true;

            }
            catch (Exception ex)
            {
                Mensaje(ex.Message);
                return false;
            }
        }

        private void LlenarGridServicios()
        {
            clsServicio objSER = new clsServicio(strApp);
            objSER.LlenarGrid(grvServicios);
            objSER = null;
        }
        #endregion
    }
}