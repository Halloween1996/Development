$Compare_1 = Get-FileHash ($($Args[0]))
$Compare_2 = Get-FileHash ($($Args[1]))
$Compare_1
$Compare_2
 if ($Compare_1.Hash -match $Compare_2.Hash) {
    Write-Host "They are the same file."
}