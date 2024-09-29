<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterOption.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.RegisterOption" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register Option</title>
    <style>
/* Header Styles */
      html, body {
          height: 100%;
          margin: 0;
          padding: 0;
          display: flex;
          flex-direction: column;
          font-family: 'Poppins', sans-serif;
          background-color: #f0f4f8;
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
    gap: 25px; /* Increase gap for better separation */
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
    margin-top: 448px;
}

.footer p {
    margin: 0;
    font-size: 14px;
}

.container {
    text-align: center;
    padding: 40px; /* Increase padding for cleaner look */
    background-color: #ffffff;
    border-radius: 15px;
    box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
    width: 80%;
    max-width: 700px;
    margin: 20px auto; /* Center the container and add margin */
    margin-top: 230px;
}

h2 {
    font-size: 32px;
    color: #333333;
    margin-bottom: 30px; /* Adjust spacing between title and options */
}

.option-container {
    display: flex;
    justify-content: space-around;
    align-items: center;
    gap: 40px; /* Increase gap between the option boxes */
}

/* Doctor Option */
.option-box.doctor {
    background-color: #4caf50; /* Green */
    border: 2px solid transparent;
    border-radius: 12px;
    padding: 40px; /* Increased padding for better readability */
    width: 220px;
    height: 220px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
}

/* Patient Option */
.option-box.patient {
    background-color: #f44336; /* Red */
    border: 2px solid transparent;
    border-radius: 12px;
    padding: 40px;
    width: 220px;
    height: 220px;
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
    color: #000; /* Black text for better contrast */
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
                <!-- Footer Section -->
        <div class="footer">
            &copy; 2024 Doctor Appointment System. All rights reserved.
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
