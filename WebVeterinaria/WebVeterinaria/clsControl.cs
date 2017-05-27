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
    public class clsControl
    {
        #region propiedades
        public int Codigo { get; set; }
        public DateTime Fecha { get; set; }
        public string idCliente { get; set; }
        public string NombreCliente { get; set; }
        public int idMascota { get; set; }
        public int idEmpleado { get; set; }
        public float PesoMascota { get; set; }
        public int EdadMascota { get; set; }
        public DateTime  ProximaCita { get; set; }
        public int ValorUnitario { get; set; }
        public int ValorTotal { get; set; }
        public int idServicio { get; set; }
        public int idPrestador { get; set; }
        public int siReceta { get; set; }
        private string strApp;
        private string strSQL;
        public string strError { get; private set; }
        private DataSet Myds;
        private DataTable Mydt;
        private SqlDataReader MyReader;
        #endregion

        #region constructor
        public clsControl (string Aplicacion)
        {
            Codigo = 0;
            Fecha = new DateTime();
            idCliente = string.Empty;
            idMascota = 0;
            idEmpleado = 0;
            PesoMascota = 0;
            EdadMascota = 0;
            ProximaCita = new DateTime();
            ValorUnitario = 0;
            ValorTotal = 0;
            idServicio = 0;
            idPrestador = 0;
            siReceta = 0;
            strApp = Aplicacion;
            strSQL = string.Empty;
            strError = string.Empty;
        }

        public clsControl (string Aplicacion, int _Codigo, DateTime _Fecha, string _idCliente, int _idMascota, int _idEmpleado, int _PesoMascota,
            int _EdadMascota, DateTime _ProximaCita, int _Valorunitario, int _ValorTotal, int _idServicio, int _idPrestador, int _siReceta)
        {
            Codigo = _Codigo;
            Fecha = _Fecha;
            idCliente = _idCliente;
            idEmpleado = _idEmpleado;
            idMascota = _idMascota;
            PesoMascota = _PesoMascota;
            EdadMascota = _EdadMascota;
            ProximaCita = _ProximaCita;
            ValorUnitario = _Valorunitario;
            ValorTotal = _ValorTotal;
            idServicio = _idServicio;
            idPrestador = _idPrestador;
            siReceta = _siReceta;
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
            if(!string.IsNullOrEmpty(ProximaCita.ToString()))
            {
                if(ProximaCita<=DateTime.Today)
                {
                    strError = "Fecha de la proxima cita no valida";
                }
            }
            if (Fecha< DateTime.Today)
            {
                strError = "Fecha no valida";
                return false;
            }
            if (string.IsNullOrEmpty(idCliente))
            {
                strError = "Falta el cliente";
                return false;
            }
            if (string.IsNullOrEmpty(idMascota.ToString()))
            {
                strError = "Falta la mascota";
                return false;
            }
            if (idMascota <= 0)
            {
                strError = "la mascota seleccionada no es valida";
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
            if (string.IsNullOrEmpty(PesoMascota.ToString()))
            {
                strError = "Falta el empleado";
                return false;
            }
            if (PesoMascota <= 0)
            {
                strError = "El empleado seleccionado no es valido";
                return false;
            }
            if(siReceta<0 || siReceta>1)
            {
                strError = "La opcion de receta no es valida";
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
        public bool BuscarCliente(string _Codigo, GridView grid)
        {
            try
            {
                strSQL = "exec USP_CONtrol_BuscarXCodigo '" + _Codigo + "';";
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
                    Fecha = Convert.ToDateTime(dr[1]);
                    idCliente = dr[2].ToString();
                    NombreCliente = dr[3].ToString();
                    idMascota = Convert.ToInt32(dr[4]);
                    idEmpleado = Convert.ToInt32(dr[5]);
                    PesoMascota = Convert.ToSingle(dr[6]);
                    EdadMascota = Convert.ToInt32(dr[7]);
                    ProximaCita = Convert.ToDateTime(dr[8]);
                    ValorTotal = Convert.ToInt32(dr[9]);
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

        private bool BuscarValorServicio()
        {
            try
            {
                strSQL = "exec USP_TIpoMAscota_BuscarXCodigo '" + idServicio + "';";
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
                    strError = "No existe registro para el codigo: " + idServicio;
                    cnb.CerrarCnx();
                    cnb = null;
                    return false;
                }

                MyReader.Read();
                ValorUnitario = MyReader.GetInt32(0);
                return true;
            }
            catch (Exception ex)
            {
                strError = ex.Message;
                return false;
            }
        }

        public bool LlenarComboServicio(DropDownList Combo)
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
                
                strSQL = "exec USP_SERvicio_LlenarComboServicio;";

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

        public bool LlenarComboPrestador(DropDownList Combo, int _Servicio)
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

                strSQL = "exec USP_EMPleado_LlenarComboPorCargo "+_Servicio+";";

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

        public bool LlenarComboMascota(DropDownList Combo, string _Cliente)
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

                strSQL = "exec USP_Mascota_LlenarComboPorCliente " + _Cliente + ";";

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
                strSQL = "exec USP_CONtrol_Grabar '" + Fecha + "','" + idCliente + "','" + idMascota + "','" + idEmpleado + "','" + PesoMascota + "','" + EdadMascota + "','" + ProximaCita + "';";
                if (!Grabar())
                    return false;

                strSQL = "USP_CONtrol_AgregarServicio '" + Codigo + "','" + idServicio + "'," + idEmpleado + "," + siReceta + ";";
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

        public bool AgregarServicio()

        {
            try
            {
                if (Codigo<0)
                {
                    strError = "Codigo del control no valido";
                    return false;
                }

                if (idServicio < 0)
                {
                    strError = "Servicio seleccionado no valido";
                    return false;
                }
                if (idEmpleado < 0)
                {
                    strError = "Empleado seleccionado no valido";
                    return false;
                }
                if (siReceta < 0 || siReceta>1)
                {
                    strError = "Opcion de receta no valida";
                    return false;
                }

                strSQL = "USP_CONtrol_AgregarServicio '" + Codigo + "','" + idServicio + "'," + idEmpleado + "," + siReceta + ";";
                if (!Grabar())
                    return false;

                strSQL = "USP_CONtrol_AgregarValor '" + Codigo + "','" + idServicio + ";";
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
                strSQL = "exec USP_CLIente_Modificar '" + Codigo + "','" + idCliente + "','" + idMascota + "','" + idEmpleado + "','" + PesoMascota + "','" + EdadMascota + "','" + ProximaCita + "','" + ValorTotal + "';";
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