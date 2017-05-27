using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using LibLlenarCombos;
using LibConexionBD;
using LibLlenarGrids;
using System.Data;

namespace WebVeterinaria
{
    public class clsCliente
    {
        #region propiedades
        public string Cedula { get; set; }
        public string Nombre { get; set; }
        public int idEmpleado { get; set; }
        public string Email { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string NumeroTel { get; set; }
        public int TipoTel { get; set; }
        public string Direccion { get; set; }
        public int Ciudad { get; set; }
        private string strApp;
        private string strSQL;
        public string strError { get; private set; }
        private DataSet Myds;
        private DataTable Mydt;
        private SqlDataReader MyReader;
        #endregion

        #region constructor
        public clsCliente(string Aplicacion)
        {
            Cedula = string.Empty;
            Nombre = string.Empty;
            idEmpleado = 0;
            Email = string.Empty;
            FechaNacimiento = new DateTime();
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
            NumeroTel = string.Empty;
            TipoTel = 0;
            Direccion = string.Empty;
            Ciudad = 0;
        }

        public clsCliente(string Aplicacion, string _Cedula, string _Nombre, string _Email, DateTime _FechaNacimiento, int _Empleado, string _NumeroTel, int _TipoTel, string _Direccion, int _Ciudad)
        {
            Cedula = _Cedula;
            Nombre = _Nombre;
            idEmpleado = _Empleado;
            Email = _Email;
            FechaNacimiento = _FechaNacimiento;
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
            NumeroTel = _NumeroTel;
            TipoTel = _TipoTel;
            Direccion = _Direccion;
            Ciudad = _Ciudad;
        }
        #endregion

        #region metodos privados
        private bool ValidarAplicacion()
        {
            if (string.IsNullOrEmpty(strApp))
            {
                strError = "Falta el nombre de la aplicacion";
                return false;
            }
            return true;
        }

        private bool ValidarDatos()
        {
            if (string.IsNullOrEmpty(Cedula))
            {
                strError = "Falta el numero de la cedula";
                return false;
            }

            if (string.IsNullOrEmpty(Nombre))
            {
                strError = "Falta el nombre";
                return false;
            }

            if (string.IsNullOrEmpty(Email))
            {
                strError = "Falta el email";
                return false;
            }

            if (FechaNacimiento >= DateTime.Now)
            {
                strError = "La fecha de nacimiento no es valida";
                return false;
            }

            if (string.IsNullOrEmpty(NumeroTel))
            {
                strError = "Falta el telefono";
                return false;
            }
            if (string.IsNullOrEmpty(Direccion))
            {
                strError = "Falta direccion";
                return false;
            }

            if (string.IsNullOrEmpty(idEmpleado.ToString()))
            {
                strError = "Falta el empleado";
                return false;
            }
            if (idEmpleado <= 0)
            {
                strError = "El empleado seleccionado no es valido";
                return false;
            }
            if (string.IsNullOrEmpty(TipoTel.ToString()))
            {
                strError = "Falta el Tipo de telefono";
                return false;
            }
            if (TipoTel <= 0)
            {
                strError = "El tipo de telefono seleccionado no es valido";
                return false;
            }
            if (string.IsNullOrEmpty(Ciudad.ToString()))
            {
                strError = "Falta la ciudad";
                return false;
            }
            if (Ciudad <= 0)
            {
                strError = "La ciudad seleccionada no es valida";
                return false;
            }
            return true;
        }

        private bool Grabar()
        {
            try
            {
                if (!ValidarAplicacion())
                    return false;
                clsConexionBD objCnx = new clsConexionBD(strApp);
                objCnx.SQL = strSQL;

                if (!objCnx.ConsultarValorUnico(false))
                {
                    strError = objCnx.Error;
                    objCnx.CerrarCnx();
                    objCnx = null;
                    return false;
                }

                Cedula = objCnx.VrUnico.ToString();
                objCnx.CerrarCnx();
                objCnx = null;
                return true;
            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;
            }
        }
        #endregion

        #region metodos publicos
        public bool BuscarCliente(string _Cedula, GridView grid)
        {
            try
            {
                strSQL = "exec USP_CLIente_BuscarXCodigo '" + _Cedula.Trim() + "';";
                clsConexionBD objCnx = new clsConexionBD(strApp);
                objCnx.SQL = strSQL;
                if (!objCnx.LlenarDataSet(false))
                {
                    strError = objCnx.Error;
                    objCnx.CerrarCnx();
                    objCnx = null;
                    return false;
                }

                Myds = objCnx.DataSet_Lleno;
                objCnx = null;
                //Leer desde el Primer DataTable
                Mydt = Myds.Tables[0];
                if (Mydt.Rows.Count <= 0)
                {
                    strError = "No existe el cliente con cedula: " + _Cedula;
                    Myds.Clear();
                    Myds = null;
                    return false;

                }
                //Recuperar info desde el Primer DataTable
                foreach (DataRow dr in Mydt.Rows)
                {
                    Cedula = dr[0].ToString();
                    Nombre = dr[1].ToString();
                    idEmpleado = Convert.ToInt32(dr[2]);
                    Email = dr[3].ToString();
                    FechaNacimiento = Convert.ToDateTime(dr[4]);
                }
                Mydt.Clear();
                //Llenar el Grid
                Mydt = Myds.Tables[1];
                grid.DataSource = Mydt;
                grid.DataBind();
                return true;
            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool LlenarCombo(DropDownList Combo, int Eleccion)
        {
            try
            {
                if (!ValidarAplicacion())
                    return false;
                if (Combo == null)
                {
                    strError = "Sin Combo a Llenar";
                    return false;
                }
                if(Eleccion==1)
                    strSQL = "exec USP_CLIente_LlenarComboTipoTel;";
                else
                    strSQL = "exec USP_CLIente_LlenarComboCiudad;";

                clsLlenarCombos objXX = new clsLlenarCombos(strApp);
                objXX.SQL = strSQL;
                objXX.CampoID = "Clave";
                objXX.CampoTexto = "Dato";
                if (!objXX.LlenarCombo_Web(Combo))
                {
                    strError = objXX.Error;
                    objXX = null;
                    return false;
                }
                objXX = null;
                return true;

            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;

            }
        }

        public bool insertar()
        {
            try
            {
                if (!ValidarDatos())
                    return false;
                strSQL = "exec USP_CLIente_Grabar '" + Cedula + "','" + Nombre + "','" + idEmpleado + "','" + Email + "','" + FechaNacimiento +"';";
                if (!Grabar())
                    return false;

                strSQL = "USP_CLIente_AgregarTelefono '" + Cedula + "','" + NumeroTel + "'," + idEmpleado + "," + TipoTel + ";";
                if (!Grabar())
                {
                    //si falla borrar encabezado

                    return false;
                }


                strSQL = "USP_CLIente_AgregarDomicilio '" + Cedula + "','" + Direccion + "'," + idEmpleado + "," + Ciudad + ";";
                if (!Grabar())
                    return false;

                return true;
            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool Modificar()
        {
            try
            {
                if (!ValidarDatos())
                    return false;
                strSQL = "exec USP_CLIente_Modificar '" + Cedula + "','" + Nombre + "','" + idEmpleado + "','" + Email + "','" +FechaNacimiento+ "';";
                return Grabar();
            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool LlenarGrid(GridView grid)
        {
            try
            {
                if (!ValidarAplicacion())
                    return false;
                if (grid == null)
                {
                    strError = "Sin grid  a llenar";
                    return false;
                }

                strSQL = "exec USP_CLIente_BuscarGeneral;";
                clsLlenarGrids objxx = new clsLlenarGrids(strApp);
                objxx.SQL = strSQL;
                if (!objxx.LlenarGrid_Web(grid))
                {
                    strError = objxx.Error;
                    objxx = null;
                    return false;
                }

                objxx = null;
                return true;
            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;
            }
        }
        #endregion
    }
}