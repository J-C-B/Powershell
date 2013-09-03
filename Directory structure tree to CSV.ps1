#get list with a md5 hash "get-hash"
#
Get-ChildItem -Recurse 'C:\test' *.docx | Where-Object {!$_.psiscontainer } | get-hash | Sort-Object -Descending | Export-csv foo1.csv
#
#######################################################################################
#
#Get list only (no MD5)
#
#Get-ChildItem -Recurse 'C:\test' *.* | Select-Object -Property PSParentPath,name,LastWriteTime | Export-Csv foo2.csv
