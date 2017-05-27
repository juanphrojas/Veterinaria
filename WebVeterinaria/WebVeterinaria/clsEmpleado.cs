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
    public class clsEmpleado
    {
        #region propiedades
        public int Codigo { get; set; }
        public string Cedula { get; set; }
        public string Nombre { get; set; }
        public int idCargo { get; set; }
        public string Usuario { get; set; }
        public string Contrasena { get; set; }
        public int Estado { get; set; }
        private string strApp;
        private string strSQL;
        public string strError { get; private set; }
        private DataSet Myds;
        private DataTable Mydt;
        private SqlDataReader MyReader;
        #endregion

        #region constructor
        public clsEmpleado(string Aplicacion)
        {
            Codigo = 0;
            Cedula = string.Empty;
            Nombre = string.Empty;
            idCargo = 0;
            Usuario = string.Empty;
            Contrasena = string.Empty;
            Estado = 0;
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
        }

        public clsEmpleado(string Aplicacion,int _Codigo, string _Cedula, string _Nombre, int _idCargo, string _Usuario, string _Contrasena, int _Estado)
        {
            Codigo = _Codigo;
            Cedula = _Cedula;
            Nombre = _Nombre;
            idCargo = _idCargo;
            Usuario = _Usuario;
            Contrasena = _Contrasena;
            Estado = _Estado;
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
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

            if (string.IsNullOrEmpty(Usuario))
            {
                strError = "Falta el usuario";
                return false;
            }

            if (string.IsNullOrEmpty(Contrasena))
            {
                strError = "Falta la contraseña";
                return false;
            }

            
            if (string.IsNullOrEmpty(idCargo.ToString()))
            {
                strError = "Falta el cargo";
                return false;
            }
            if (idCargo <= 0)
            {
                strError = "El cargo seleccionado";
                return false;
            }
            if (string.IsNullOrEmpty(Estado.ToString()))
            {
                strError = "Falta el estado del empleado";
                return false;
            }
            if (Estado <= 0)
            {
                strError = "El estado seleccionado para el empleado no es valido";
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

                Codigo = Convert.ToInt32(objCnx.VrUnico);
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
        public bool BuscarEmpleado(string _Codigo, GridView grid)
        {
            try
            {
                strSQL = "exec USP_EMPleado_BuscarXCodigo '" + _Codigo.Trim() + "';";
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
                    strError = "No existe el cliente con cedula: " + _Codigo;
                    Myds.Clear();
                    Myds = null;
                    return false;

                }
                //Recuperar info desde el Primer DataTable
                foreach (DataRow dr in Mydt.Rows)
                {
                    Codigo = Convert.ToInt32(dr[0]);
                    Cedula = dr[1].ToString();
                    Nombre = dr[2].ToString();
                    idCargo = Convert.ToInt32(dr[3]);
                    Usuario = dr[4].ToString();
                    Estado = Convert.ToInt32(dr[5]);
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

        public bool LlenarCombo(DropDownList Combo)
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
                
                strSQL = "exec USP_CLIente_LlenarComboCargo;";

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
                strSQL = "exec USP_EMPleado_Grabar '" + Cedula + "','" + Nombre + "','" + idCargo + "','" + Usuario + "','" + Contrasena + "','"+Estado+"';";
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
                strSQL = "exec USP_EMPleado_Modificar '" +Codigo +"','" + Cedula + "','" + Nombre + "','" + idCargo + "','" + Usuario + "','" + Contrasena + "','" + Estado + "';";
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

                strSQL = "exec USP_EMPleado_BuscarGeneral;";
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