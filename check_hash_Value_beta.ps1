Get-ChildItem -path $Args -Recurse -file | foreach-Object {
 $Temp = Get-FileHash ($_.FullName)
 Add-Content -path C:\Users\Halloween\SynologyDrive\Ref\Present\Check_Hash_Result.md -value "$($Temp.Path),$($Temp.Hash),"
}
Add-Content -path C:\Users\Halloween\SynologyDrive\Ref\Present\Check_Hash_Result.md -value "-------------The End-------------"