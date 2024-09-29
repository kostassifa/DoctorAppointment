<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" CodeBehind="BookAppoitment.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.BookAppoitment" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Booking</title>
    <style>
        /* Reset browser default margin and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
            height: 100vh; /* Full height of the viewport */
            display: flex;
            justify-content: center; /* Horizontally center the form */
            align-items: center; /* Vertically center the form */
            flex-direction: column; /* Ensure the form and footer stack properly */
            padding-top: 80px; /* Ensure space for the fixed header */
            padding-bottom: 80px; /* Ensure space for the fixed footer */
        }

        .header {
            background: linear-gradient(90deg, #007bff, #00c6ff);
            color: #fff;
            padding: 15px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            width: 100vw; /* Full viewport width */
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
            display: inline-block;
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
            width: 100vw; /* Full viewport width */
            position: fixed;
            bottom: 0;
            left: 0;
        }

        .footer p {
            margin: 0;
            font-size: 14px;
        }

        form {
            max-width: 600px; /* Maximum form width */
            width: 100%;
            padding: 2rem;
            background: #fff;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
        }

        h2 {
            text-align: center;
            color: #004a7c;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            background: linear-gradient(45deg, #007bff, #004a7c);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 1.1rem;
            transition: color 0.3s ease;
        }

        label:hover {
            color: #007bff;
        }

        select, input[type="text"], input[type="button"], input[type="submit"], input[type="date"], textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 1.5rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1rem;
            color: #333;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        select:focus, input[type="text"]:focus, input[type="date"]:focus, textarea:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.3);
        }

        input[type="submit"] {
            background: linear-gradient(45deg, #007bff, #004a7c);
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: 600;
            transition: background 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
            padding: 12px;
            border-radius: 8px;
        }

        input[type="submit"]:hover {
            background: linear-gradient(45deg, #004a7c, #007bff);
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        textarea {
            resize: vertical; /* Allow resizing only vertically */
        }

        .time-slot {
            display: flex;
            flex-direction: column;
        }

        .time-slot label {
            margin-bottom: 6px;
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

        <!-- Form Centered with Flexbox -->
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <form>
                    <h2>New Booking</h2>

                    <asp:Label ID="lblRegion" runat="server" Text="Region: "></asp:Label>
                    <asp:DropDownList ID="ddlRegion" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlRegion_SelectedIndexChanged"></asp:DropDownList>
                    <br />

                    <asp:Label ID="lblCategory" runat="server" Text="Category: "></asp:Label>
                    <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" Enabled="False"></asp:DropDownList>
                    <br />

                    <asp:Label ID="lblDoctor" runat="server" Text="Doctor: "></asp:Label>
                    <asp:DropDownList ID="ddlDoctor" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDoctor_SelectedIndexChanged" Enabled="False"></asp:DropDownList>
                    <br />

                    <asp:Label ID="lblDate" runat="server" Text="Select Date: "></asp:Label>
                    <asp:TextBox ID="datePicker" runat="server" Enabled="False" AutoPostBack="True" OnTextChanged="datePicker_TextChanged" />
                    <br />

                    <asp:Label ID="lblTime" runat="server" Text="Select Time Slot: "></asp:Label>
                    <asp:DropDownList ID="ddlTime" runat="server" CssClass="time-slot" Enabled="False"></asp:DropDownList>
                    <br />

                    <asp:Label ID="lblReason" runat="server" Text="Reason for Booking: "></asp:Label>
                    <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="6" MaxLength="3000"></asp:TextBox>
                    <br /><br />

                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                        <ProgressTemplate>
                            <div style="color: red; font-weight: bold;">WAIT FOR THE PROCESS TO FINISH BEFORE SUBMIT AGAIN...</div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                    <asp:Literal ID="litMessage" runat="server" EnableViewState="False"></asp:Literal>
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_OnClick" Text="Submit" />
                </form>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="ddlRegion" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlDoctor" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="datePicker" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>

        <!-- Footer Section -->
        <div class="footer">
            <p>&copy; 2024 Doctor Appointment System. All rights reserved.</p>
        </div>
    </form>
</body>
</html>
