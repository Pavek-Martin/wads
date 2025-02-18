cls

Remove-Variable wads_folder,wads_files,file_run_name,d_wads_files -ErrorAction SilentlyContinue

$wads_folder = "wads/"

if (-not ( Test-Path $wads_folder )){
echo "neanlezen adresar $wads_folder"
sleep 3
exit
}

$wads_files = @()
#$wads_files += @(Get-ChildItem -Path $wads_folder *.wad -Include $pole_include -Name)  # "*.wad" neni case senzitive takze i "*.WAD"
$wads_files += @(Get-ChildItem -Path $wads_folder *.wad -Name)
#echo $wads_files
$d_wads_files = $wads_files.Length
#echo $d_wads_files
if ( $d_wads_files -eq 0 ){
echo "nenalezeny zadne sourory /Wads/*.wad"
sleep 3
exit
}

for ( $aa = 0; $aa -le $d_wads_files -1; $aa++){
# nazev souboru *.bat se vezme ze souboru *.wad
$file_run_name = $wads_files[$aa].Substring(0,$wads_files[$aa].Length -3) + "bat"
echo $file_run_name
Remove-Item $file_run_name -Force -ErrorAction SilentlyContinue
# ^^ paklize by se smazal nejaky *.wad tak by knemu zbyla "prazdna" davka na spusteni, takto vse vzdy aktualni
sleep 1

<#
@echo off
edit c:\hry\doom2\wads\ATTACK.txt
doom2.exe -file wads/ATTACK.WAD
@echo off
#>

# pole pro spusteni
$pole_run_file = @("@echo off")
$pole_run_file += "edit wads\" + $wads_files[$aa].Substring(0,$wads_files[$aa].Length -3) + "txt" # na jeden radek :)
$pole_run_file += "doom2.exe -file wads\" + $wads_files[$aa]
$pole_run_file += "@echo off"
echo $pole_run_file
echo "----------------------------------------"

# write file
Set-Content $file_run_name -Encoding ASCII -Value $pole_run_file
sleep 1
}

echo "hotovo, zapsano $d_wads_files souboru"
sleep 5
