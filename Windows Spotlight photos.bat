@echo off
for %%i in ("%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\*") do if %%~zi gtr 130000 (
	if not exist Windows_Spotlight_photos md Windows_Spotlight_photos
	copy "%%i" "%cd%\Windows_Spotlight_photos"
)
cd Windows_Spotlight_photos
ren * *.png
start %cd%