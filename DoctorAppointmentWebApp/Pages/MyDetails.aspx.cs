using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Web.UI;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class MyDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string username = Session["Username"].ToString();
                if (!IsPostBack)
                {
                    LoadUserDetails(username);
                }
            }
            else
            {
                // Redirect to login page if session has expired or user is not logged in
                Response.Redirect("~/Pages/Login.aspx");
            }
        }

        private void LoadUserDetails(string username)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = "SELECT * FROM doctorappointmentwebapp.user WHERE amka=@username";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    conn.Open();

                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            amka.InnerText = reader["amka"].ToString();
                            full_name.InnerText = reader["full_name"] != DBNull.Value ? reader["full_name"].ToString() : "N/A";
                            specialty.InnerText = reader["speciality"] != DBNull.Value ? reader["speciality"].ToString() : "N/A";
                            phone.Text = reader["phone"] != DBNull.Value ? reader["phone"].ToString() : "N/A";
                            email.Text = reader["email"] != DBNull.Value ? reader["email"].ToString() : "N/A";
                            address.Text = reader["address"] != DBNull.Value ? reader["address"].ToString() : "N/A";
                            type.InnerText = reader["type"] != DBNull.Value ? reader["type"].ToString() : "N/A";
                            region.InnerText = reader["region"] != DBNull.Value ? reader["region"].ToString() : "N/A";
                        }
                    }

                    // Get active appointments count
                    string appointmentQuery = "SELECT COUNT(*) FROM doctorappointmentwebapp.appoitment WHERE amka=@username";
                    using (MySqlCommand appointmentCmd = new MySqlCommand(appointmentQuery, conn))
                    {
                        appointmentCmd.Parameters.AddWithValue("@username", username);

                        int activeDatesCount = Convert.ToInt32(appointmentCmd.ExecuteScalar());
                        active_dates.InnerText = activeDatesCount.ToString();  // Display active dates count
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Clear any previous messages
            lblMessage.Text = "";
            lblMessage.CssClass = "message";

            try
            {
                string username = Session["Username"].ToString();
                string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

                using (MySqlConnection conn = new MySqlConnection(connectionString))
                {
                    string updateQuery = @"UPDATE doctorappointmentwebapp.user 
                                           SET phone=@Phone, address=@Address, email=@Email
                                           WHERE amka=@Username";

                    using (MySqlCommand cmd = new MySqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Phone", phone.Text);
                        cmd.Parameters.AddWithValue("@Address", address.Text);
                        cmd.Parameters.AddWithValue("@Email", email.Text);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Show success message
                lblMessage.Text = "Profile updated successfully!";
                lblMessage.CssClass = "message success";

                // Optionally reload the details
                LoadUserDetails(username);
            }
            catch (Exception ex)
            {
                // Show error message in case of failure
                lblMessage.Text = "Error updating profile: " + ex.Message;
                lblMessage.CssClass = "message error";
            }
        }
    }
}
