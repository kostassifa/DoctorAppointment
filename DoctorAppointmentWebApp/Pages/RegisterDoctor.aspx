<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterDoctor.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.RegisterDoctor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor Appointment Registration</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 500px;
            margin: 20px;
            padding: 30px;
            background: white;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            position: relative;
            width: 100%;
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 1rem;
            color: #333;
        }

        input[type="text"], input[type="password"], select {
            width: 95%;
            padding: 15px 20px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            background-color: #f9f9f9;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            color: #555;
        }

        input[type="text"]:focus, input[type="password"]:focus, select:focus {
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

        h2 {
            text-align: center;
            font-size: 2rem;
            color: #007BFF;
            margin-bottom: 20px;
        }

        .dropdown-region {
            width: 105%;
            padding: 15px 20px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            background-color: #f9f9f9;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            color: #555;
        }

        .dropdown-region:focus {
            border-color: #007BFF;
            box-shadow: 0px 4px 15px rgba(0, 123, 255, 0.2);
            outline: none;
            background-color: #fff;
        }

        /* Styles for the message label */
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

        /* Ensure responsiveness on mobile devices */
        @media (max-width: 768px) {
            .container {
                width: 100%;
                margin: 10px;
                padding: 20px;
            }

            h2 {
                font-size: 1.8rem;
            }

            input[type="text"], input[type="password"], select {
                padding: 12px 15px;
                font-size: 0.9rem;
            }

            .register-button {
                font-size: 1rem;
                padding: 12px;
            }
        }

        /* Very small screen sizes */
        @media (max-width: 480px) {
            h2 {
                font-size: 1.5rem;
            }

            input[type="text"], input[type="password"], select {
                padding: 10px 12px;
                font-size: 0.85rem;
            }

            .register-button {
                font-size: 0.95rem;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Doctor Register Form</h2>

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
                <label for="ddlSpeciality">Medical Specialty</label>
                <asp:DropDownList ID="ddlSpeciality" runat="server" CssClass="dropdown-region"></asp:DropDownList>
            </div>

            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="register-button" />
            </div>

            <asp:HyperLink ID="lnkReturnHomepage" runat="server" CssClass="return-homepage" NavigateUrl="~/Pages/Main.aspx">Return to Homepage</asp:HyperLink>
        </div>
    </form>
</body>
</html>
