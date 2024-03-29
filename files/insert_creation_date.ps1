param (
    [string]$directory = $(throw "-directory is required."),
    [string]$include = "*.md"
)

$files = Get-ChildItem -recurse $directory -include $include
foreach ($file in $files)
{ 
    $date = "Date: " + $(Get-ChildItem $file.FullName | `
    Select-Object -ExpandProperty CreationTime | Get-Date -f "yyyy-MM-dd hh:mm")
    
    (Get-Content $file.FullName) | % {
    if ($_.ReadCount -eq 2 -and $_ -notmatch "Date:") { 
        $date
        $_
        Write-Host "Updating" $file $date
    } 
    else {
        $_
    }
  } | Set-Content $file.FullName
}
