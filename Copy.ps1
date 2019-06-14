$filelist = Get-ChildItem "D:\Movies" -Include @("*.JPG", "*.jpg") -recurse
$num = $filelist | measure
$filecount = $num.count
 
$i = 0;
ForEach ($file in $filelist)
{
    $i++;
    $oldfile = $file.DirectoryName + "\" + $file.BaseName + $file.Extension;
	
    $newfile = $file.DirectoryName + "\" + $file.BaseName + ".jpg";
	$newfile = $oldfile.Replace("D:\Movies","D:\Movies — copy");
      
    $progress = ($i / $filecount) * 100;
    $progress = [Math]::Round($progress,2);
 
    #Clear-Host;
    Write-Host -------------------------------------------------------------------------------;
    Write-Host Handbrake Batch Encoding;
    Write-Host "Processing - $oldfile";
    Write-Host "File $i of $filecount - $progress%";
    Write-Host -------------------------------------------------------------------------------;
    
	Copy-Item -Path $oldfile -Destination $newfile –Recurse
	
    ([system.io.fileinfo]$newfile).CreationTime = ([system.io.fileinfo]$oldfile).CreationTime;
    ([system.io.fileinfo]$newfile).LastAccessTime = ([system.io.fileinfo]$oldfile).LastAccessTime;
    ([system.io.fileinfo]$newfile).LastWriteTime = ([system.io.fileinfo]$oldfile).LastWriteTime;
}