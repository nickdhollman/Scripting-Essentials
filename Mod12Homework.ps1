# Nick Hollman
# Homework 12

# Make a path to the current user desktop
$user_path = "C:\Users\" + $env:UserName + "\Desktop\"
Set-Location $user_path

# Write out headers Date,Time,Priority,Classification,Description,Source IP, Destination IP to file name alert_data.csv
Write-Output ("Date,Time,Priority,Classification,Description,Source IP, Destination IP") | Out-File "alert_data.csv" -Encoding ascii

# Read the file fast_short.pcap line by line and extract the correct data for each column. Write the data back to alert_data.csv
$file = ".\fast_short.pcap"
foreach ($line in Get-Content $file)
{
    # process file to get desired output
    # use this for help - $dog = $line.split(":",[System.StringSplitOptions]::RemoveEmptyEntries)
    $Date = $line.Substring(0,5)
    $Time = $line.Substring(6,5)
    $Split1 = $line.split("[")[5]
    $Priority = $Split1.Substring(10,1).Split(" ")
    $Split2 = $line.split("[")[4]
    $Split3 = $Split2.split("]")[0]
    $Classification = $Split3.split(":")[1].trim(" ")
    $Split5 = $line.split("]")[2]
    $Description = $Split5.split("[")[0].trim(" ")
    $Split6 = $line.split(">")[0]
    $Split7 = $Split6.split("}")[1]
    $Source_IP = $Split7.split("-")[0].trim(" ")
    $Dest_IP = $line.split(">")[1].trim(" ")
    Write-Output ($Date + "," + $Time + "," + $Priority + "," + $Classification + "," + $Description + "," +
    $Source_IP + "," + $Dest_IP) | out-file "alert_data.csv" -Encoding ascii -Append
}

# Write host output after processing is done
Write-Host "`r`nProcessing is done. Press enter to close the script"
Read-Host