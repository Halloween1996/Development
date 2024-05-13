Function choose-Item() {
    DO
    {
        Set-Variable -Name Result_Number -Scope Local -value 0
        foreach($line in $Current_Directory_File) {
		    $Result_Number++
		    Set-Variable -Name Result_$Result_Number -Scope Local -value "$line"
		    Write-Host [$Result_Number] $line.Mode $line.Name
	    }
        if ($Result_Number -eq 0) {
	        Write-Host "No Result Found."
	        Exit
        }
        if ($Result_Number -gt 1) {
            $chosen = $null
            Write-Host "We Found $Result_Number Result"
            $chosen = Read-Host "What is your chose?"
            if ([bool](Get-Variable Result_$chosen -Scope 'Local' -ErrorAction 'Ignore')) {
                $Result_1 = Get-Variable Result_$chosen -ValueOnly
                $Result_Number = 1
            } else {
                $Current_Directory_File=(Get-ChildItem "$PWD\*$chosen*")
            }
        }
    } Until ($Result_Number -eq 1)
    Return "$Result_1"
}
if (!$args) {
    cd ..
    Get-ChildItem $PWD | Out-Host -Paging
    exit
}
$Current_Directory_File=(Get-ChildItem -Path "$PWD\*$args*" -Directory)
$ddc = choose-Item($Current_Directory_File)
cd "$ddc"
Get-ChildItem $PWD | sort LastWriteTime | select -last 5

