<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Appointment</title>
<style>
html, body {
    height: 100%; /* Ensures body takes full height */
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    font-family: 'Poppins', sans-serif;
    background-color: #f0f4f8;
}

body {
    min-height: 100vh;
}

form {
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.header {
    background: linear-gradient(90deg, #007bff, #00c6ff);
    color: #fff;
    padding: 15px 30px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
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
    border: 1px solid transparent;
    border-radius: 30px;
    cursor: pointer;
    text-decoration: none;
    transition: all 0.3s ease;
    display: inline-block;
}

.header .buttons a:hover {
    background-color: rgba(255, 255, 255, 0.4);
    transform: scale(1.05);
}

.container {
    text-align: center;
    background-color: #fff;
    padding: 400px;
    border-radius: 15px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
    margin: auto;
    flex-grow: 1; /* Fills the remaining space, pushing the footer down */
}

h1 {
    font-size: 28px;
    color: #007bff;
    margin-bottom: 30px;
    font-weight: 600;
}

.button-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
    grid-gap: 20px;
}

.action-button {
    width: 100%;
    padding: 15px;
    font-size: 16px;
    color: #fff;
    background: linear-gradient(90deg, #007bff, #00c6ff);
    border: none;
    border-radius: 50px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
    box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
}

.action-button:hover {
    background: linear-gradient(90deg, #0056b3, #0096c7);
    transform: translateY(-3px);
    box-shadow: 0 6px 20px rgba(0, 123, 255, 0.5);
}

.footer {
    background: linear-gradient(90deg, #007bff, #00c6ff);
    color: #fff;
    padding: 15px 0;
    text-align: center;
    box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.15);
    width: 100%;
    margin-top: auto; /* Ensures the footer is at the bottom */
}

.footer p {
    margin: 0;
    font-size: 14px;
}
/* Smaller screens (tablets, phones) */
@media (max-width: 768px) {
    .header {
        flex-direction: column;
        padding: 10px;
        text-align: center;
    }

    .header h1 {
        font-size: 20px;
    }

    .header img {
        height: 40px;
    }

    .container {
        padding: 20px;
        width: 95%;
    }

    .action-button {
        padding: 10px;
        font-size: 14px;
    }
}

/* Extra small screens (small phones) */
@media (max-width: 480px) {
    .header h1 {
        font-size: 18px;
    }

    .header img {
        height: 35px;
    }

    .header .buttons a {
        font-size: 14px;
        padding: 5px 10px;
    }

    .container {
        padding: 10px;
        border-radius: 10px;
    }

    .action-button {
        font-size: 12px;
        padding: 8px;
    }
}
</style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Header Section -->
        <div class="header">
            <img src="Images/Flag_of_the_Red_Cross.png" alt="Red Cross Flag" />
            <h1>I Need Doctor</h1>
            <div class="buttons">
                <asp:Literal ID="litButtons" runat="server"></asp:Literal>
            </div>
        </div>

        <!-- Main Content Section -->
        <div class="container">
            <h1>Welcome to the Doctor Appointment System</h1>
            <div class="button-grid">
                <asp:Button ID="btnMyDetails" runat="server" Text="My Details" CssClass="action-button" OnClick="btnMyDetails_Click" />
                <asp:Button ID="btnBookAppointment" runat="server" Text="Book Appointment" CssClass="action-button" OnClick="btnBookAppointment_Click" />
                <asp:Button ID="btnViewBookings" runat="server" Text="View Bookings" CssClass="action-button" OnClick="btnViewBookings_Click"/>
                <asp:Button ID="btnCancelBooking" runat="server" Text="Cancel Booking" CssClass="action-button" OnClick="btnCancelBooking_Click" />
                <asp:Button ID="btnSearchDoctor" runat="server" Text="Search Doctor" CssClass="action-button"  OnClick="btnSearchDoctor_Click" />
            </div>
        </div>

        <!-- Footer Section -->
        <div class="footer">
            &copy; 2024 Doctor Appointment System. All rights reserved.
        </div>
    </form>
</body>
</html>
