<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Appointment Registration</title>
    <!-- Include the font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
<style>
   /* General Styles */
        html, body {
            height: 100%;
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

        /* Header Styles */
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

        /* Footer Styles */
        .footer {
               background: linear-gradient(90deg, #007bff, #00c6ff);
                color: #fff;
                padding: 20px 0;
                text-align: center;
                box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.15);
                width: 100%;
                margin-top: 143px;
		}

        .footer p {
            margin: 0;
            font-size: 14px;
        }

        /* Container Styles */
        .container {
            max-width: 500px;
            margin: 20px auto;
            padding: 30px;
            background: white;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            position: relative;
            width: 100%;
            flex-grow: 1;
        }

        .container h2 {
            text-align: center;
            font-size: 28px;
            color: #007BFF;
            margin-bottom: 20px;
            font-weight: 600;
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1rem;
            color: #33D;
        }

        input[type="text"], input[type="password"], select, .dropdown-region {
           width: 101%;
            padding: 17px 0px;
            margin-top: 5px;
            border: 1px solid #0000FF;
            border-radius: 8px;
            font-size: 1rem;
            background-color: #f9f9f9;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            color: #555;
        }

        input[type="text"]:focus, input[type="password"]:focus, select:focus, .dropdown-region:focus {
            border-color: #007BFF;
            box-shadow: 0px 4px 15px rgba(0, 123, 255, 0.2);
            outline: none;
            background-color: #fff;
        }

        .register-button {
            width: 100%;
            padding: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            background: linear-gradient(90deg, #007BFF 0%, #00C6FF 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0px 5px 20px rgba(0, 123, 255, 0.3);
            transition: all 0.3s ease;
        }

        .register-button:hover {
            background: linear-gradient(90deg, #0056b3 0%, #0096c7 100%);
            box-shadow: 0px 8px 25px rgba(0, 123, 255, 0.5);
        }

        /* Message Label Styles */
        .message-label {
            display: block;
            margin-bottom: 20px;
            font-size: 1rem;
            text-align: center;
        }

        .error-message {
            color: red;
            font-weight: 600;
        }

        .success-message {
            color: green;
            font-weight: 600;
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
    /* Responsive Styles */
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
            width: 90%;
        }

        .register-button {
            font-size: 1rem;
            padding: 12px;
        }
    }

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
            padding: 15px;
            width: 95%;
            border-radius: 12px;
        }

        .register-button {
            font-size: 0.95rem;
            padding: 12px;
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
                <a href="Main.aspx">Home</a>
                <a href="javascript:history.back()">Back</a>
            </div>
        </div>

        <!-- Main Content Section -->
        <div class="container">
            <h2>Patient Register Form</h2>

            <!-- Message Label -->
            <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>

            <div class="form-group">
                <label for="txtAmka">AMKA</label>
                <asp:TextBox ID="txtAmka" runat="server" placeholder="Enter your AMKA"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtFullName">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter your full name"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtPhone">Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" placeholder="Enter your phone number"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtEmail">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="Enter your email"></asp:TextBox>
            </div>

             <div class="form-group">
                <label for="ddlRegion">Region</label>
                <asp:DropDownList ID="ddlRegion" runat="server" CssClass="dropdown-region"></asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="txtAddress">Address</label>
                <asp:TextBox ID="txtAddress" runat="server" placeholder="Enter your address"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="register-button" />
            </div>

        </div>

        <!-- Footer Section -->
        <div class="footer">
            &copy; 2024 Doctor Appointment System. All rights reserved.
        </div>
    </form>
</body>
</html>
