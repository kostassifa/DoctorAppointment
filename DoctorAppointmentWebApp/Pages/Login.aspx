<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login - Doctor Appointment</title>
    <style>
/* Reset browser default margin and padding */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    background-color: #f0f4f8;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh; /* Ensures the body takes full height of the viewport */
    position: relative; /* This allows positioning of fixed elements relative to the body */
    margin: 0;
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
    width: 100%;
    position: fixed;
    top: 0;
    left: 0;
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
    position: fixed;
    bottom: 0;
    left: 0;
}

.footer p {
    margin: 0;
    font-size: 14px;
}

/* Centering the Login Container */
.container-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh; /* Full height of viewport */
    padding-top: 100px; /* Adding space for the fixed header */
    padding-bottom: 100px; /* Adding space for the fixed footer */
}

.login-container {
    background: #fff;
    padding: 2.5rem;
    border-radius: 12px;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
    width: 100%;
    max-width: 360px;
    transition: transform 0.3s ease;
}

.login-container:hover {
    transform: scale(1.03);
}

.login-container h2 {
    text-align: center;
    margin-bottom: 1.5rem;
    color: #004a7c;
    font-size: 1.8rem;
    font-weight: 700;
    background: linear-gradient(45deg, #007bff, #004a7c);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    color: #004a7c;
}

.login-container label {
    display: block;
    margin-bottom: 0.5rem;
    color: #34E;
    font-size: 0.9rem;
    font-weight: 500;
}

.login-container input[type="text"], 
.login-container input[type="password"] {
    width: 100%;
    padding: 0.8rem;
    margin-bottom: 1.2rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 1rem;
    color: #333;
    transition: border-color 0.3s ease;
}

.login-container input[type="text"]:focus, 
.login-container input[type="password"]:focus {
    border-color: #007bff;
    outline: none;
}

.login-container input[type="submit"] {
    width: 100%;
    padding: 0.8rem;
    border: none;
    border-radius: 8px;
    background: linear-gradient(45deg, #007bff, #004a7c);
    color: #fff;
    font-size: 1.1rem;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.3s, transform 0.3s;
}

.login-container input[type="submit"]:hover {
    background: linear-gradient(45deg, #004a7c, #007bff);
    transform: translateY(-2px);
}

.login-container .forgot-password {
    display: block;
    text-align: center;
    margin-top: 1rem;
    color: #007bff;
    text-decoration: none;
    font-size: 0.9rem;
}

.login-container .forgot-password:hover {
    text-decoration: underline;
}

.error-message {
    color: red;
    text-align: center;
    margin-bottom: 1rem;
}
</style>
</head>
<body>
    <form id="form1" runat="server">
                <div class="header">
            <img src="Images/Flag_of_the_Red_Cross.png" alt="Red Cross Flag" />
            <h1>I Need Doctor</h1>
            <div class="buttons">
                <a href="Main.aspx">Home</a>
                <a href="javascript:history.back()">Back</a>
            </div>
        </div>
        <div class="login-container">
            <h2>Login</h2>
            <asp:Label runat="server" AssociatedControlID="txtUsername" Text="Amka" />
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your amka" />

            <asp:Label runat="server" AssociatedControlID="txtPassword" Text="Password" />
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password" />
            <asp:Literal ID="litMessage" runat="server" />
            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary" Text="Login"  OnClick="btnLogin_Click" />
            <br/>
            <br/>
            <br/>
           <asp:HyperLink ID="lnkForgotPassword" runat="server" CssClass="forgot-password" NavigateUrl="~/Pages/ForgotPassword.aspx">Forgot your password?</asp:HyperLink> 
          <!-- <asp:HyperLink ID="lnkReturnHomepage" runat="server" CssClass="return-homepage" NavigateUrl="~/Pages/Main.aspx">Return to Homepage</asp:HyperLink> -->
        </div>
         <!-- Footer Section -->
        <div class="footer">
            &copy; 2024 Doctor Appointment System. All rights reserved.
        </div>
    </form>
</body>
</html>