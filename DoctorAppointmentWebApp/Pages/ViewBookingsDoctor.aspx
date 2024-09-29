<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewBookingsDoctor.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.ViewBookingsDoctor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Bookings</title>
    <style>
        /* Reset default margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #e6f7ff;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding-top: 80px; /* Space for fixed header */
            padding-bottom: 80px; /* Space for fixed footer */
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
            border: 1px solid transparent;
            border-radius: 30px;
            cursor: pointer;
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
            box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.15);
            width: 100vw;
            position: fixed;
            bottom: 0;
            left: 0;
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }

        .container {
            max-width: 1200px;
            width: 100%;
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            padding: 20px;
            border: 1px solid #ddd;
            margin: auto;
        }

        h1 {
            text-align: center;
            margin-bottom: 40px;
            color: #007bff;
            font-size: 32px;
            font-weight: bold;
            letter-spacing: 1.5px;
        }

        .section-title {
            font-size: 22px;
            margin-bottom: 15px;
            font-weight: bold;
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
        }

        .grid-container {
            margin-bottom: 30px;
        }

        .appointment-grid {
            border-collapse: collapse;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .appointment-grid th, .appointment-grid td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        .appointment-grid th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        .appointment-grid tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .appointment-grid tr:hover {
            background-color: #e0f7fa;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px 0;
            font-size: 16px;
            color: white;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        /* Modern dropdown styles */
        .modern-dropdown {
            padding: 10px;
            width: 200px;
            font-size: 16px;
            border: 2px solid #007bff;
            border-radius: 8px;
            background-color: #f9f9f9;
            color: #333;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            background-image: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 5"%3E%3Cpolygon fill="%23007bff" points="0,0 10,0 5,5"%3E%3C/polygon%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: right 10px top 50%;
            background-size: 10px 5px;
        }

        .modern-dropdown:focus {
            outline: none;
            border-color: #0056b3;
        }

        .grid-hidden {
            display: none;
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
                <a href="Main.aspx">Home</a>
                <a href="javascript:history.back()">Back</a>
            </div>
        </div>

        <!-- Main content container -->
        <div class="container">
            <h1>View Appointments</h1>

            <!-- Appointments This Week -->
            <div class="grid-container">
                <div class="section-title">Appointments This Week</div>
                <asp:GridView ID="WeeklyAppointmentsGridView" runat="server" CssClass="appointment-grid" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Doctor" HeaderText="Doctor" />
                        <asp:BoundField DataField="amka" HeaderText="Amka" />
                        <asp:BoundField DataField="Appoitment_Date" HeaderText="Appointment Date" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="false" />
                        <asp:BoundField DataField="Appoitment_Time" HeaderText="Appointment Time" />
                        <asp:BoundField DataField="book_notes" HeaderText="Notes" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Appointments By Month -->
            <div class="grid-container">
                <div class="section-title">Appointments By Month</div>
                <!-- Modern Dropdown for selecting the month -->
                <asp:DropDownList ID="MonthDropdown" runat="server" CssClass="modern-dropdown" AutoPostBack="True" OnSelectedIndexChanged="MonthDropdown_SelectedIndexChanged">
                    <asp:ListItem Value="" Text="Select Month" />
                    <asp:ListItem Value="1" Text="January" />
                    <asp:ListItem Value="2" Text="February" />
                    <asp:ListItem Value="3" Text="March" />
                    <asp:ListItem Value="4" Text="April" />
                    <asp:ListItem Value="5" Text="May" />
                    <asp:ListItem Value="6" Text="June" />
                    <asp:ListItem Value="7" Text="July" />
                    <asp:ListItem Value="8" Text="August" />
                    <asp:ListItem Value="9" Text="September" />
                    <asp:ListItem Value="10" Text="October" />
                    <asp:ListItem Value="11" Text="November" />
                    <asp:ListItem Value="12" Text="December" />
                </asp:DropDownList>

                <!-- Grid to display appointments for the selected month, hidden initially -->
                <asp:GridView ID="MonthlyAppointmentsGridView" runat="server" CssClass="appointment-grid" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Doctor" HeaderText="Doctor" />
                        <asp:BoundField DataField="amka" HeaderText="Amka" />
                        <asp:BoundField DataField="Appoitment_Date" HeaderText="Appointment Date" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="false" />
                        <asp:BoundField DataField="Appoitment_Time" HeaderText="Appointment Time" />
                        <asp:BoundField DataField="book_notes" HeaderText="Notes" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Footer Section -->
        <div class="footer">
            <p>&copy; 2024 Doctor Appointment System. All rights reserved.</p>
        </div>
    </form>
</body>
</html>
