# Notifications

+ [Send-SRMail.ps1](./Send-SRMail.ps1)

   Sends an e-mail message<br>
   You can use the script as function script. The script must be tagged \_Lib_ for this purpose. <br>
   To load the script into the Powershell session automatically, it should be included in the PowerShell options of the action.<br><br>
   Example 1 for calling the SendMail function in your main script:<br> SendMail "UserFrom <user01@example.com>" "UserTo <user02@example.com>"  "My subject" "Body text" $true "Normal" "smtp.fabrikam.com"<br>
   Example 2 for calling the SendMail function in your main script:<br> 
   SendMail -MailSender "UserFrom <user01@example.com>" -MailRecipients "UserTo <user02@example.com>" -MailSubject "My subject" -MailBody "Body text" -MailUseSsL $true -MailPriority "Normal" -MailServer "smtp.fabrikam.com"