Set-Location -Path $PSScriptRoot

# cleanup
Remove-Item -Path prebuilt\* -Recurse -ErrorAction SilentlyContinue

# find version from include files
$t = Select-String -Pattern '#define\s+NSS_VERSION\s+"[0-9A-Za-z\.]+"' -Path "dist\public\nss\nss.h" | % { $_.Matches } | % { $_.Value } 
if ($t -match "[0-9][0-9A-Za-z\.]+") {
    $nssVer = $matches[0];
} else {
    $nssVer = "X.XX";
}
$t = Select-String -Pattern '#define\s+PR_VERSION\s+"[0-9A-Za-z\.]+"' -Path "nspr\pr\include\prinit.h" | % { $_.Matches } | % { $_.Value } 
if ($t -match "[0-9][0-9A-Za-z\.]+") {
    $nsprVer = $matches[0];
} else {
    $nsprVer = "X.XX";
}
$name = "nss-$nssVer-nspr-$nsprVer"

$builds = @(
    ("debug\win32", "WIN954.0_DBG.OBJD"),
    ("release\win32", "WIN954.0_OPT.OBJ"),
    ("debug\x64", "WIN954.0_x86_64_64_DBG.OBJD"),
    ("release\x64", "WIN954.0_x86_64_64_OPT.OBJ")
);

# includes
New-Item prebuilt\$name\include -ItemType directory | Out-Null
Copy-Item dist\public\* -Destination prebuilt\$name\include -Recurse
foreach ($pattern in "obsolete", "*.h") {
    Copy-Item dist\$($builds[0][1])\include\$pattern -Destination prebuilt\$name\include\ -Recurse
} 

# bin, lib, dll
$i = 0;
foreach ($build in $builds) {
    $outDir, $srcDir = $build;
    foreach ($t in "bin", "lib", "dll") {
        New-Item prebuilt\$name\$outDir\$t -ItemType Directory | Out-Null
    }
    Copy-Item dist\$srcDir\bin\*.exe -Destination prebuilt\$name\$outDir\bin\ -Recurse
    Copy-Item dist\$srcDir\lib\*.lib -Destination prebuilt\$name\$outDir\lib\ -Recurse
    Copy-Item dist\$srcDir\lib\*.dll -Destination prebuilt\$name\$outDir\dll\ -Recurse
}

# create zip archive
Push-Location -Path prebuilt
Compress-Archive -Path $name -DestinationPath "$name.zip" -CompressionLevel Optimal
Pop-Location

# cleanup
Remove-Item -Path prebuilt\$name -Recurse
