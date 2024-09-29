<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewBookingsDoctor.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.ViewBookingsDoctor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Bookings</title>
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #e6f7ff;
        color: #333;
        padding: 20px;
        margin: 0;
    }
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 12px;
        border: 1px solid #ddd;
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
        <div class="container">
            <h1>View Appointments</h1>
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
                 <br/>
                <br/>
                <br/>
          <asp:HyperLink ID="lnkReturnHomepage" runat="server" CssClass="return-homepage" NavigateUrl="~/Pages/Main.aspx">Return to Homepage</asp:HyperLink> 
        </div>
    </form>
</body>
</html>
