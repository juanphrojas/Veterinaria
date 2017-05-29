using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebVeterinaria
{
    public partial class SplashScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            if (Timer1.Interval == 2500)
            {
                Response.Redirect("~/frmLogin.aspx");
            }
        }
    }
}