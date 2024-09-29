using MySql.Data.MySqlClient;
using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class ViewBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                string username = Session["Username"].ToString();
                if (!IsPostBack)
                {
                    LoadWeeklyAppointments(username);    
                }
            }
            else
            {
                // Redirect to login page if session has expired or user is not logged in
                Response.Redirect("~/Pages/Login.aspx");
            }
        }

        private void LoadWeeklyAppointments(string username)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = @"
                      SELECT category, Doctor, DATE(Appoitment_Date) AS Appoitment_Date, Appoitment_Time, book_notes
                    FROM doctorappointmentwebapp.appoitment
                    WHERE amka=@username AND WEEK(Appoitment_Date) = WEEK(CURDATE()) AND YEAR(Appoitment_Date) = YEAR(CURDATE())";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        WeeklyAppointmentsGridView.DataSource = dt;
                        WeeklyAppointmentsGridView.DataBind();
                    }
                }
            }
        }

        private void LoadMonthlyAppointments(string username, int month)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = @"
                    SELECT category, Doctor, DATE(Appoitment_Date) AS Appoitment_Date, Appoitment_Time, book_notes
                    FROM doctorappointmentwebapp.appoitment
                    WHERE amka=@username AND MONTH(Appoitment_Date) = @month AND YEAR(Appoitment_Date) = YEAR(CURDATE())
                    ORDER BY Appoitment_Date DESC";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@month", month);
                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        MonthlyAppointmentsGridView.DataSource = dt;
                        MonthlyAppointmentsGridView.DataBind();
                    }
                }
            }
        }

        protected void MonthDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            string username = Session["Username"].ToString();
            int selectedMonth;

            if (int.TryParse(MonthDropdown.SelectedValue, out selectedMonth) && selectedMonth > 0)
            {
                LoadMonthlyAppointments(username, selectedMonth);
                MonthlyAppointmentsGridView.Visible = true; // Show the grid after a month is selected
            }
            else
            {
                MonthlyAppointmentsGridView.Visible = false; // Hide the grid if no valid month is selected
            }
        }
    }
}
