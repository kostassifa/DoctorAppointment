using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class MainDoctor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    // User is logged in, show the username
                    string username = Session["Username"].ToString();
                    litButtons.Text = $"Welcome, <a href='#'>{username}</a>    <a href='Logout.aspx'>Logout</a>";
                }
                else
                {
                    // User is not logged in, show Login and Register buttons
                    litButtons.Text = @"<a href='Login.aspx'>Login</a>
                                <a href='RegisterOption.aspx'>Register</a>";
                }
            }
        }

        protected void btnMyDetails_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/MyDetails.aspx");
        }

        protected void btnBookAppointment_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/BookAppoitment.aspx");
        }

        protected void btnCancelBooking_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/CancelBooking.aspx");
        }

        protected void btnViewBookings_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/ViewBookings.aspx");
        }

        protected void btnSearchDoctor_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/SearchDoctor.aspx");
        }
        protected void btnCancelBookingDoctor_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/CancelBookingDoctor.aspx");
        }
        protected void  btnViewBookingsDoctor_Click(object sender, EventArgs e) 
        {
            Response.Redirect("~/Pages/ViewBookingsDoctor.aspx");
        }
    }
}