<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyDetails.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.MyDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f6f9;
            color: #333;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #444;
            font-size: 28px;
            letter-spacing: 1px;
        }

        .profile-container {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 30px;
        }

        .profile-container img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            object-fit: cover;
            border: 4px solid #5dade2;
        }

        .details-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
        }

        .detail {
            width: 48%;
        }

        .detail label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
            color: #5dade2;
        }

        .detail .info input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .detail .info {
            margin-bottom: 15px;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            font-size: 14px;
            color: #777;
        }

        .update-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #5dade2;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
            margin-top: 20px;
        }

        .update-button:hover {
            background-color: #3498db;
        }

        .message {
            text-align: center;
            font-size: 16px;
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .message.success {
            color: green;
        }

        .message.error {
            color: red;
        }

        .return-homepage {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #007BFF;
            text-decoration: none;
            font-weight: 600;
        }

        .return-homepage:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>My Details</h1>

            <!-- Message Label -->
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            <div class="profile-container">
                <img src="Images/user.jpg" alt="Profile Picture" id="ProfileImage" runat="server" />
            </div>

            <div class="details-container">
                <div class="detail">
                    <label for="amka">AMKA</label>
                    <div class="info" id="amka" runat="server"></div>
                </div>
                <div class="detail">
                    <label for="full_name">Full Name</label>
                    <div class="info" id="full_name" runat="server"></div>
                </div>
                <div class="detail">
                    <label for="specialty">Specialty</label>
                    <div class="info" id="specialty" runat="server"></div>
                </div>
                <div class="detail">
                    <label for="phone">Phone</label>
                    <div class="info">
                        <asp:TextBox ID="phone" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="detail">
                    <label for="address">Address</label>
                    <div class="info">
                        <asp:TextBox ID="address" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="detail">
                    <label for="email">Email</label>
                    <div class="info">
                        <asp:TextBox ID="email" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="detail">
                    <label for="type">Type</label>
                    <div class="info" id="type" runat="server"></div>
                </div>
                <div class="detail">
                    <label for="region">Region</label>
                    <div class="info" id="region" runat="server"></div>
                </div>
                <div class="detail">
                    <label for="active_dates">Active Appointments</label>
                    <div class="info" id="active_dates" runat="server"></div>
                </div>
            </div>

            <!-- Update Button -->
            <asp:Button ID="btnUpdate" CssClass="update-button" Text="Update" runat="server" OnClick="btnUpdate_Click" />

            <asp:HyperLink ID="lnkReturnHomepage" runat="server" CssClass="return-homepage" NavigateUrl="~/Pages/Main.aspx">Return to Homepage</asp:HyperLink>

            <div class="footer">
                © 2024 Doctor Appointment Web App
            </div>
        </div>
    </form>
</body>
</html>
