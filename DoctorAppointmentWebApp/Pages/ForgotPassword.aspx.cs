using System;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.Web.UI;
using MySql.Data.MySqlClient;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            litMessage.Text = string.Empty;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string amkatxt = txtAmka.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                litMessage.Text = "<p class='error-message'>Please enter your email address.</p>";
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                string query = "SELECT amka FROM user WHERE Email = @Email and Amka=@Amka";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Amka", amkatxt);

                    try
                    {
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            // Email exists, generate a reset token
                            string amka = result.ToString();
                            string resetToken = Guid.NewGuid().ToString();
                            DateTime tokenExpiry = DateTime.Now.AddHours(1); // Token valid for 1 hour

                            // Store the token and expiry in the database
                            string updateQuery = "UPDATE user SET ResetPasswordToken = @ResetToken, ResetTokenExpiry = @TokenExpiry WHERE amka = @Amka";
                            using (MySqlCommand updateCmd = new MySqlCommand(updateQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("@ResetToken", resetToken);
                                updateCmd.Parameters.AddWithValue("@TokenExpiry", tokenExpiry);
                                updateCmd.Parameters.AddWithValue("@Amka", amka);

                                int rowsAffected = updateCmd.ExecuteNonQuery();
                                if (rowsAffected > 0)
                                {
                                    // Send email with reset link
                                    string resetLink = $"{Request.Url.GetLeftPart(UriPartial.Authority)}/Pages/ResetPassword.aspx?token={resetToken}";
                                    string subject = "Password Reset Request";
                                    string body = $"Please click the following link to reset your password:\n{resetLink}\n\nThis link will expire in 1 hour.";

                                    SendEmail(email, subject, body);

                                    litMessage.Text = "<span style='color:green<p class='success-message'>An email has been sent to your email address with instructions to reset your password.</p></span>";
                                }
                                else
                                {
                                    litMessage.Text = "<p class='error-message'>An error occurred while generating the reset token. Please try again later.</p>";
                                }
                            }
                        }
                        else
                        {
                            // Email does not exist
                            litMessage.Text = "<p class='error-message'>The email address you entered is not registered.</p>";
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

        private void SendEmail(string toEmail, string subject, string body)
        {
            try
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
            catch (Exception)
            {
                // Handle exceptions
                litMessage.Text = "<p class='error-message'>An error occurred while sending the email. Please try again later.</p>";
            }
        }
    }
}
