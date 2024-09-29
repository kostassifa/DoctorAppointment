using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            litMessage.Text = string.Empty;
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Get the username and password from the TextBox controls
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            //Debug.WriteLine($"Username: {username}");
            //Debug.WriteLine($"Password: {password}");
            // Define the query to check for matching username and password
            string query = "SELECT COUNT(*) FROM user WHERE amka = @Username AND Password = @Password";

            // Get the connection string from the Web.config file
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            // Using block ensures the connection is closed and disposed of properly
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    // Add parameters to prevent SQL injection
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    try
                    {
                        // Open the connection
                        conn.Open();

                        // Execute the query and get the result
                        int userCount = Convert.ToInt32(cmd.ExecuteScalar());

                        if (userCount > 0)
                        {
                            Session["Username"] = username;
                            // If a match is found, redirect to the main page or another secure page
                            Response.Redirect("Main.aspx");
                        }
                        else
                        {
                            // If no match is found, display an error message
                            litMessage.Text = "<p class='error-message'>Invalid username or password.</p>";
                        }
                    }
                    catch (Exception )
                    {
                        // Handle exceptions (e.g., log the error and show a friendly message)
                        litMessage.Text = "<p class='error-message'>An error occurred while connecting to the database.</p>";
                    }
                }
            }
        }
    }
}