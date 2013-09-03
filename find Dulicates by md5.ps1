###############################
#Import-Module pscx
#Compare-Object -ReferenceObject (dir c:\ref -Recurse | Where-Object {!$_.psiscontainer } | get-hash) -differenceObject (dir c:\changed -Recurse | Where-Object {!$_.psiscontainer } | get-hash)
###############################

#$searchpath = "C;\test1"
#$savepath = "C;\test1\foo3.csv"
Get-ChildItem -Recurse|`
?{!$_.psiscontainer}|`
Select-Object PSParentPath,Name,CreationTime,LastWriteTime,Length,@{Name="MD5";Expression={Get-Hash $_.fullname}}|`
group MD5|?{$_.Count -gt 1}|%{$_.Group}|sort MD5|`
Export-Csv foo.csv #$savepath

<#Calculating MD5 hash. Applies for files ONLY.
 
function get-md5hash {[System.BitConverter]::ToString((new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider).ComputeHash([System.IO.File]::ReadAllBytes($args)))}
 
Getting list of files: Get-ChildItem $searchpath –Recurse
 
Excluding containers: ?{!$_.psiscontainer}
 
Select needful file properties for output:Select-Object Name,Fullname,CreationTime,LastWriteTime,Length,@{Name="MD5";Expression={Get-md5hash $_.fullname}}
 
Adding custom file property using calculated properties: @{Name="MD5";Expression={Get-md5hash $_.fullname}}
 
Grouping results by MD5 hash: group MD5
 
Finding duplicates: ?{$_.Count -gt 1}|%{$_.Group}
 
Sorting files by MD5 hash: sort MD5
 
#Exporting to .csv file in Unicode format: Export-Csv $savepath -NoTypeInformation -Encoding "Unicode"
 
Full script:#>
