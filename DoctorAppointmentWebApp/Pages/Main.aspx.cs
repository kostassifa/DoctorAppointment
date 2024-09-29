using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    // User is logged in, show the username
                    string username = Session["Username"].ToString();
                    string userType = GetUserType(username); // Fetch user type from database

                    if (userType == "Doctor")
                    {
                        // Redirect to MainDoctor.aspx if the user is a doctor
                        Response.Redirect("MainDoctor.aspx");
                    }
                    else
                    {
                        // Display welcome message and options to log out
                        litButtons.Text = $"Welcome, <a href='#'>{username}</a> <a href='Logout.aspx'>Logout</a>";
                    }
                }
                else
                {
                    // User is not logged in, show Login and Register buttons
                    litButtons.Text = @"<a href='Login.aspx'>Login</a>
                                <a href='RegisterOption.aspx'>Register</a>";
                }
            }
        }

        private string GetUserType(string username)
        {
            string userType = string.Empty;

          
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            // SQL query to fetch the user type based on the username (AMKA)
            string query = "SELECT type FROM doctorappointmentwebapp.user WHERE amka = @Username";

            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                MySqlCommand command = new MySqlCommand(query, connection);
                command.Parameters.AddWithValue("@Username", username);

                try
                {
                    connection.Open();
                    MySqlDataReader reader = command.ExecuteReader();

                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            userType = reader["type"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions (e.g., logging)
                    throw new Exception("Error fetching user type", ex);
                }
                finally
                {
                    connection.Close();
                }
            }

            return userType;
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
    }
}
