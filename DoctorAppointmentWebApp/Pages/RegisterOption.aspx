<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterOption.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.RegisterOption" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register Option</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 900px;
        }
        h2 {
            font-size: 32px;
            color: #333333;
            margin-bottom: 40px;
        }
        .option-container {
            display: flex;
            justify-content: space-around;
            align-items: center;
            gap: 20px;
        }
        /* Doctor Option */
        .option-box.doctor {
            background-color: #4caf50; /* Green */
            border: 2px solid transparent;
            border-radius: 12px;
            padding: 30px;
            width: 200px;
            height: 200px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        /* Patient Option */
        .option-box.patient {
            background-color: #f44336; /* Red */
            border: 2px solid transparent;
            border-radius: 12px;
            padding: 30px;
            width: 200px;
            height: 200px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        /* Hover effect for both options */
        .option-box:hover {
            background-color: #ffffff;
            border: 2px solid #00bcd4;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }
        /* Active state */
        .option-box.active {
            border: 2px solid #00bcd4;
        }
        .option-box span {
            display: block;
            margin-top: 10px;
            font-size: 18px;
            font-weight: bold;
            color: #000; /* White text for better contrast */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Choose Registration Option</h2>
            <div class="option-container">
                <div class="option-box doctor" onclick="redirectToPage('Doctor')">
                    <span>Doctor</span>
                </div>
                <div class="option-box patient" onclick="redirectToPage('Patient')">
                    <span>Patient</span>
                </div>
            </div>
        </div>
    </form>
        <script type="text/javascript">
            function redirectToPage(type) {
                if ( type === 'Patient') {
                    window.location.href = 'Register.aspx';
                }
                if (type === 'Doctor') {
                    window.location.href = 'RegisterDoctor.aspx';
                }
            }
    </script>
</body>
</html>
