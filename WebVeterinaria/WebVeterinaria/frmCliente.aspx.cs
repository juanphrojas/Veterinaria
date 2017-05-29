using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebVeterinaria
{
    public partial class Formulario_web16 : System.Web.UI.Page
    {
        string strCedula, strNombre, strNumeroTel, strDireccion, strUsuario, ;
        int intCodEmpleado, intTipoTel, intCiudad;
        DateTime FechaNacimiento;

        static string strApp;
        static int intOpcion = -1;

        protected void mnuControl_MenuItemClick(object sender, MenuEventArgs e)
        {
                        
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {

                    strUsuario = Session["Usuario"].ToString();
                    intCodEmpleado = Convert.ToInt32(Session["CodEmpleado"]);

                    if (string.IsNullOrEmpty(strUsuario) || intCodEmpleado<= 0)
                    {
                        Response.Redirect("~/SplashScreen.aspx");
                    }

                }
                catch (Exception ex)
                {
                    lblMensaje.Text = ex.Message;
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
                strCedula = txtCodigo.Text.Trim();
                if (string.IsNullOrEmpty(strCedula))
                {
                    Mensaje("La cedula del cliente no es valida");
                    this.txtCodigo.Focus();
                    return false;
                }

                clsCliente objCLI = new clsCliente(strApp);

                if (!objCLI.BuscarCliente(strCedula, grvClientes, grvDirecciones, grvTelefonos))
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

        private void LlenarGridCliente()
        {
            clsCliente objCLI = new clsCliente(strApp);
            objCLI.LlenarGrid(grvClientes);
            objCLI = null;
        }
        #endregion
    }

}