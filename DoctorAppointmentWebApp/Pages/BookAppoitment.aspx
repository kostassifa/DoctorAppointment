<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" CodeBehind="BookAppoitment.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.BookAppoitment" Async="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>New Booking</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #a2c2e6, #004a7c);
        }

        form {
            max-width: 600px;
            margin: 50px auto;
            padding: 2rem;
            background: #fff;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            transition: transform 0.3s ease;
            transform: scale(1);
        }

        form:hover {
            transform: scale(1.02);
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
        }

        select, input[type="text"], input[type="button"], input[type="submit"], input[type="date"], textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 1.5rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 1rem;
            color: #333;
            transition: border-color 0.3s ease;
        }

        select:focus, input[type="text"]:focus, input[type="date"]:focus, textarea:focus {
            border-color: #007bff;
            outline: none;
        }

        input[type="submit"] {
            background: linear-gradient(45deg, #007bff, #004a7c);
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        input[type="submit"]:hover {
            background: linear-gradient(45deg, #004a7c, #007bff);
            transform: translateY(-2px);
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
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div>
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
                    <br />
                    <br />
                    <br />
                    <asp:HyperLink ID="lnkReturnHomepage" runat="server" CssClass="return-homepage" NavigateUrl="~/Pages/Main.aspx">Return to Homepage</asp:HyperLink>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="ddlRegion" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlDoctor" EventName="SelectedIndexChanged" />
                <asp:AsyncPostBackTrigger ControlID="datePicker" EventName="TextChanged" />
            </Triggers>
        </asp:UpdatePanel>
    </form>
</body>
</html>