param([string]$path)

param([string]$main_suffix="main")

param([string]$app_suffix="appendix")


$page = ($a = pdftk $path dump_data | Select-String -Pattern  "Appendix|supplement|supplementary" -Context 0,2 |Out-string -Stream| Select-String -Pattern BookmarkPage -Context 0) -replace "\D", ""


$main = Join-Path $(Split-Path -Path $path) $(Split-Path $path -LeafBase)+$main_suffix+".pdf"

$app = Join-Path $(Split-Path -Path $path) $(Split-Path $path -LeafBase)+$app_suffix+".pdf"

pdftk $path cat 1-$($page-1) output $main

pdftk $path	 cat $page-end  output $app
