#After you import the PSCX, use the Compare-Object cmdlet to compare the hashes of the c:\ref folder with the hashes of the c:\changed folder.
#The basic command to compute the hashes of the files in each folder was discussed in yesterday’s blog.
#The chief difference here is the addition of the Compare-Object cmdlet. The command (a single logical command) is shown here.
#you need to get the PowerShell Community Extensions (PSCX). The just released the 3.0 version of the cmdlets http://pscx.codeplex.com/

#variable for base folder
$basefolder = "c:\ref"
#Variable for new folder
$Newfolder = "c:\changed"

Compare-Object -ReferenceObject (dir $basefolder -Recurse | Where-Object {!$_.psiscontainer } | get-hash) -differenceObject (dir $Newfolder -Recurse | Where-Object {!$_.psiscontainer } | get-hash)

#Find the changed file
#Using the information from the previous command, I create a simple filter to return more information about the changed file. 
#The easy way to do this is to highlight the hash, and place it in a Where-Object command (the ? is an alias for Where-Object). 
#I know from yesterday’s blog, that the property containing the MD5 hash is called hashstring, and therefore, that is the property I look for. 
#The command is shown here.
##########
#                                                                                                        Insert MD5 here
dir $Newfolder -Recurse | Where-Object {!$_.psiscontainer } | get-hash | ? {$_.hashstring -match 'DE1278022BF9A1A6CB6AAC0E5BEE1C5B'}


##################################################################################
#Finding the differences in the files
#I use essentially the same commands to find the differences between the two files. First, 
#I make sure that I know the reference file that changed. Here is the command that I use for that:
########
PS C:\> dir $base -Recurse | Where-Object {!$_.psiscontainer } | get-hash | ? { $_.hashstring -match '32B72AF6C2FF057E7C63C715449BFB6A'}
########
#When I have ensured that it is, in fact, the a.txt file that has changed between the reference folder and the changed folder
#I again use the Compare-Object cmdlet to compare the content of the two files. Here is the command I use to compare the two files:
Compare-Object -ReferenceObject (Get-Content $basefolder\a.txt) -DifferenceObject(Get-Content $Newfolder\a.txt)
