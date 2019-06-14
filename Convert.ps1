#partially, for now.
$filelist = Get-ChildItem "D:\Movies" -Include @("*.MTS", "*.mts") -recurse


#$filelist = Get-ChildItem "E:\Dysk Google\Pulpit\Test" -Include @("*.MTS", "*.mts", "*.avi", "*.AVI", "*.3gp") -recurse
#$filelist = Get-ChildItem "E:\Dysk Google\Pulpit\Test" -filter *.MTS -recurse
$num = $filelist | measure
$filecount = $num.count
 
$i = 0;
ForEach ($file in $filelist)
{
    $i++;
    $oldfile = $file.DirectoryName + "\" + $file.BaseName + $file.Extension;
    $newfile = $file.DirectoryName + "\" + $file.BaseName + ".mp4";
      
    $progress = ($i / $filecount) * 100;
    $progress = [Math]::Round($progress,2);
 
    Clear-Host;
    Write-Host -------------------------------------------------------------------------------;
    Write-Host Handbrake Batch Encoding;
    Write-Host "Processing - $oldfile";
    Write-Host "File $i of $filecount - $progress%";
    Write-Host -------------------------------------------------------------------------------;

    Start-Process "E:\Program Files\HandBrakeCLI\HandBrakeCLI.exe" -ArgumentList "-i `"$oldfile`" -t 1 -o `"$newfile`" -f mp4  -O  --quality 23.0 --deinterlace -e x264 --x264-preset=fast  --x264-tune=`"film`"  --h264-level=`"4.1`"  --verbose=0" -Wait -NoNewWindow;
    
    ([system.io.fileinfo]$newfile).CreationTime = ([system.io.fileinfo]$oldfile).CreationTime;
    ([system.io.fileinfo]$newfile).LastAccessTime = ([system.io.fileinfo]$oldfile).LastAccessTime;
    ([system.io.fileinfo]$newfile).LastWriteTime = ([system.io.fileinfo]$oldfile).LastWriteTime;

    Remove-Item -Path $oldfile;
}