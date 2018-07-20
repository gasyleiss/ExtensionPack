<#
    .SYNOPSIS
    Executes commands or shell scripts at a remote host via ssh batch mode.

    .DESCRIPTION
    Executes commands or shell scripts at a remote host via ssh batch mode.

    .PARAMETER UserName
    The user name that is used to authenticate at the remote host.

    .PARAMETER RemoteHost
    The machine name or IP address of the remote host.

    .PARAMETER Commands
    The commands to execute at the remote host.

    .PARAMETER ShellScriptPath
    EXPERIMENTAL: File path of the shell script at the ScriptRunner service host.

    .PARAMETER Encoding
    The encoding of the shell script file.

#>

[CmdletBinding()]
param
(
    [Parameter(Mandatory=$true)]
    [string]$UserName,
    [Parameter(Mandatory=$true)]
    [string]$RemoteHost,
    [Parameter(Mandatory=$true, ParameterSetName='Commands')]
    [string[]]$Commands,
    [Parameter(Mandatory=$true, ParameterSetName='ShellScript')]
    [string]$ShellScriptPath,
    [Parameter(ParameterSetName='ShellScript')]
    [string]$Encoding = 'UTF8'
)

if ($PSCmdlet.ParameterSetName -eq 'Commands'){
    foreach ($command in $Commands) {
        "$UserName@$RemoteHost `$ $command"
        & cmd.exe '/c' "ssh.exe 2>&1 -o `"BatchMode yes`" $UserName@$RemoteHost $command"
        if($LASTEXITCODE -ne 0){
            throw "SSH failed with ExitCode '$LASTEXITCODE'."
        }
    }
}
elseif ($PSCmdlet.ParameterSetName -eq 'ShellScript') {
    if(Test-Path -Path $ShellScriptPath -ErrorAction SilentlyContinue){
        "### E X P E R I M E N T A L ###"
        $sh = Get-Content -Path $ShellScriptPath -Encoding $Encoding -Raw
        $sh = $sh -creplace '(?m)^\s*\r?\n',''
        $sh = (($sh -split "`n") | Where-Object {!($_.StartsWith('#'))}) -join ';'
        $sh = $sh.Trim(@(';'))
        "Run 'ssh -o `"BatchMode yes`" $UserName@$RemoteHost $sh' ..."
        & cmd.exe '/c' "ssh.exe 2>&1 -o `"BatchMode yes`" $UserName@$RemoteHost `"$sh`""
        if($LASTEXITCODE -ne 0){
            throw "SSH failed with ExitCode '$LASTEXITCODE'."
        }
    }
    else {
        throw "Path '$ShellScriptPath' does not exist."
    }
}
else{
    throw "Invalid ParameterSet '$($PSCmdlet.ParameterSetName)'."
}
