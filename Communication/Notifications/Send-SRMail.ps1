#Requires -Version 4.0

<#
.SYNOPSIS
    Sends an e-mail message

.DESCRIPTION

.NOTES
    This PowerShell script was developed and optimized for ScriptRunner. The use of the scripts requires ScriptRunner. 
    The customer or user is authorized to copy the script from the repository and use them in ScriptRunner. 
    The terms of use for ScriptRunner do not apply to this script. In particular, AppSphere AG assumes no liability for the function, 
    the use and the consequences of the use of this freely available script.
    PowerShell is a product of Microsoft Corporation. ScriptRunner is a product of AppSphere AG.
    © AppSphere AG

.COMPONENT

.Parameter From
    Specifies the address from which the mail is sent

.Parameter To
    Specifies the addresses to which the mail is sent. 
    Enter names (optional) and the e-mail address, such as "John Doe <john.doe@example.com>".
    Use the comma to separate the addresses

.Parameter Subject
    Specifies the subject of the e-mail message
    
.Parameter Body
    Specifies the body (content) of the e-mail message

.Parameter Cc
    Specifies the e-mail addresses to which a carbon copy (CC) of the e-mail message is sent. 
    Enter names (optional) and the e-mail address, such as "John Doe <john.doe@example.com>".
    Use the comma to separate the addresses

.Parameter Attachments
    Specifies the path and file names of files to be attached to the e-mail message. 
    Use the comma to separate the files

.Parameter SmtpServer
    Specifies the name of the SMTP server that sends the e-mail message. 
    The default value is the value of the $PSEmailServer preference variable

.Parameter ServerCredential
    Specifies a user account that has permission to perform this action. The default is the current user.

.Parameter Priority
    Specifies the priority of the e-mail message

.Parameter UseSsl
    Uses the Secure Sockets Layer (SSL) protocol to establish a connection to the remote computer to send mail

.Parameter BodyAsHtml
    Specifies that the value of the Body parameter contains HTML
#>

[CmdLetBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string]$From,
    [Parameter(Mandatory = $true)]
    [string]$To,
    [Parameter(Mandatory = $true)]
    [string]$Subject,
    [string]$Body ,
    [string]$Cc,
    [string]$Attachments,
    [string]$SmtpServer,
    [PSCredential]$ServerCredential,
    [ValidateSet('Normal','High','Low')]
    [string]$Priority='Normal',
    [switch]$UseSsl ,
    [switch]$BodyAsHtml
)

try{    
    function SendMail
    {
        <#
    		.SYNOPSIS
                Function for send mail. You can use the function from other scripts
			
            .PARAMETER MailSender
                Specifies the address from which the mail is sent

            .PARAMETER MailRecipients
                Specifies the addresses to which the mail is sent

            .PARAMETER MailSubject
                Specifies the subject of the email message

            .PARAMETER MailBody
                Specifies the body of the email message

            .PARAMETER MailUseSsl
                Indicates that the cmdlet uses the Secure Sockets Layer (SSL) protocol to establish a connection to the remote computer to send mail

            .PARAMETER MailPriority
                Specifies the priority of the email message. The acceptable values for this parameter are: Normal, High, Low

            .PARAMETER MailServer
                Specifies the name of the SMTP server that sends the e-mail message. 
                The default value is the value of the $PSEmailServer preference variable

            .PARAMETER Credential
                Specifies a user account that has permission to perform this action. The default is the current user.

            .PARAMETER CopyRecipients
                Specifies the e-mail addresses to which a carbon copy (CC) of the e-mail message is sent. 
                Enter names (optional) and the e-mail address, such as "John Doe <john.doe@example.com>".
                Use the comma to separate the addresses

            .PARAMETER Files
                Specifies the path and file names of files to be attached to the e-mail message. 
                Use the comma to separate the files

            .Parameter HtmlBody
                Specifies that the value of the Body parameter contains HTML
        #>
        [CmdletBinding()]
        param(
            [parameter(Mandatory = $true)]
            [string]$MailSender,
            [parameter(Mandatory = $true)]
            [string[]]$MailRecipients,
            [parameter(Mandatory = $true)]
            [string]$MailSubject,
            [string]$MailBody,
            [bool]$MailUseSsl,
            [ValidateSet('Normal','High','Low')]    
            [string]$MailPriority ='Normal',
            [string]$MailServer ,
            [PSCredential]$Credential,
            [string[]]$CopyRecipients, 
            [string[]] $Files,
            [switch]$HtmlBody
         )
         
            if([System.String]::IsNullOrEmpty($MailBody ) -eq $true){ 
                $MailBody = ' ' 
            } 
                
            [hashtable]$cmdArgs = @{'ErrorAction' = 'Stop'
                                    'BodyAsHtml' = $HtmlBody
                                    'To' = $MailRecipients
                                    'Subject' = $MailSubject
                                    'Body' = $MailBody
                                    'From' = $MailSender
                                    'Priority' = $MailPriority
                                    'UseSsl' = $MailUseSsl
                                    }
            if([System.String]::IsNullOrWhiteSpace($MailServer) -eq $false){# Server
                $cmdArgs.Add('SmtpServer' ,$MailServer)
            }                                   
            if($null -ne $CopyRecipients){# CC
                $cmdArgs.Add('Cc', $CopyRecipients)
            }
            if($null -ne $Files){# Attachments
                $cmdArgs.Add('Attachments', $Files)
            }
            if($null -ne $Credential){# Credential
                $cmdArgs.Add('Credential', $Credential)
            }
            Send-MailMessage @cmdArgs
    }
    [string[]]$Script:atts=$null
    if(-not [System.String]::IsNullOrWhiteSpace($Attachments)){
        $Script:atts = $Attachments.Split(',')
    }
    [string[]]$Script:copies = $null
    if(-not [System.String]::IsNullOrWhiteSpace($Cc)){
        $Script:copies = $Cc.Split(',')
    }
    [string[]]$Addr=$To.Split(',')
  
    SendMail -MailSender $From -MailRecipients $Addr -MailSubject $Subject -MailBody $Body -MailUseSsl $UseSsl `
            -MailPriority $Priority -MailServer $SmtpServer -Credential $ServerCredential -CopyRecipients $Script:copies `
            -Files $Script:atts -HtmlBody:$BodyAsHtml

    if($SRXEnv) {
        $SRXEnv.ResultMessage = "Mail sent out"
    }    
    else {
        Write-Output "Mail sent out"
    }
}
catch{
    throw
}
finally{
}