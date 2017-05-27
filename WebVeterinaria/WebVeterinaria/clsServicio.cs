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
    public class clsServicio
    {
        #region propiedades
        public int Codigo { get; set; }
        public string Descripcion { get; set; }
        public int Costo { get; set; }
        public int idEmpleado { get; set; }
        public int idCargo { get; set; }
        private string strApp;
        private string strSQL;
        public string strError { get; private set; }
        private DataSet Myds;
        private DataTable Mydt;
        private SqlDataReader MyReader;
        #endregion

        #region constructor
        public clsServicio(string Aplicacion)
        {
            Codigo = 0;
            Descripcion = string.Empty;
            Costo = 0;
            idEmpleado = 0;
            idCargo = 0;
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
        }

        public clsServicio(string Aplicacion, int _Codigo, string _Descripcion, int _Costo, int _idEmpleado, int _idTipo)
        {
            Codigo = _Codigo;
            Descripcion = _Descripcion;
            Costo = _Costo;
            idEmpleado = _idEmpleado;
            idCargo = _idTipo;
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
            if (string.IsNullOrEmpty(Descripcion))
            {
                strError = "Falta el nombre";
                return false;
            }
            if (string.IsNullOrEmpty(Costo.ToString()))
            {
                strError = "Falta el costo";
                return false;
            }
            if (Costo <= 0)
            {
                strError = "El costo dado no es valido";
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
            if (string.IsNullOrEmpty(idCargo.ToString()))
            {
                strError = "Falta el tipo";
                return false;
            }
            if (idCargo <= 0)
            {
                strError = "El tipo de mascota seleccionado no es valido";
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
        public bool BuscarServicio(string _Codigo, GridView grid)
        {
            try
            {
                strSQL = "exec USP_SERvicio_BuscarXCodigo '" + _Codigo + "';";
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
                    Descripcion = dr[1].ToString();
                    Costo = Convert.ToInt32(dr[2]);
                    idEmpleado = Convert.ToInt32(dr[3]);
                    idCargo = Convert.ToInt32(dr[4]);
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

        public bool insertar()
        {
            try
            {
                if (!ValidarDatos())
                    return false;
                strSQL = "exec USP_SERvicio_Grabar '" + Descripcion + "','" + Costo + "','" + idEmpleado + "','" + idCargo + "';";
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
                strSQL = "exec USP_RAZa_Modificar '" + Codigo + "','" + Descripcion + "','" + Costo + "','" + idEmpleado + "','" + idCargo + "';";
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

                strSQL = "exec USP_SERvicio_BuscarGeneral;";
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