Function ActionOnClick {
    $Outlook = New-Object -ComObject Outlook.Application
    $BodyMessage = $AlertRichTextBox.Text
    $Email = $Outlook.CreateItem(0)
    $Email.To = "$AlertTextBox.Text"
    $Email.Body = "$BodyMessage"

    $Email.Send()
    [System.Windows.MessageBox]::Show("ההודעה נשלחה בהצלחה");
}