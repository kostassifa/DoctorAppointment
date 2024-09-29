using System;
using System.Configuration;
using System.Diagnostics;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        private string token;
        private string amka;

        protected void Page_Load(object sender, EventArgs e)
        {
            litMessage.Text = string.Empty;

            token = Request.QueryString["token"];

            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(token))
                {
                    litMessage.Text = "<p class='error-message'>Invalid password reset token.</p>";
                    DisableControls();
                }
                else
                {
                    // Verify token
                    if (!VerifyToken(token))
                    {
                        litMessage.Text = "<p class='error-message'>The password reset link is invalid or has expired.</p>";
                        DisableControls();
                    }
                }
            }
        }

        private bool VerifyToken(string token)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = "SELECT amka FROM user WHERE ResetPasswordToken = @Token and ResetTokenExpiry>@Now";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Token", token);
                    cmd.Parameters.AddWithValue("@Now", DateTime.Now);

                    try
                    {
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            amka = result.ToString();
                            return true;
                        }
                        else
                        {
                            return false;
                        }
                    }
                    catch (Exception)
                    {
                        // Handle exceptions
                        return false;
                    }
                }
            }
        }

        private void DisableControls()
        {
            txtNewPassword.Enabled = false;
            txtConfirmPassword.Enabled = false;
            btnResetPassword.Enabled = false;
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            Debug.WriteLine("AMKA_HERE:"+amka);
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                litMessage.Text = "<p class='error-message'>Please enter the new password and confirm it.</p>";
                return;
            }

            if (newPassword != confirmPassword)
            {
                litMessage.Text = "<p class='error-message'>Passwords do not match.</p>";
                return;
            }

            // Update password in the database
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = "SELECT amka FROM user WHERE ResetPasswordToken = @Token ";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Token", token);
                    cmd.Parameters.AddWithValue("@Now", DateTime.Now);

                    try
                    {
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            amka = result.ToString();
                        }
                    }
                    catch (Exception)
                    {
                        litMessage.Text = "<p class='error-message'>An error occurred while fetching amka. Please try again later.</p>";
                    }
                }
            }

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string updateQuery = "UPDATE user SET Password = @Password, ResetPasswordToken = NULL, ResetTokenExpiry = NULL WHERE amka = @Amka";
                using (MySqlCommand cmd = new MySqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Password", newPassword);
                    cmd.Parameters.AddWithValue("@Amka", amka);

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            litMessage.Text = "<p class='success-message'>Your password has been reset successfully.</p>";
                            DisableControls();
                        }
                        else
                        {
                            litMessage.Text = "<p class='error-message'>An error occurred while resetting your password. Please try again later.</p>";
                        }
                    }
                    catch (Exception)
                    {
                        // Handle exceptions
                        litMessage.Text = "<p class='error-message'>An error occurred. Please try again later.</p>";
                    }
                }
            }
        }
    }
}
