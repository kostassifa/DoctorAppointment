using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace DoctorAppointmentWebApp.Pages
{
    public partial class SearchDoctor : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["DoctorAppointmentConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSpecialities();
                LoadRegions();
                LoadDoctors();

                // Set the JSON data into the HiddenField control
                hfDoctors.Value = GetDoctorsJson(ddlSpeciality.SelectedValue, ddlRegion.SelectedValue);
            }
        }

        protected void LoadSpecialities()
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT DISTINCT speciality FROM doctorappointmentwebapp.user WHERE type='Doctor'", con);
                MySqlDataReader reader = cmd.ExecuteReader();
                ddlSpeciality.DataSource = reader;
                ddlSpeciality.DataTextField = "speciality";
                ddlSpeciality.DataValueField = "speciality";
                ddlSpeciality.DataBind();
                ddlSpeciality.Items.Insert(0, new ListItem("All", "All"));
            }
        }

        protected void LoadRegions()
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                con.Open();
                MySqlCommand cmd = new MySqlCommand("SELECT DISTINCT region FROM doctorappointmentwebapp.user WHERE type='Doctor'", con);
                MySqlDataReader reader = cmd.ExecuteReader();
                ddlRegion.DataSource = reader;
                ddlRegion.DataTextField = "region";
                ddlRegion.DataValueField = "region";
                ddlRegion.DataBind();
                ddlRegion.Items.Insert(0, new ListItem("All", "All"));
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadDoctors();
            // Update the JSON data into the HiddenField control
            hfDoctors.Value = GetDoctorsJson(ddlSpeciality.SelectedValue, ddlRegion.SelectedValue);
        }

        protected void LoadDoctors()
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT full_name, speciality, region, phone, address FROM doctorappointmentwebapp.user WHERE type='Doctor'";
                if (ddlSpeciality.SelectedValue != "All")
                {
                    query += " AND speciality = @speciality";
                }
                if (ddlRegion.SelectedValue != "All")
                {
                    query += " AND region = @region";
                }

                MySqlCommand cmd = new MySqlCommand(query, con);
                if (ddlSpeciality.SelectedValue != "All")
                {
                    cmd.Parameters.AddWithValue("@speciality", ddlSpeciality.SelectedValue);
                }
                if (ddlRegion.SelectedValue != "All")
                {
                    cmd.Parameters.AddWithValue("@region", ddlRegion.SelectedValue);
                }

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDoctors.DataSource = dt;
                rptDoctors.DataBind();
            }
        }

        public string GetDoctorsJson(string speciality, string region)
        {
            DataTable dt = new DataTable();
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                con.Open();

                string query = @"SELECT du.full_name AS full_name, dr.lat AS lat, dr.lng AS lng, du.speciality 
                 FROM doctorappointmentwebapp.user du
                 INNER JOIN doctorappointmentwebapp.Region dr ON du.region = dr.city
                 WHERE du.type = 'Doctor'";

                if (speciality != "All")
                {
                    query += " AND du.speciality = @speciality";
                }
                if (region != "All")
                {
                    query += " AND du.region = @region";
                }


                MySqlCommand cmd = new MySqlCommand(query, con);
                if (speciality != "All")
                {
                    cmd.Parameters.AddWithValue("@speciality", speciality);
                }
                if (region != "All")
                {
                    cmd.Parameters.AddWithValue("@region", region);
                }

                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }

            var doctorsList = new List<object>();
            foreach (DataRow row in dt.Rows)
            {
                double lat, lng;
                string latStr = row["lat"].ToString().Trim();
                string lngStr = row["lng"].ToString().Trim();

                if (double.TryParse(latStr, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out lat) &&
                    double.TryParse(lngStr, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out lng))
                {
                    doctorsList.Add(new
                    {
                        full_name = row["full_name"].ToString(),
                        lat = lat,
                        lng = lng,
                        speciality = row["speciality"].ToString()
                    });
                }
                else
                {
                    // Log the error or handle it appropriately
                    Console.WriteLine($"Invalid coordinates for doctor: {row["full_name"]}, lat: {latStr}, lng: {lngStr}");
                }
            }

                JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            return jsSerializer.Serialize(doctorsList);
        }
    }
}
