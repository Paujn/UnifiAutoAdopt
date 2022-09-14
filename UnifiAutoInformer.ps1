$Password = "password"
$User = "user"
$Command = "mca-cli-op set-inform http://your.domain:8080/inform"

$ComputerList = @()
$Subnet = 1
foreach ($IP in $Subnet) {

$ComputerList += 1..255 | % {"192.168.$IP.$_"}

}

$ErrorActionPreference = SilentlyContinue

foreach($Computer in $ComputerList){
    if(Test-Connection -ComputerName $Computer -Count 1){
        $secpasswd = ConvertTo-SecureString $Password -AsPlainText -Force
        $Credentials = New-Object System.Management.Automation.PSCredential($User, $secpasswd)
        $SessionID = New-SSHSession -AcceptKey -ComputerName $Computer -Credential $Credentials #Connect Over SSH
        Invoke-SSHCommand -Index $sessionid.sessionid -Command $Command # Invoke Command Over SSH
    }else{
        Write-Host "Host is down: $Computer" -ForegroundColor Red
    }
}