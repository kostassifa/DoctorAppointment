using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Net.Mail;
using System.Net;
using System.Threading.Tasks;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class BookAppoitment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Set the date picker to type "date"
                datePicker.Attributes["type"] = "date";

                // Initialize controls
                BindRegion();
                ddlRegion.SelectedIndex = 0;
                ddlCategory.SelectedIndex = 0;
                ddlDoctor.SelectedIndex = 0;
                ddlTime.SelectedIndex = 0;

                ddlCategory.Enabled = false;
                ddlDoctor.Enabled = false;
                datePicker.Enabled = false;
                datePicker.Text = "";
                ddlTime.Enabled = false;

                litMessage.Text = "";
                btnSubmit.Enabled = true;
            }
        }

        private void SendEmail(string toEmail, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("doctorappointment102@gmail.com");
                mail.To.Add(toEmail);
                mail.Subject = subject;
                mail.Body = body;

                SmtpClient smtpServer = new SmtpClient("smtp.gmail.com");
                smtpServer.Port = 587;
                smtpServer.Credentials = new NetworkCredential("doctorappointment102@gmail.com", "hwyjzngbthhtbxgz");
                smtpServer.EnableSsl = true;

                smtpServer.Send(mail);
            }
            catch (Exception ex)
            {
                litMessage.Text += $"<br/><span style='color:red;'>Error sending email: {ex.Message}</span>";
            }
        }

        private void BindRegion()
        {
            ClearMessage();
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                using (MySqlCommand cmd = new MySqlCommand("SELECT DISTINCT region FROM user WHERE type='Doctor'", con))
                {
                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    ddlRegion.DataSource = reader;
                    ddlRegion.DataTextField = "region";
                    ddlRegion.DataValueField = "region";
                    ddlRegion.DataBind();
                }
            }
            ddlRegion.Items.Insert(0, new ListItem("--Select Region--", "0"));
        }

        private void BindCategories(string region)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT DISTINCT speciality FROM user WHERE region = @Region and type='Doctor'";
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Region", region);
                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    ddlCategory.DataSource = reader;
                    ddlCategory.DataTextField = "speciality";
                    ddlCategory.DataValueField = "speciality";
                    ddlCategory.DataBind();
                }
            }
            ddlCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));
        }

        private void BindDoctors(string category)
        {
            string selectedRegion = ddlRegion.SelectedValue;
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT DISTINCT full_name FROM user WHERE speciality = @Category AND region = @Region AND type='Doctor'";
                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@Region", selectedRegion);
                    con.Open();
                    MySqlDataReader reader = cmd.ExecuteReader();
                    ddlDoctor.DataSource = reader;
                    ddlDoctor.DataTextField = "full_name";
                    ddlDoctor.DataValueField = "full_name";
                    ddlDoctor.DataBind();
                }
            }
            ddlDoctor.Items.Insert(0, new ListItem("--Select Doctor--", "0"));
        }

        protected void BindTimeSlotsForDoctorAndDate()
        {
            // Clear existing items
            ddlTime.Items.Clear();

            // Get the selected doctor and date
            string selectedDoctor = ddlDoctor.SelectedValue;
            DateTime selectedDate;

            if (DateTime.TryParse(datePicker.Text, out selectedDate))
            {
                // Check if selectedDate is Sunday
                if (selectedDate.DayOfWeek == DayOfWeek.Sunday)
                {
                    // Disable time slots and inform the user
                    ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
                    ddlTime.Enabled = false;
                    litMessage.Text = "<span style='color:red;'>Appointments are not available on Sundays.</span>";
                    return; // Exit the method
                }

                // Existing code to generate time slots
                // Get the booked time slots for this doctor on this date
                List<string> bookedTimeSlots = GetBookedTimeSlots(selectedDoctor, selectedDate);

                // Generate the list of time slots
                TimeSpan startTime = new TimeSpan(9, 0, 0); // 9 AM
                TimeSpan endTime = new TimeSpan(19, 0, 0); // 7 PM
                TimeSpan interval = new TimeSpan(0, 30, 0); // 30 minutes

                DateTime currentDateTime = selectedDate.Date.Add(startTime); // Starting from selected date

                // Determine current date and time
                DateTime now = DateTime.Now;

                // First, add default item
                ddlTime.Items.Add(new ListItem("--Select Time Slot--", "0"));

                while (startTime < endTime)
                {
                    string timeSlotValue = currentDateTime.ToString("HH:mm:ss"); // For value and comparison
                    string timeSlotText = currentDateTime.ToString("hh:mm tt"); // For display

                    bool isTimeSlotInPast = false;

                    // Check if the selected date is today
                    if (selectedDate.Date == now.Date)
                    {
                        // If the time slot is before current time, disable it
                        if (currentDateTime <= now)
                        {
                            isTimeSlotInPast = true;
                        }
                    }
                    else if (selectedDate.Date < now.Date)
                    {
                        // If the selected date is in the past, disable all time slots
                        isTimeSlotInPast = true;
                    }

                    // Create a new ListItem
                    ListItem listItem = new ListItem(timeSlotText, timeSlotValue);

                    // Disable the time slot if it's in the past or already booked
                    if (isTimeSlotInPast || bookedTimeSlots.Contains(timeSlotValue))
                    {
                        listItem.Attributes.Add("disabled", "disabled");
                        listItem.Attributes.Add("style", "color: gray;"); // Optional: style to indicate disabled state
                    }

                    ddlTime.Items.Add(listItem);

                    currentDateTime = currentDateTime.Add(interval);
                    startTime = startTime.Add(interval);
                }
            }
            else
            {
                // Invalid date, clear time slots
                ddlTime.Items.Clear();
                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
            }
        }

        private List<string> GetBookedTimeSlots(string doctor, DateTime date)
        {
            List<string> bookedSlots = new List<string>();

            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT appoitment_time FROM appoitment WHERE doctor = @Doctor AND appoitment_date = @AppointmentDate";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Doctor", doctor);
                    cmd.Parameters.AddWithValue("@AppointmentDate", date.Date);

                    con.Open();
                    using (MySqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            bookedSlots.Add(reader["appoitment_time"].ToString());
                        }
                    }
                }
            }

            return bookedSlots;
        }

        protected void ddlDoctor_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearMessage();
            if (ddlDoctor.SelectedIndex > 0)
            {
                datePicker.Enabled = true;
                datePicker.Text = ""; // Clear any previous value
                ddlTime.Enabled = false;
                ddlTime.Items.Clear();
                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
            }
            else
            {
                datePicker.Enabled = false;
                datePicker.Text = "";
                ddlTime.Enabled = false;
                ddlTime.Items.Clear();
                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
            }
        }

        protected void datePicker_TextChanged(object sender, EventArgs e)
        {
            ClearMessage();
            if (!string.IsNullOrEmpty(datePicker.Text))
            {
                ddlTime.Enabled = true;
                BindTimeSlotsForDoctorAndDate();
            }
            else
            {
                ddlTime.Enabled = false;
                ddlTime.Items.Clear();
                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
            }
        }

        protected void ddlRegion_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearMessage();
            if (ddlRegion.SelectedIndex > 0)
            {
                ddlCategory.Enabled = true;
                BindCategories(ddlRegion.SelectedValue);
            }
            else
            {
                ddlCategory.Enabled = false;
                ddlCategory.Items.Clear();
                ddlCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));

                ddlDoctor.Enabled = false;
                ddlDoctor.Items.Clear();
                ddlDoctor.Items.Insert(0, new ListItem("--Select Doctor--", "0"));

                datePicker.Enabled = false;
                datePicker.Text = "";

                ddlTime.Enabled = false;
                ddlTime.Items.Clear();
                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
            }
        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearMessage();
            if (ddlCategory.SelectedIndex > 0)
            {
                ddlDoctor.Enabled = true;
                BindDoctors(ddlCategory.SelectedValue);
                ddlDoctor.SelectedIndex = 0;

                // Disable datePicker and ddlTime
                datePicker.Enabled = false;
                datePicker.Text = "";
                ddlTime.Enabled = false;
                ddlTime.Items.Clear();
                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
            }
            else
            {
                ddlDoctor.Enabled = false;
                ddlDoctor.Items.Clear();
                ddlDoctor.Items.Insert(0, new ListItem("--Select Doctor--", "0"));

                datePicker.Enabled = false;
                datePicker.Text = "";

                ddlTime.Enabled = false;
                ddlTime.Items.Clear();
                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));
            }
        }

        private bool IsAppointmentExists(string doctor, DateTime date, string time)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM appoitment WHERE doctor = @Doctor AND appoitment_date = @AppointmentDate AND appoitment_time = @AppointmentTime";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Doctor", doctor);
                    cmd.Parameters.AddWithValue("@AppointmentDate", date.Date);
                    cmd.Parameters.AddWithValue("@AppointmentTime", time);

                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    return count > 0;
                }
            }
        }

        private bool IsSameDayAppointmentExists(string username, string doctor, DateTime date)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM appoitment WHERE amka = @Amka AND doctor = @Doctor AND appoitment_date = @AppointmentDate";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Amka", username);
                    cmd.Parameters.AddWithValue("@Doctor", doctor);
                    cmd.Parameters.AddWithValue("@AppointmentDate", date);

                    con.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    return count > 0;
                }
            }
        }

        protected void btnSubmit_OnClick(object sender, EventArgs e)
        {
            ClearMessage();
           // WaitingMessage();

            if (Session["Username"] != null)
            {
                string username = Session["Username"].ToString();
                string selectedRegion = ddlRegion.SelectedValue;
                string selectedCategory = ddlCategory.SelectedValue;
                string selectedDoctor = ddlDoctor.SelectedValue;
                string selectedDate = datePicker.Text;
                string selectedTime = ddlTime.SelectedValue;
                string bookingReason = txtReason.Text.Trim();

                // Validate that all fields are selected
                if (ddlRegion.SelectedIndex == 0 || ddlCategory.SelectedIndex == 0 || ddlDoctor.SelectedIndex == 0 || string.IsNullOrEmpty(selectedDate) || ddlTime.SelectedIndex == 0)
                {
                    litMessage.Text = "<span style='color:red;'>Please make sure all fields are selected.</span>";
                    return;
                }

                DateTime appointmentDate;
                if (!DateTime.TryParse(selectedDate, out appointmentDate))
                {
                    litMessage.Text = "<span style='color:red;'>Invalid date format selected.</span>";
                    return;
                }

                if (string.IsNullOrEmpty(bookingReason))
                {
                    litMessage.Text = "<span style='color:red;'>You need to provide a reason for the appointment.</span>";
                    return;
                }

                // Check if the same user already has an appointment with the same doctor on the same day
                if (IsSameDayAppointmentExists(username, selectedDoctor, appointmentDate))
                {
                    litMessage.Text = "<span style='color:red;'>You already have an appointment with this doctor on the same day. Please select another date.</span>";
                    return;
                }

                // Check if appointment already exists
                if (IsAppointmentExists(selectedDoctor, appointmentDate, selectedTime))
                {
                    litMessage.Text = "<span style='color:red;'>An appointment already exists at the selected date and time with this doctor. Please select another date or time.</span>";
                    return;
                }

                string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

                try
                {
                    // Insert into the database
                    using (MySqlConnection con = new MySqlConnection(connectionString))
                    {
                        string query = "INSERT INTO appoitment (category, doctor, appoitment_date, appoitment_time, book_notes, amka) " +
                                       "VALUES (@Category, @Doctor, @AppointmentDate, @AppointmentTime, @BookingReason, @Amka)";

                        using (MySqlCommand cmd = new MySqlCommand(query, con))
                        {
                            // Add parameters
                            cmd.Parameters.AddWithValue("@Category", selectedCategory);
                            cmd.Parameters.AddWithValue("@Doctor", selectedDoctor);
                            cmd.Parameters.AddWithValue("@AppointmentDate", appointmentDate);
                            cmd.Parameters.AddWithValue("@AppointmentTime", selectedTime);
                            cmd.Parameters.AddWithValue("@BookingReason", bookingReason);
                            cmd.Parameters.AddWithValue("@Amka", username);

                            con.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {

                                // Send email notifications
                                string patientEmail = GetUserEmail(username); // Get patient email by username
                                string doctorEmail = GetDoctorEmail(selectedDoctor); // Get doctor email by doctor's name

                                // Email body for patient
                                string patientEmailBody = $"Dear Patient,\n\nYour appointment has been successfully booked.\n\n" +
                                                          $"Doctor: {selectedDoctor}\n" +
                                                          $"Date: {appointmentDate.ToString("dd/MM/yyyy")}\n" +
                                                          $"Time: {selectedTime}\n\n" +
                                                          "Thank you for using our service.";

                                // Email body for doctor
                                string doctorEmailBody = $"Dear Doctor,\n\nA new appointment has been booked.\n\n" +
                                                         $"Patient: {username}\n" +
                                                         $"Date: {appointmentDate.ToString("dd/MM/yyyy")}\n" +
                                                         $"Time: {selectedTime}\n\n" +
                                                         "Thank you for using our service.";

                                // Send email to patient
                                SendEmail(patientEmail, "Appointment Confirmation", patientEmailBody);

                                // Send email to doctor
                                SendEmail(doctorEmail, "New Appointment Scheduled", doctorEmailBody);

                                litMessage.Text = "<span style='color:green;'>Appointment booked successfully an email was sent to your account!</span>";
                                // Clear the input fields
                                ddlRegion.SelectedIndex = 0;
                                ddlCategory.SelectedIndex = 0;
                                ddlCategory.Enabled = false;
                                ddlCategory.Items.Clear();
                                ddlCategory.Items.Insert(0, new ListItem("--Select Category--", "0"));

                                ddlDoctor.SelectedIndex = 0;
                                ddlDoctor.Enabled = false;
                                ddlDoctor.Items.Clear();
                                ddlDoctor.Items.Insert(0, new ListItem("--Select Doctor--", "0"));

                                datePicker.Text = "";
                                datePicker.Enabled = false;

                                ddlTime.SelectedIndex = 0;
                                ddlTime.Enabled = false;
                                ddlTime.Items.Clear();
                                ddlTime.Items.Insert(0, new ListItem("--Select Time Slot--", "0"));

                                txtReason.Text = "";
                            }
                            else
                            {
                                litMessage.Text = "<span style='color:red;'>Failed to book the appointment. Please try again.</span>";
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    litMessage.Text = $"<span style='color:red;'>An error occurred: {ex.Message}</span>";
                }
            }
            else
            {
                litMessage.Text = "<span style='color:red;'>You need to log in to book an appointment. Please log in and try again.</span>";
            }
        }

        private string GetUserEmail(string username)
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

        private string GetDoctorEmail(string doctorName)
        {
            string email = "";
            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string query = "SELECT email FROM user WHERE full_name = @DoctorName AND type = 'Doctor'";

                using (MySqlCommand cmd = new MySqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@DoctorName", doctorName);
                    con.Open();
                    email = Convert.ToString(cmd.ExecuteScalar());
                }
            }

            return email;
        }

        private void ClearMessage()
        {
            litMessage.Text = "";
        }

        private void WaitingMessage()
        {
            litMessage.Text = "<span style='color:green;'>Wait to finish!</span>";
        }
    }
}
