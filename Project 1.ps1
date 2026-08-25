# Nick Hollman
# Project 3

# Static Variables
$PROJECT_FILE = "recall.rdf"
$MAIN_DIRECTORY = "Project 1"
$ARCHIVE = $MAIN_DIRECTORY + "\Archive"
$PROCESSING = $MAIN_DIRECTORY + "\Processing"
$REPORTS = $MAIN_DIRECTORY + "\Reports"
$ZIP_FILE = "components.zip"
$MANUFACTURERS = @("Hyundai","Ford","Nissan","Kia","BMW","Volvo","Honda","Toyota")
$CSV_FILE = "parsed_recall_data.csv"

# Move to the user desktop
$user_path = "C:\Users\" + $env:UserName + "\Desktop\"
Set-Location $user_path

# Setup function
function setup()
{
    # check for the project file on the desktop
    if(-Not (Test-Path $PROJECT_FILE))
    {
        Write-Host "Project file not found on the desktop."
        return
    }

    # remove the project 1 directory from the desktop if it exists
    if(Test-Path $MAIN_DIRECTORY)
    {
        rm -r $MAIN_DIRECTORY
    }

    # make the project directories
    mkdir $MAIN_DIRECTORY | Out-Null
    mkdir $ARCHIVE | Out-Null
    mkdir $PROCESSING | Out-Null
    mkdir $REPORTS | Out-Null

    # move the project file into the processing folder (cp bash command)
    cp $PROJECT_FILE $PROCESSING
}
#setup

#csv_creation
function csv_creation 
{
    #move to the processing file
    Set-Location $PROCESSING

    #initialize the default values for each variable
    $date = "<ds:report_received_date>NR (Not Reported)</ds:report_received_date>"
    $nhtsa_id = "<ds:nhtsa_id>NR (Not Reported)</ds:nhtsa_id>"
    $manufacturer = "<ds:manufacturer>NR (Not Reported)</ds:manufacturer>"
    $subject = "<ds:subject>NR (Not Reported)</ds:subject>"
    $component = "<ds:component>NR (Not Reported)</ds:component>"
    $campaign_number = "<ds:mfr_campaign_number>NR (Not Reported)<ds:mfr_campaign_number>"
    $recall_type = "<ds:recall_type>NR (Not Reported)</ds:recall_type>"
    $defect_summary = "<ds:defect_summary>NR (Not Reported)<ds:defect_summary>"

    #initialize recall array to store piped variables
    $recall_array = @()

    #open the project file for read
    foreach ($line in Get-Content $PROJECT_FILE)
    {
        #skip the first two lines
        if ($line.ReadCount -eq 1)
        {
            continue
        }
        if ($line.ReadCount -eq 2)
        {
            continue
        }
        #pull out variables we want, trim and store as variables
        if ($line.Contains("<ds:report_received_date>"))
        {
            $date = $line.trim(" ")
        }
        elseif ($line.Contains("<ds:nhtsa_id>"))
        {
            $nhtsa_id = $line.trim(" ")
        }
        elseif ($line.Contains("<ds:manufacturer>"))
        {
            $manufacturer = $line.trim(" ")
        }
        elseif ($line.Contains("<ds:subject>"))
        {
            $subject = $line.trim(" ")
        }
        elseif ($line.Contains("<ds:component>"))
        {
            $component = $line.trim(" ")
        }
        elseif ($line.Contains("<ds:mfr_campaign_number>"))
        {
            $campaign_number = $line.trim(" ")
        }
        elseif ($line.Contains("<ds:recall_type>"))
        {
            $recall_type = $line.trim(" ")
        }
        elseif ($line.Contains("<ds:defect_summary>"))
        {
            $defect_summary = $line.trim(" ")
        }
        #last elseif looks for <dsbase and when this happense combine all data above separated by |
        elseif ($line.Contains("<dsbase:"))
        {
            $output = $date + "|" +
            $nhtsa_id + "|" +
            $manufacturer + "|" +
            $subject + "|" +
            $component + "|" +
            $campaign_number + "|" +
            $recall_type + "|" +
            $defect_summary

            #add output above to recall_array
            $recall_array += $output

            #reset varaibles to default values
            $date = "<ds:report_received_date>NR (Not Reported)</ds:report_received_date>"
            $nhtsa_id = "<ds:nhtsa_id>NR (Not Reported)</ds:nhtsa_id>"
            $manufacturer = "<ds:manufacturer>NR (Not Reported)</ds:manufacturer>"
            $subject = "<ds:subject>NR (Not Reported)</ds:subject>"
            $component = "<ds:component>NR (Not Reported)</ds:component>"
            $campaign_number = "<ds:mfr_campaign_number>NR (Not Reported)<ds:mfr_campaign_number>"
            $recall_type = "<ds:recall_type>NR (Not Reported)</ds:recall_type>"
            $summary = "<ds:defect_summary>NR (Not Reported)<ds:defect_summary>"
            }
    }

    #append final entry/record because above does not capture the final record
    $output = $date + "|" +
            $nhtsa_id + "|" +
            $manufacturer + "|" +
            $subject + "|" +
            $component + "|" +
            $campaign_number + "|" +
            $recall_type + "|" +
            $defect_summary

    $recall_array += $output

    #Write CSV header
    Write-Output ("Date,NHTSA ID,Manufacturer,Subject,Component,Campaign Number,Recall Type,Summary") | Out-File $CSV_FILE -Encoding ascii

    #now loop through the recall list to retrieve the itmes we want to append for the csv
    foreach ($line in $recall_array)
    {
        #split by the delimiter we used above
        $recall_item = $line.Split("|")
        #extract all desired items
        #date
        $date = $recall_item[0]
        $date = $date.split(">")[1]
        $date = $date.split("T")[0]
        #Write-Host $date
        #nhtsa_id
        $nhtsa_id = $recall_item[1]
        $nhtsa_id = $nhtsa_id.split(">")[1]
        $nhtsa_id = $nhtsa_id.split("<")[0]
        #Write-Host $nhtsa_id
        #manufacturer
        $manufacturer = $recall_item[2]
        $manufacturer = $manufacturer.split(">")[1]
        $manufacturer = $manufacturer.split("<")[0]
        $manufacturer = $manufacturer.Replace(",", "|")
        #Write-Host $manufacturer
        #subject
        $subject = $recall_item[3]
        $subject = $subject.split(">")[1]
        $subject = $subject.split("<")[0]
        $subject = $subject.Replace(",", "|")
        #Write-Host $subject
        #component
        $component = $recall_item[4]
        $component = $component.split(">")[1]
        $component = $component.split("<")[0]
        $component = $component.Replace(",", " AND")
        #Write-Host $component
        #campaign_number
        $campaign_number = $recall_item[5]
        $campaign_number = $campaign_number.split(">")[1]
        $campaign_number = $campaign_number.split("<")[0]
        $campaign_number = $campaign_number.Replace(",", "|")
        #Write-Host $campaign_number
        #recall_type
        $recall_type = $recall_item[6]
        $recall_type = $recall_type.split(">")[1]
        $recall_type = $recall_type.split("<")[0]
        #Write-Host $recall_type
        #summary
        $defect_summary = $recall_item[7]
        $defect_summary = $defect_summary.split(">")[1]
        $defect_summary = $defect_summary.split("<")[0]
        $defect_summary = $defect_summary.Replace(",", "|")
        #Write-Host $defect_summary
        
        #write varaibles in format above to csv
        Write-Output ($date + "," + $nhtsa_id + "," + $manufacturer + "," + $subject + "," + $component + "," +
    $campaign_number + "," + $recall_type + "," + $defect_summary) | out-file $CSV_FILE -Encoding ascii -Append
    }
        #move project file from processing to archive
        Set-Location $user_path
        mv ($PROCESSING + "\" + $PROJECT_FILE) $ARCHIVE
}
#csv_creation

function screen_report {
    #clear the sreen
    cls

    #move to the PROCESSING directory
    Set-Location $user_path
    Set-Location $PROCESSING

    #initialize the incident array
    $incident_array = @()

    #for i in MANUFACTURERS, open csv file for reach, skip line one, iterate through and count the recalls per manufacturer
    foreach ($i in $MANUFACTURERS)
    {
        #set a counter for the number of incidents to zero
        $incident_total = 0
        $manufacturer = $i

        #for each line in CSV file
        foreach($line in Get-Content $CSV_FILE)
        {
            #skip header
            if ($line.ReadCount -eq 1)
            {
                continue
            }
            #if line contains the manufacturer add it to the list
            if ($line.Contains($i))
            {
                #first retreive the item by splitting csv on comma delimiter
                $csv_item = $line.split(",")
                #get manufacturer as the third column in the csv
                $manufacturer = $csv_item[2]
                #add one to the counter
                $incident_total = $incident_total + 1
            }
        }
        #add incident_total and manufacturer together as array of array
        $temp_array = @($incident_total, $manufacturer)
        #use method covered in lecture 1 of mod 12 $j += ,$a to add array a ($temp_array) to array j ($incident_array)
        $incident_array += ,$temp_array
    }
    #sort descending using method Dr. Burkman mentioned in discussion
    $incident_array = $incident_array | Sort-Object {[int]$_[0]} -Descending
    #Write-Host $incident_array

    #header - attempted to use t for tab similar to project 1 python tip and it seemed to work, instead of using \t used `t
    Write-Host "RANK   INCIDENT COUNT`tMANUFACTURER"
    Write-Host "----   --------------`t------------"

    #initialize rank with rank=1 (start with 1 because we want the first rank as 1 not 0)
    $rank = 1

    #iterate through each section in $incident_array created above
    foreach ($i in $incident_array)
    {
        #extract count from the $incident_array
        $incident_total = $i[0] 
        # manufacturer
        $manufacturer = $i[1]

        #transform manufacturer into format desired
        $manufacturer = $manufacturer.Replace("|", ",")
        $manufacturer = $manufacturer.Replace("&amp;", "&")
        Write-Host (" #" + $rank + "          " + $incident_total + "`t`t" + $manufacturer)
        #incriment rank by 1 for next manufacturer
        $rank = $rank + 1

    }
    Write-Host "`r`nPress Enter to return to the menu"
    Read-Host
}
#screen_report

function files_by_component {
    #clear screen
    cls

    #move to the desktop, then processing
    Set-Location $user_path
    Set-Location $PROCESSING

    #initialize components and unique components arrays
    $components = @()
    $unique_components = @()

    #read CSV and collect components
    foreach ($line in Get-Content $CSV_FILE)
    {
        #skip header
        if ($line.ReadCount -eq 1)
        {
            continue
        }
        $csv_item = $line.Split(",")
        # component is 4th column in the csv file
        $components += $csv_item[4]
    }
    # make unique components list
    foreach ($i in $components)
    {
        if (-Not $unique_components.Contains($i))
        {
            $unique_components += $i
        }
    }
    #Write-Host $unique_components
    # for x in the list of unique components
    foreach ($x in $unique_components)
    {
        # initialize bob
        $bob = @()

        #move to desktop
        Set-Location $user_path
        #move to processing
        Set-Location $PROCESSING

        #open CSV file for read
        foreach ($line in Get-Content $CSV_FILE)
        {
            #skip header
            if ($line.ReadCount -eq 1)
            {
                continue
            }

            #for each line, split on comma, if x equals 4 then append the whole line to a new list (call this bob)
            $csv_item = $line.split(",")
            if ($x -eq $csv_item[4])
            {
                $bob += $line
            }
        }
        #move to desktop
        Set-Location $user_path

        #move to reports
        Set-Location $REPORTS

        #out file name - but first replace / with AND
        $file_name = $x 
        $file_name = $file_name.Replace("/", " AND ")
        $out_file = $file_name + ".csv"

        #write header for output files
        Write-Output ("Date,NHTSA ID,Manufacturer,Subject,Component,Campaign Number,Recall Type,Summary") | Out-File $out_file -Encoding ascii

        #for y in the list we called Bob:
        foreach ($y in $bob)
        {
        #make y a string
        $y = "$y"
        #for y, replace single quotes with nothing
        $y = $y.Replace("'", "")
        #for y, replace â€ with nothing - idk if this is needed, may have just been needed in Python project
        $y = $y.Replace("â€", "")
        #write y
        Write-Output $y | out-file $out_file -Encoding ascii -Append
        }
    }
    # start zip file process
    # assign current directory to a variable
    $file_list = dir
    # initialize array to store all csv file names
    $file_name = @()

    #for x in the file_list variable
    foreach ($x in $file_list)
    {
        #ensure $x is a string
        $name = "$x"
        #make x title case
        if ($name.Contains(".csv"))
        {
        $new_name = (Get-Culture).TextInfo.ToTitleCase($name.ToLower())
        #replace Csv with csv
        $new_name = $new_name.Replace("Csv","csv")
        #replace Esc with ESC
        $new_name = $new_name.Replace("Esc","ESC")
        #replace And with and
        $new_name = $new_name.Replace("And","and")
        #us mv bash command to rename the file if name ne new_name
        if ($name -ne $new_name)
        {
            mv $name $new_name
        }
        #add file names to paths array
        $file_name += ".\" + $new_name
        }
    }

    #zip file
    $my_zip = @{
        Path = $file_name
        CompressionLevel = "Fastest"
        DestinationPath = ".\" + $ZIP_FILE
    }

    Compress-Archive @my_zip -Force

    Write-Host ("`r`nReport files have been zipped into " + $ZIP_FILE)

    #remove the csv files
    $file_list = dir

    #iterate through files in directory
    foreach ($x in $file_list)
    {
        #conver $x in file name in current directory to string $name
        $name = "$x"
        #assign last 3 characters to a varaible
        $csv = $name.Substring($name.Length - 3,3)
        # if file extension = csv then remove
        if ($csv -eq "csv")
        {
            rm $name
        }
    }
    Read-Host "`r`nPress Enter to return to the menu"
}
#files_by_component

#Call the setup function and create csv
setup

csv_creation

#menu loop
while ($true)
{

cls

Write-Host("
Recall Notification Menu

Please select from the following options:
    
    1. Manufacturer Reports
    2. Create Files by Component
    3. Exit
")

    $user_menu_choice = Read-Host "Option #"

    if ($user_menu_choice -eq 1)
    {
        screen_report
    }
    elseif ($user_menu_choice -eq 2)
    {
        files_by_component
    }
    elseif ($user_menu_choice -eq 3)
    {
        cls
        break
    }
    else
    {
        Write-Host "`r`nThat is not a valid selection. Press Enter to continue"
        Read-Host
    }
}

