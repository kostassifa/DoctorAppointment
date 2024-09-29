<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CancelBookingDoctor.aspx.cs" Inherits="DoctorAppointmentWebApp.Pages.CancelBookingDoctor" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cancel Appointments</title>
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .container {
        background-color: #fff;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        width: 80%;
        max-width: 1000px;
    }

    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #0066cc;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    th, td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e0e0e0;
    }

    th {
        background-color: #0066cc;
        color: white;
        font-weight: 600;
        text-align: center;
    }

    td {
        text-align: center;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    .btn-cancel {
        background-color: #0066cc;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
        display: block;
        margin: 0 auto;
        transition: background-color 0.3s ease;
    }

    .btn-cancel:hover {
        background-color: #005bb5;
    }

    .btn-cancel:disabled {
        background-color: #cccccc;
        cursor: not-allowed;
    }
    .no-appointments {
        color: #ff6b6b;
        font-size: 18px;
        margin-bottom: 20px;
        background-color: #005bb5;
        border-radius: 8px;
        padding: 10px;
        border: 1px solid #ffcccc;
        display: inline-block;
        width: 100%;
        max-width: 400px;
        margin: 0 auto;
        text-align: center;
        font-weight: 500;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <div class="container">
            <h2>Cancel Appointments</h2>
            <asp:Label ID="NoAppointmentsLabel" runat="server" CssClass="no-appointments" Visible="false" Text="No appointments to cancel." />
            <asp:GridView ID="AppointmentGridView" runat="server" AutoGenerateColumns="False" CssClass="appointment-grid">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="SelectCheckBox" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="amka" HeaderText="Amka" />
                    <asp:BoundField DataField="doctor" HeaderText="Doctor" />
                    <asp:BoundField DataField="Appoitment_Date" HeaderText="Appointment Date" DataFormatString="{0:yyyy-MM-dd}" HtmlEncode="false" />
                    <asp:BoundField DataField="Appoitment_Time" HeaderText="Appointment Time" DataFormatString="{0:HH:mm:ss}" HtmlEncode="false" />
                    <asp:BoundField DataField="book_notes" HeaderText="Notes" />
                </Columns>
            </asp:GridView>
                     <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                     <ProgressTemplate>
                         <div style="color: red; font-weight: bold; text-align: center; padding: 10px;">
                             Please wait, cancelling appointments...
                         </div>
                     </ProgressTemplate>
                 </asp:UpdateProgress>
            <div class="actions">
                <asp:Button ID="CancelButton" runat="server" Text="Cancel Selected Appointments" CssClass="btn-cancel" OnClick="CancelButton_Click" />
            </div>
                  <br/>
                  <br/>
                  <br/>
            <asp:HyperLink ID="lnkReturnHomepage" runat="server" CssClass="return-homepage" NavigateUrl="~/Pages/Main.aspx">Return to Homepage</asp:HyperLink> 
        </div>
            </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="CancelButton" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>

        <script>
            function toggleSelectAll(source) {
                checkboxes = document.querySelectorAll('input[type="checkbox"]');
                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i] != source)
                        checkboxes[i].checked = source.checked;
                }
            }
        </script>
    </form>
</body>
</html>
