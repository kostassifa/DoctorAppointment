<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchDoctor.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.SearchDoctor" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search Doctor</title>
    <style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    background-color: #f0f8ff;
    color: #333;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    padding-top: 80px; /* For header */
    padding-bottom: 80px; /* For footer */
}

.header {
    background: linear-gradient(90deg, #007bff, #00c6ff);
    color: #fff;
    padding: 15px 30px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    width: 100vw;
    position: fixed;
    top: 0;
    left: 0;
    z-index: 100;
}

.header img {
    height: 60px;
    border-radius: 50%;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.header h1 {
    margin: 0;
    font-size: 26px;
    flex-grow: 1;
    text-align: center;
    color: #fff;
    font-weight: 600;
    letter-spacing: 1px;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
}

.header .buttons {
    display: flex;
    align-items: center;
    gap: 15px;
}

.header .buttons a {
    padding: 10px 20px;
    font-size: 17px;
    color: #fff;
    background-color: rgba(255, 255, 255, 0.2);
    border-radius: 30px;
    text-decoration: none;
    transition: all 0.3s ease;
}

.header .buttons a:hover {
    background-color: rgba(255, 255, 255, 0.4);
    transform: scale(1.05);
}

.footer {
    background: linear-gradient(90deg, #007bff, #00c6ff);
    color: #fff;
    padding: 20px 0;
    text-align: center;
    width: 100vw;
    position: fixed;
    bottom: 0;
    left: 0;
}

.footer p {
    margin: 0;
    font-size: 14px;
}

.search-container {
    padding: 30px;
    width: 145%;
    max-width: 600px;
    background-color: white;
    border-radius: 20px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-height: calc(100vh - 160px); /* Ensure it fits between the header and footer */
    overflow-y: auto; /* Allow internal scrolling */
}

.search-container h1 {
    color: #007bff;
    font-size: 28px;
    margin-bottom: 20px;
}

.search-container label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #007bff;
    text-align: left;
}

     .btn-search {
        background: linear-gradient(135deg, #007bff, #00d4ff);
        color: white;
        cursor: pointer;
        padding: 12px 20px;
        font-size: 18px;
        font-weight: bold;
        border: none;
        border-radius: 50px;
        width: 100%;
        transition: all 0.3s ease;
        box-shadow: 0 8px 15px rgba(0, 123, 255, 0.3);
        margin-top: 15px;
    }

    .btn-search:hover {
        background: linear-gradient(135deg, #0056b3, #00aaff);
        box-shadow: 0 12px 20px rgba(0, 123, 255, 0.5);
        transform: translateY(-3px);
    }

.search-container select {
    width: 100%;
    padding: 12px 15px;
    margin: 10px 0;
    border: 1px solid #007bff;
    border-radius: 10px;
    background-color: #f0f8ff;
    font-size: 16px;
    color: #007bff;
    transition: all 0.3s ease;
}

.search-container select:hover, 
.search-container select:focus {
    border-color: #0056b3;
    box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
}

.search-container button {
    background: linear-gradient(135deg, #007bff, #00d4ff);
    color: white;
    cursor: pointer;
    padding: 12px 20px;
    font-size: 18px;
    font-weight: bold;
    border: none;
    border-radius: 50px;
    width: 100%;
    transition: all 0.3s ease;
    box-shadow: 0 8px 15px rgba(0, 123, 255, 0.3);
    margin-top: 15px;
}

.search-container button:hover {
    background: linear-gradient(135deg, #0056b3, #00aaff);
    box-shadow: 0 12px 20px rgba(0, 123, 255, 0.5);
    transform: translateY(-3px);
}

.doctor-list {
    margin-top: 30px;
}

.doctor-item {
    background-color: #e7f3ff;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 15px;
    box-shadow: 0 4px 8px rgba(0, 123, 255, 0.1);
}

.doctor-item h3 {
    color: #007bff;
    margin-bottom: 5px;
}

.doctor-item p {
    color: #333;
    font-size: 14px;
    margin: 0;
}

#map {
    height: 300px;
    width: 100%;
    margin-top: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 123, 255, 0.1);
}
    </style>

    <!-- Include Leaflet CSS and JavaScript -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.Default.css" />
    <script src="https://unpkg.com/leaflet.markercluster/dist/leaflet.markercluster.js"></script>

    <script>
        function initMap() {
            var map = L.map('map').setView([35.34, 25.14], 12);

            var personIcon = L.icon({
                iconUrl: 'Images/user_on_map.png',
                iconSize: [38, 38],
                iconAnchor: [22, 38],
                popupAnchor: [-3, -76]
            });

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 18,
                attribution: '© OpenStreetMap'
            }).addTo(map);

            // Get doctors data from the HiddenField
            var doctorsData = document.getElementById('<%= hfDoctors.ClientID %>').value;
            var doctors = JSON.parse(doctorsData);

            // Initialize the marker cluster group
            var markers = L.markerClusterGroup();

            doctors.forEach(function (doctor) {
                if (doctor.lat && doctor.lng) {
                    var marker = L.marker([doctor.lat, doctor.lng], { icon: personIcon })
                        .bindPopup(`Doctor: ${doctor.full_name}<br>Specialty: ${doctor.speciality}`);
                    markers.addLayer(marker);
                } else {
                    console.error('Invalid location for doctor:', doctor.full_name);
                }
            });

            map.addLayer(markers);

            if (doctors.length > 0) {
                map.fitBounds(markers.getBounds());
            }
        }

        window.onload = initMap;
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header Section -->
        <div class="header">
            <img src="Images/Flag_of_the_Red_Cross.png" alt="Red Cross Flag" />
            <h1>I Need Doctor</h1>
            <div class="buttons">
                <a href="Main.aspx">Home</a>
                <a href="javascript:history.back()">Back</a>
            </div>
        </div>

        <div class="search-container">
            <h1>Search Doctor</h1>

            <asp:Label runat="server" Text="Speciality" AssociatedControlID="ddlSpeciality"></asp:Label>
            <asp:DropDownList ID="ddlSpeciality" runat="server" AutoPostBack="true">
                <asp:ListItem Text="All" Value="All"></asp:ListItem>
            </asp:DropDownList>

            <asp:Label runat="server" Text="Region" AssociatedControlID="ddlRegion"></asp:Label>
            <asp:DropDownList ID="ddlRegion" runat="server" AutoPostBack="true">
                <asp:ListItem Text="All" Value="All"></asp:ListItem>
            </asp:DropDownList>

            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />

            <div class="doctor-list">
                <asp:Repeater ID="rptDoctors" runat="server">
                    <ItemTemplate>
                        <div class="doctor-item">
                            <strong><%# Eval("full_name") %></strong><br />
                            Speciality: <%# Eval("speciality") %> <br />
                            Region: <%# Eval("region") %> <br />
                            Phone: <%# Eval("phone") %> <br />
                            Address: <%# Eval("address") %><br />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <!-- Leaflet Map -->
            <div id="map"></div>
            <!-- HiddenField to hold the JSON data -->
            <asp:HiddenField ID="hfDoctors" runat="server" />
        </div>

        <!-- Footer Section -->
        <div class="footer">
            <p>&copy; 2024 Doctor Appointment System. All rights reserved.</p>
        </div>
    </form>
</body>
</html>
