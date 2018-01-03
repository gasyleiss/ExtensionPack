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
#>

[CmdLetBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string]$From,
    [Parameter(Mandatory = $true)]
    [string]$To,
    [Parameter(Mandatory = $true)]
    [string]$Subject,
    [string]$Body,
    [string]$Cc,
    [string]$Attachments,
    [string]$SmtpServer,
    [PSCredential]$ServerCredential,
    [ValidateSet('Normal','High','Low')]
    [string]$Priority='Normal',
    [switch]$UseSsl
)

try{    
    [string[]]$Script:Addr=$To.Split(',')
    if($PSBoundParameters.ContainsKey('Body') -eq $false ){
        $Body=' '
    }
    if(($PSBoundParameters.ContainsKey('SmtpServer') -eq $true ) -and ($PSBoundParameters.ContainsKey('ServerCredential') -eq $true )){
        if(($PSBoundParameters.ContainsKey('Cc') -eq $true) -and ($PSBoundParameters.ContainsKey('Attachments') -eq $true) ){
            [string[]]$files=$Attachments.Split(',')
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies -Attachments $files -SmtpServer $SmtpServer -Credential $ServerCredential -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Cc') -eq $true ){
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies  -SmtpServer $SmtpServer -Credential $ServerCredential -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Attachments') -eq $true) {
            [string[]]$files=$Attachments.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Attachments $files -SmtpServer $SmtpServer -Credential $ServerCredential -UseSsl:$UseSsl
        }
        else{
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -SmtpServer $SmtpServer -Credential $ServerCredential -UseSsl:$UseSsl
        }
    }
    elseif($PSBoundParameters.ContainsKey('ServerCredential') -eq $true ){
        if(($PSBoundParameters.ContainsKey('Cc') -eq $true) -and ($PSBoundParameters.ContainsKey('Attachments') -eq $true) ){
            [string[]]$files=$Attachments.Split(',')
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies -Attachments $files -Credential $ServerCredential -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Cc') -eq $true ){
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies  -Credential $ServerCredential -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Attachments') -eq $true) {
            [string[]]$files=$Attachments.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Attachments $files -Credential $ServerCredential -UseSsl:$UseSsl
        }
        else{
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Credential $ServerCredential -UseSsl:$UseSsl
        }
    }
    elseif($PSBoundParameters.ContainsKey('SmtpServer') -eq $true ){
        if(($PSBoundParameters.ContainsKey('Cc') -eq $true) -and ($PSBoundParameters.ContainsKey('Attachments') -eq $true) ){
            [string[]]$files=$Attachments.Split(',')
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies -Attachments $files -SmtpServer $SmtpServer  -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Cc') -eq $true ){
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies -SmtpServer $SmtpServer  -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Attachments') -eq $true) {
            [string[]]$files=$Attachments.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Attachments $files -SmtpServer $SmtpServer  -UseSsl:$UseSsl
        }
        else{
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -SmtpServer $SmtpServer  -UseSsl:$UseSsl
        }
    }
    else{
        if(($PSBoundParameters.ContainsKey('Cc') -eq $true) -and ($PSBoundParameters.ContainsKey('Attachments') -eq $true) ){
            [string[]]$files=$Attachments.Split(',')
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies -Attachments $files -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Cc') -eq $true ){
            [string[]]$copies=$Cc.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Cc $copies  -UseSsl:$UseSsl
        }
        elseif($PSBoundParameters.ContainsKey('Attachments') -eq $true) {
            [string[]]$files=$Attachments.Split(',')
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority `
                -Attachments $files -UseSsl:$UseSsl
        }
        else{
            Send-MailMessage -To $Script:Addr -Subject $Subject -Body $Body -From $From -Priority $Priority -UseSsl:$UseSsl
        }
    }
}
catch{
    throw
}
finally{
}