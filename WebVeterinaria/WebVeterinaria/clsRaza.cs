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
    public class clsRaza
    {
        #region propiedades
        public int Codigo { get; set; }
        public string Nombre { get; set; }
        public int idEmpleado { get; set; }
        public int idTipo { get; set; }
        private string strApp;
        private string strSQL;
        public string strError { get; private set; }
        private DataSet Myds;
        private DataTable Mydt;
        private SqlDataReader MyReader;
        #endregion

        #region constructor
        public clsRaza(string Aplicacion)
        {
            Codigo = 0;
            Nombre = string.Empty;
            idEmpleado = 0;
            idTipo = 0;
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
        }

        public clsRaza(string Aplicacion, int _Codigo, string _Nombre, int _idEmpleado, int _idTipo)
        {
            Codigo = _Codigo;
            Nombre = _Nombre;
            idEmpleado = _idEmpleado;
            idTipo = _idTipo;
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
                strError = "Falta el nombre";
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
            if (string.IsNullOrEmpty(idTipo.ToString()))
            {
                strError = "Falta el tipo";
                return false;
            }
            if (idTipo <= 0)
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
        public bool BuscarRaza(string _Codigo, GridView grid)
        {
            try
            {
                strSQL = "exec USP_RAZa_BuscarXCodigo '" + _Codigo + "';";
                clsConexionBD cnb = new clsConexionBD(strApp);
                cnb.SQL = strSQL;
                if (!cnb.Consultar(false))
                {
                    strError = cnb.Error;
                    cnb.CerrarCnx();
                    cnb = null;
                    return false;
                }

                MyReader = cnb.DataReader_Lleno;
                if (!MyReader.HasRows)// el hasrows es para decir si tiene o no tiene registro
                {
                    strError = "No existe registro para el codigo: " + _Codigo;
                    cnb.CerrarCnx();
                    cnb = null;
                    return false;
                }

                MyReader.Read();
                Codigo = MyReader.GetInt32(0);
                Nombre = MyReader.GetString(1);
                idEmpleado = MyReader.GetInt32(2);
                idTipo = MyReader.GetInt32(3);
                MyReader.Close();
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
                strSQL = "exec USP_RAZa_Grabar '" + Nombre + "','" + idEmpleado + "','" + idTipo + "';";
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
                strSQL = "exec USP_RAZa_Modificar '" + Codigo + "','" + Nombre + "','" + idEmpleado + "','" + idTipo + "';";
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

                strSQL = "exec USP_RAZa_BuscarGeneral;";
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