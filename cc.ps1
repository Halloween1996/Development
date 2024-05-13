if (!$args) {
	cd ..
	Get-ChildItem $path | Out-Host -paging
	Exit
}
if(Test-Path $args){
	$path = Resolve-Path $args
	Set-Location $path
	Get-ChildItem $path
}else{
	"Could not find the path : $path"
}