<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login - Doctor Appointment</title>
    <style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #a2c2e6, #004a7c);
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .login-container {
        background: #fff;
        padding: 2rem;
        border-radius: 12px;
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
        width: 100%;
        max-width: 360px;
        transition: transform 0.3s ease;
        transform: scale(1);
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
        color: #004a7c; /* Fallback color */
    }

    .login-container label {
        display: block;
        margin-bottom: 0.5rem;
        color: #333;
        font-size: 0.9rem;
        font-weight: 500;
    }

    .login-container input[type="text"], 
    .login-container input[type="password"] {
        width: 100%;
        padding: 0.8rem;
        margin-bottom: 1rem;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
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
          <%-- <asp:HyperLink ID="lnkForgotPassword" runat="server" CssClass="forgot-password" NavigateUrl="~/ForgotPassword.aspx">Forgot your password?</asp:HyperLink> --%>
           <asp:HyperLink ID="lnkReturnHomepage" runat="server" CssClass="return-homepage" NavigateUrl="~/Pages/Main.aspx">Return to Homepage</asp:HyperLink> 
        </div>

    </form>
</body>
</html>