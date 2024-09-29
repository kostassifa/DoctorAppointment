using System;
using System.Configuration;
using System.Data;
using System.Net.Mail;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class CancelBookingDoctor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                // User is logged in, get the username
                String username = Session["Username"].ToString();

                if (!IsPostBack)
                {
                    BindAppointmentGrid(username);
                }
            }
            else
            {
                // Redirect to login if session is null
                Response.Redirect("~/Pages/Login.aspx");
            }
        }


        private void SendEmail(string toEmail, string subject, string body)
        {

            MailMessage mail = new MailMessage();
            SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
            smtpServer.Port = 587;
            smtpServer.Credentials = new NetworkCredential("doctorappointment102@gmail.com", "hwyjzngbthhtbxgz");
            smtpServer.EnableSsl = true;

            mail.From = new MailAddress("doctorappointment102@gmail.com");
            mail.To.Add(toEmail);
            mail.Subject = subject;
            mail.Body = body;

            smtpServer.Send(mail);

        }

        private void BindAppointmentGrid(string username)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = @"
                    SELECT da.amka,
                           da.doctor,
                           DATE_FORMAT(da.Appoitment_Date, '%Y-%m-%d') AS Appoitment_Date,
                           DATE_FORMAT(da.Appoitment_Time, '%H:%i:%s') AS Appoitment_Time,
                           da.book_notes
                    FROM doctorappointmentwebapp.appoitment da
                    JOIN doctorappointmentwebapp.user du ON da.doctor = du.full_name
                    WHERE du.amka = @username";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@username", username);

                    using (MySqlDataAdapter sda = new MySqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            // If appointments are found, bind to GridView and show the grid
                            AppointmentGridView.DataSource = dt;
                            AppointmentGridView.DataBind();
                            AppointmentGridView.Visible = true;
                            NoAppointmentsLabel.Visible = false;
                            CancelButton.Visible = true;
                        }
                        else
                        {
                            // If no appointments, show the label and hide the grid
                            AppointmentGridView.Visible = false;
                            NoAppointmentsLabel.Visible = true;
                            CancelButton.Visible = false;
                        }
                    }
                }
            }
        }


        private string GetDoctorEmail(string username)
        {
            string email = "";
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT email FROM user WHERE amka = @Amka"; 

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Amka", username);
                    con.Open();
                    email = Convert.ToString(cmd.ExecuteScalar());
                }
            }

            return email;
        }

        private string GetUserEmail(string useramka)
        {
            string email = "";
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT email FROM user WHERE amka =@useramka"; // Assuming the email is stored in the 'user' table

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@useramka", useramka);
                    con.Open();
                    email = Convert.ToString(cmd.ExecuteScalar());
                }
            }

            return email;
        }


        protected void CancelButton_Click(object sender, EventArgs e)
        {
            if (Session["Username"] != null)
            {
                // Get the username from the session
                string username = Session["Username"].ToString();

                foreach (GridViewRow row in AppointmentGridView.Rows)
                {
                    CheckBox cb = (CheckBox)row.FindControl("SelectCheckBox");
                    if (cb != null && cb.Checked)
                    {
                        // Adjust the indices based on your GridView
                        string amka = row.Cells[1].Text.Trim();
                        string doctor = row.Cells[2].Text.Trim();
                        string appointmentDate = row.Cells[3].Text.Trim();
                        string appointmentTime = row.Cells[4].Text.Trim();

                        // Debugging outputs
                        System.Diagnostics.Debug.WriteLine("amka: " + amka);
                        System.Diagnostics.Debug.WriteLine("doctor: " + doctor);
                        System.Diagnostics.Debug.WriteLine("appointmentDate: " + appointmentDate);
                        System.Diagnostics.Debug.WriteLine("appointmentTime: " + appointmentTime);

                        CancelAppointment(amka, appointmentDate, appointmentTime, doctor);
                    }
                }

                // Rebind the grid after cancellation with the username
                BindAppointmentGrid(username);
            }
            else
            {
                // Handle the case where the session has expired or user is not logged in
                Response.Redirect("~/Pages/Login.aspx");
            }
        }

        private void CancelAppointment(string amka, string appointmentDate, string appointmentTime, string doctor)
        {
            System.Diagnostics.Debug.WriteLine("In CancelAppointment:");
            System.Diagnostics.Debug.WriteLine("amka: " + amka);
            System.Diagnostics.Debug.WriteLine("doctor: " + doctor);
            System.Diagnostics.Debug.WriteLine("appointmentDate: " + appointmentDate);
            System.Diagnostics.Debug.WriteLine("appointmentTime: " + appointmentTime);

            DateTime parsedDate;
            if (!DateTime.TryParseExact(appointmentDate, "yyyy-MM-dd", null, System.Globalization.DateTimeStyles.None, out parsedDate))
            {
                System.Diagnostics.Debug.WriteLine("Failed to parse appointmentDate: " + appointmentDate);
                return; // Or handle error appropriately
            }
            string formattedDate = parsedDate.ToString("yyyy-MM-dd");

            DateTime parsedTime;
            if (!DateTime.TryParseExact(appointmentTime, "HH:mm:ss", null, System.Globalization.DateTimeStyles.None, out parsedTime))
            {
                System.Diagnostics.Debug.WriteLine("Failed to parse appointmentTime: " + appointmentTime);
                return; // Or handle error appropriately
            }
            string formattedTime = parsedTime.ToString("HH:mm:ss");

            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = @"DELETE FROM doctorappointmentwebapp.appoitment 
                                 WHERE amka=@amka AND doctor=@doctor AND Appoitment_Date=@appointmentDate AND Appoitment_Time=@appointmentTime";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@amka", amka);
                    cmd.Parameters.AddWithValue("@doctor", doctor);
                    cmd.Parameters.AddWithValue("@appointmentDate", formattedDate);  // Use formatted date
                    cmd.Parameters.AddWithValue("@appointmentTime", formattedTime);  // Use formatted time

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            string patientEmail = GetUserEmail(Session["Username"].ToString()); // Assuming the user's email is based on the session
            string doctorEmail = GetDoctorEmail(amka); // Assuming you can retrieve the doctor's email by name

            // Email body for patient
            string patientEmailBody = $"Dear {amka}, \n\nYour appointment with Dr. {doctor} on {appointmentDate} at {appointmentTime} has been canceled from the Doctor.\n\n" +
                                      "Thank you for using our service.";

            // Email body for doctor
            string doctorEmailBody = $"Dear Dr. {doctor}, \n\nThe appointment with  {amka}  on {appointmentDate} at {appointmentTime} has been canceled by you.\n\n" +
                                     "Thank you for using our service.";

            // Send email to patient
            SendEmail(patientEmail, "Appointment Cancellation", patientEmailBody);

            // Send email to doctor
            SendEmail(doctorEmail, "Appointment Cancellation Notification", doctorEmailBody);
        }
    }
}
