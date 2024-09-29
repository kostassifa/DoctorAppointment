using System;
using System.Data;
using System.Configuration;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Net.Mail;
using System.Net;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class CancelBooking : System.Web.UI.Page
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
                // Redirect to login page or show error
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
                string query = "SELECT category, Doctor, DATE(Appoitment_Date) AS Appoitment_Date, Appoitment_Time, book_notes FROM doctorappointmentwebapp.appoitment WHERE amka=@username";
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
                        // Retrieve the appointment details
                        string category = row.Cells[1].Text;
                        string doctor = row.Cells[2].Text;
                        string appointmentDate = row.Cells[3].Text;
                        string appointmentTime = row.Cells[4].Text;

                        CancelAppointment(category, doctor, appointmentDate, appointmentTime);
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

        private void CancelAppointment(string category, string doctor, string appointmentDate, string appointmentTime)
        {
            DateTime parsedDate = DateTime.Parse(appointmentDate);
            string formattedDate = parsedDate.ToString("yyyy-MM-dd");

            DateTime parsedTime = DateTime.Parse(appointmentTime);
            string formattedTime = parsedTime.ToString("HH:mm:ss");

            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = "DELETE FROM doctorappointmentwebapp.appoitment WHERE category=@category AND Doctor=@doctor AND Appoitment_Date=@appointmentDate AND Appoitment_Time=@appointmentTime";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@category", category);
                    cmd.Parameters.AddWithValue("@doctor", doctor);
                    cmd.Parameters.AddWithValue("@appointmentDate", formattedDate);  // Use formatted date
                    cmd.Parameters.AddWithValue("@appointmentTime", formattedTime);  // Use formatted time

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            // Send cancellation emails to both the patient and the doctor
            string patientEmail = GetUserEmail(Session["Username"].ToString()); // Assuming the user's email is based on the session
            string doctorEmail = GetDoctorEmail(doctor); // Assuming you can retrieve the doctor's email by name

            // Email body for patient
            string patientEmailBody = $"Dear {Session["Username"].ToString()}, \n\nYour appointment with Dr. {doctor} on {appointmentDate} at {appointmentTime} has been canceled.\n\n" +
                                      "Thank you for using our service.";

            // Email body for doctor
            string doctorEmailBody = $"Dear Dr. {doctor}, \n\nThe appointment with  {Session["Username"].ToString()}  on {appointmentDate} at {appointmentTime} has been canceled.\n\n" +
                                     "Thank you for using our service.";

            // Send email to patient
            SendEmail(patientEmail, "Appointment Cancellation", patientEmailBody);

            // Send email to doctor
            SendEmail(doctorEmail, "Appointment Cancellation Notification", doctorEmailBody);
        }

        private string GetUserEmail(string username)
        {
            string email = "";
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT email FROM user WHERE amka = @Amka"; // Assuming the email is stored in the 'user' table

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Amka", username);
                    con.Open();
                    email = Convert.ToString(cmd.ExecuteScalar());
                }
            }

            return email;
        }

        private string GetDoctorEmail(string doctorName)
        {
            string email = "";
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT email FROM user WHERE full_name = @DoctorName AND type = 'Doctor'"; // Assuming the email is stored in the 'user' table

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@DoctorName", doctorName);
                    con.Open();
                    email = Convert.ToString(cmd.ExecuteScalar());
                }
            }

            return email;
        }


    }
}