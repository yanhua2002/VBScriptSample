$code={Start-Sleep -Seconds 5; "Hello"}
$newPowerShell=[powershell]::Create().AddScript($code)
$handle=$newPowerShell.begininvoke()

while ($handle.iscompleted -eq $false) {
    Write-Host '.' -NoNewline
    Start-Sleep -Milliseconds 500
}

Write-Host ''
$newPowerShell.endinvoke($handle)

$Throttle=20
$ScriptBlock={
    Param(
        [string]$ComputerName
    )
    $RunResult=Get-WmiObject -Class win32_processor -ComputerName $ComputerName | Select-Object -Property SystemName,Name,LoadPercentage
    
    return $RunResult
}

$RunspacePool=[runspacefactory]::CreateRunspacePool(1,$Throttle)
$RunspacePool.open()
$handles=@()

Import-Csv -Path .\Computers.csv | ForEach-Object -Process {
    $thread=[powershell]::Create().AddScript($ScriptBlock).AddArgument($_.ComputerName)
    $thread.RunspacePool=$RunspacePool
    $handles += New-Object -TypeName psobject -Property @{
        Server=$_
        Thread=$thread
        Result=$thread.BeginInvoke()
    }
}

do {
    $done=$true
    foreach ($handle in $handles) {
        if ($handle.Result -ne $null) {
            if ($handle.Result.IsCompleted) {
                $endResult=$handle.Thread.EndInvoke($handle.Result)
                #Write-Host $endResult.SystemName,`t,$endResult.LoadPercentage,`t,$endResult.Name
                $endResult
                $handle.Thread.Dispose()
                $handle.Result=$null
                $handle=$null
            }
            else {
                $done=$false
            }   
        }
    }
    if(-not $done) { Start-Sleep -Milliseconds 500 }
} until ($done)

$handles=$null
$RunspacePool.Close()
$RunspacePool.Dispose()