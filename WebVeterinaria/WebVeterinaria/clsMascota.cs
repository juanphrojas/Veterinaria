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
    public class clsMascota
    {
        #region propiedades
        public int Codigo { get; set; }
        public string Nombre { get; set; }
        public string idCliente { get; set; }
        public int idEmpleado { get; set; }
        public int idTipoMascota { get; set; }
        public int idRaza { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public int Estado { get; set; }
        private string strApp;
        private string strSQL;
        public string strError { get; private set; }
        private DataSet Myds;
        private DataTable Mydt;
        private SqlDataReader MyReader;
        #endregion

        #region constructor
        public clsMascota(string Aplicacion)
        {
            Codigo = 0;
            Nombre = string.Empty;
            idCliente = string.Empty;
            idEmpleado = 0;
            idTipoMascota = 0;
            idRaza = 0;
            FechaNacimiento = new DateTime();
            Estado = 0;
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
        }

        public clsMascota(string Aplicacion, int _Codigo, string _Nombre, 
            string _idCliente, int _idEmpleado, int _idTipoMascota, int _idRaza, DateTime _FechaNacimiento)
        {
            Codigo = _Codigo;
            Nombre = _Nombre;
            idCliente = _idCliente;
            idEmpleado = _idEmpleado;
            idTipoMascota = _idTipoMascota;
            idRaza = _idRaza;
            FechaNacimiento = _FechaNacimiento;
            Estado = 0;
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
            
            if (string.IsNullOrEmpty(Nombre))
            {
                strError = "Falta el Nombre";
                return false;
            }

            if (string.IsNullOrEmpty(idTipoMascota.ToString()))
            {
                strError = "Falta el tipo de mascota";
                return false;
            }

            if (idTipoMascota <= 0)
            {
                strError = "El tipo de mascota seleccionado no es valido";
                return false;
            }

            if (string.IsNullOrEmpty(idRaza.ToString()))
            {
                strError = "Falta la raza de la mascota";
                return false;
            }

            if (idRaza <= 0)
            {
                strError = "La raza de la mascota no es valida";
                return false;
            }
            if (FechaNacimiento > DateTime.Today)
            {
                strError = "Fecha de nacimiento no valida";
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

                Codigo = Convert.ToInt32( objCnx.VrUnico);
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
        public bool BuscarMascota(int _Codigo, GridView grid)
        {
            try
            {
                strSQL = "exec USP_MAScota_BuscarXCodigo '" + _Codigo + "';";
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
                    Nombre = dr[1].ToString();
                    idCliente = dr[2].ToString();
                    idEmpleado = Convert.ToInt32(dr[4]);
                    idTipoMascota = Convert.ToInt32(dr[5]);
                    idRaza = Convert.ToInt32(dr[6]);
                    FechaNacimiento = Convert.ToDateTime(dr[7]);
                    Estado = Convert.ToInt32(dr[8]);
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

        public bool LlenarComboTipo(DropDownList Combo )
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

                strSQL = "exec USP_CLIente_LlenarComboTipoMascota;";

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

        public bool LlenarComboRaza(DropDownList Combo, int _Tipo)
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

                strSQL = "exec USP_CLIente_LlenarComboCargo "+_Tipo+";";

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
                strSQL = "exec USP_MAScota_Grabar '" + Nombre + "','" + idCliente + "','" + idEmpleado + "','" + idTipoMascota + "','" + idRaza + "','" + FechaNacimiento + "';";
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
                strSQL = "exec USP_MAScota_Modificar '" + Codigo + "','" + Nombre + "','" + Nombre + "','" + idCliente + "','" + idEmpleado + "','" + idTipoMascota + "','" + idRaza + "','" +FechaNacimiento+ "','" +Estado+ "';";
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

                strSQL = "exec USP_MAScota_BuscarGeneral;";
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