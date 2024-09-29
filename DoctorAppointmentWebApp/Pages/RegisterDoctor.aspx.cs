using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class RegisterDoctor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRegions();
                LoadSpeciality();
                ddlRegion.SelectedIndex = 0;
                ddlSpeciality.SelectedIndex = 0;
            }
        }

        private void LoadRegions()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT city FROM doctorappointmentwebapp.Region ORDER BY city";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlRegion.Items.Clear();
                        ddlRegion.Items.Add(new ListItem("Select a region", ""));
                        while (reader.Read())
                        {
                            ddlRegion.Items.Add(new ListItem(reader["city"].ToString()));
                        }
                    }
                }
            }
        }

        private void LoadSpeciality()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT name FROM doctorappointmentwebapp.specialties";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlSpeciality.Items.Clear();
                        ddlSpeciality.Items.Add(new ListItem("Select a medical specialty", ""));
                        while (reader.Read())
                        {
                            ddlSpeciality.Items.Add(new ListItem(reader["name"].ToString()));
                        }
                    }
                }
            }
        }

        private bool IsValidAmka(string amka)
        {
            return amka.Length == 11 && amka.All(char.IsDigit);
        }

        private bool IsValidPhone(string phone)
        {
            return phone.Length == 10 && phone.All(char.IsDigit) && (phone.StartsWith("2") || phone.StartsWith("6"));
        }

        private bool IsValidEmail(string email)
        {
            // Regular expression for basic email format validation
            string pattern = @"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
            return Regex.IsMatch(email, pattern);
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Clear any previous messages
            lblMessage.Text = "";
            lblMessage.CssClass = "";

            string amka = txtAmka.Text.Trim();
            string password = txtPassword.Text.Trim();
            string fullName = txtFullName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();
            string region = ddlRegion.SelectedValue.Trim();
            string address = txtAddress.Text.Trim();
            string speciality = ddlSpeciality.SelectedValue.Trim();

            if (!IsValidAmka(amka))
            {
                lblMessage.Text = "Please enter a valid AMKA number.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (!IsValidPhone(phone))
            {
                lblMessage.Text = "Please enter a valid phone number.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (!IsValidEmail(email)) // Check for valid email
            {
                lblMessage.Text = "Please enter a valid email address.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (string.IsNullOrWhiteSpace(address) || address.Length < 5)
            {
                lblMessage.Text = "Please enter a valid address.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                lblMessage.Text = "Password cannot be empty.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (string.IsNullOrWhiteSpace(email))
            {
                lblMessage.Text = "email cannot be empty.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (string.IsNullOrWhiteSpace(region))
            {
                lblMessage.Text = "Region cannot be empty.";
                lblMessage.CssClass = "error-message";
                return;
            }

            if (string.IsNullOrWhiteSpace(speciality))
            {
                lblMessage.Text = "Medical speciality cannot be empty.";
                lblMessage.CssClass = "error-message";
                return;
            }


            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                // Check if the AMKA already exists
                string checkUserQuery = "SELECT COUNT(*) FROM User WHERE amka = @amka";
                using (MySqlCommand cmd = new MySqlCommand(checkUserQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@amka", amka);

                    int userCount = Convert.ToInt32(cmd.ExecuteScalar());

                    if (userCount > 0)
                    {
                        lblMessage.Text = "This AMKA is already registered. Please use a different AMKA.";
                        lblMessage.CssClass = "error-message";
                        return;
                    }
                }

                // Insert new doctor
                string insertQuery = "INSERT INTO User (amka, Password, type, full_name, phone,email, Region, address, speciality) VALUES (@amka, @Password, 'Doctor', @fullName, @phone, @Email, @region, @address, @speciality)";
                using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@amka", amka);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.Parameters.AddWithValue("@fullName", fullName);
                    cmd.Parameters.AddWithValue("@phone", phone);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@region", region);
                    cmd.Parameters.AddWithValue("@address", address);
                    cmd.Parameters.AddWithValue("@speciality", speciality);

                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "You have registered successfully!";
                    lblMessage.CssClass = "success-message";

                    // Clear the form fields
                    txtAmka.Text = "";
                    txtPassword.Text = "";
                    txtFullName.Text = "";
                    txtPhone.Text = "";
                    ddlRegion.SelectedIndex = 0;
                    txtAddress.Text = "";
                    ddlSpeciality.SelectedIndex = 0;
                }
            }
        }
    }
}
