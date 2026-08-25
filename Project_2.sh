#! /bin/sh

# Nick Hollman
# Project 2

clear

# DECLARE VARIABLES
PROJECT_FILE=recall.rdf
HOME_DIR=~
MAIN_DIR=$HOME_DIR/Project2
ARCHIVE=$MAIN_DIR/Archive
PROCESSING=$MAIN_DIR/Processing
REPORTS=$MAIN_DIR/Reports
CSV_FILE=parsed_recall_data.csv
ZIP_FILE=components.tar

MANUFACTURERS=("Hyundai" "Ford" "Nissan" "Kia" "BMW" "Volvo" "Honda" "Toyota")
#echo ${MANUFACTURERS[*]}

# MOVE TO HOME DIRECTORY
cd $HOME_DIR

###### SETUP FUNCTION #######
function setup {
	# check if file exists, if not exit
	if ! [[ -f $PROJECT_FILE ]]; then
		echo
		read -p "The file $PROJECT_FILE must be on the home directory. Press enter to exit: "
		exit
	fi

	# remove main if it already exists
	if [[ -d $MAIN_DIR ]]; then
		rm -r "$MAIN_DIR"
	fi

	# create main directory
	mkdir $MAIN_DIR
	mkdir $ARCHIVE
	mkdir $PROCESSING
	mkdir $REPORTS

	#copy the file into processing
	cp $PROJECT_FILE $PROCESSING
}
##### CSV CREATION FUNCTION #####
function create_csv {
cd $PROCESSING
# create line counter to skip two lines
line_counter=0
# create headers
header="Date,NHTSA ID,Manufacturer,Subject,Component,Campaign Number,Recall Type,Defect Summary"
echo $header > $CSV_FILE
# create if loop to read file, and create variables to write out
while IFS= read -r line
do
	# user counter to skip first two lines, continue after first two lines
	line_counter=$((line_counter + 1))
	if [[ $line_counter -le 2 ]]; then
		continue
	fi
	# create variables in format descired using cut -d
	# replace commas with | to ensure values for variables are not stored in separate cells
	if [[ $line == *"<ds:report_received_date>"* ]]; then
		date=$(echo $line | cut -d ">" -f2)
		date=$(echo $date | cut -d "<" -f1)
		date=$(echo $date | cut -d "T" -f1)
		date=$(echo $date | tr "," "|")
		#echo $date
	elif [[ $line == *"<ds:nhtsa_id>"* ]]; then
		nhtsa_id=$(echo $line | cut -d "<" -f2)
		nhtsa_id=$(echo $nhtsa_id | cut -d ">" -f2)
		nhtsa_id=$(echo $nhtsa_id | tr "," "|")
		#echo $nhtsa_id
	elif [[ $line == *"<ds:manufacturer>"* ]]; then
		manufacturer=$(echo $line | cut -d "<" -f2)
		manufacturer=$(echo $manufacturer | cut -d ">" -f2)
		manufacturer=$(echo $manufacturer | tr "," "|")
		#echo $manufacturer
	elif [[ $line == *"<ds:subject>"* ]]; then
		subject=$(echo $line | cut -d "<" -f2)
		subject=$(echo $subject | cut -d ">" -f2)
		subject=$(echo $subject | tr "," "|")
		#echo $subject
	elif [[ $line == *"<ds:component>"* ]]; then
		component=$(echo $line | cut -d "<" -f2)
		component=$(echo $component | cut -d ">" -f2)
	#deal with special case for component based on what was given in instructions
		part1=$(echo $component | cut -d "," -f1)
		part2=$(echo $component | cut -d "," -f2)
		if [ "$part1" != "$part2" ];then
			component="$part1 AND $part2"
		else
			component="$part1"
		fi
		#echo $component
	elif [[ $line == *"ds:mfr_campaign_number>"* ]]; then
		campnum=$(echo $line | cut -d "<" -f2)
		campnum=$(echo $campnum | cut -d ">" -f2)
		campnum=$(echo $campnum | tr "," "|")
		#echo $campnum
	elif [[ $line == *"ds:recall_type"* ]]; then
		recall_type=$(echo $line | cut -d "<" -f2)
		recall_type=$(echo $recall_type | cut -d ">" -f2)
		recall_type=$(echo $recall_type | tr "," "|")
		#echo $recall_type
	elif [[ $line == *"ds:defect_summary"* ]]; then
		summary=$(echo $line | cut -d "<" -f2)
		summary=$(echo $summary | cut -d ">" -f2)
		summary=$(echo $summary| tr "," "|")
		#echo $summary
	#dsbase is the signal the record is complete so when this is found write out the line
	elif [[ $line == *"<dsbase:"* ]]; then
		line_out="$date,$nhtsa_id,$manufacturer,$subject,$component,$campnum,$recall_type,$summary"
		echo $line_out >> $CSV_FILE
	#set the variables as NR (Not Reported) if nothing is found for the output so store empty as below
	date="NR (Not Reported)"
	nhtsa_id="NR (Not Reported)"
	manufacturer="NR (Not Reported)"
	subject="NR (Not Reported)"
	component="NR (Not Reported)"
	campnum="NR (Not Reported)"
	recall_type="NR (Not Reported)"
	summary="NR (Not Reported)"
	fi
done < $PROJECT_FILE
# do one last echo to write out the #501 line to csv
echo "$date,$nhtsa_id,$manufacturer,$subject,$component,$campnum,$recall_type,$summary" >> $CSV_FILE
cp $PROJECT_FILE $ARCHIVE
}
#### SCREEN REPORT ######
function screen_report {
clear
echo -e "RANK\tMANUFACTURER (INCIDENT COUNT)"
echo -e "----\t-----------------------------"
cd $PROCESSING
# clear incident array so it can be ran multiple times without duplication
incident_array=()
#for each item in MANUFACTURER array
for i in ${MANUFACTURERS[*]}
do
	#reset count for each manufacturer
	incident_count=0
	#read through each line in the CSV FILE
	while IFS= read -r line
	do
		#extract the manufacturer column
		manufacturer=$(echo $line | cut -d "," -f3)
		#skip the first row
		if [[ $manufacturer == "Manufacturer" ]]; then
			continue
		fi
		#if manufacturer name in list is contained in raw value
		if [[ $manufacturer == *"$i"* ]]; then
			#store raw manufacturer values
			mfg=$manufacturer
			#then add 1 to the count value
			incident_count=$(($incident_count + 1))
		fi
	done < $CSV_FILE
	#store incident_count with raw values
	#replace spaces in original labels with _
	mfg=$(echo $mfg | tr " " "_")
	incident_array+=($incident_count\|$mfg)
done
# sort array created above by incident_count
incident_array=($(
	for i in ${incident_array[*]};
	do
		echo $i
	done | sort -rn
))
# start rank at 1 so the first rank is 1
rank=1
for i in ${incident_array[*]}
do
	# get count from item in array
	incident_count=$(echo $i | cut -d "|" -f1)
	# get label from item in array
	manufacturer=$(echo $i | cut -d "|" -f2-)
	# replace | with ,
	manufacturer=$(echo $manufacturer | tr "|" ",")
	# replace _ with spaces
	manufacturer=$(echo $manufacturer | tr "_" " ")
	# replace &amp with &
	manufacturer=$(echo $manufacturer | sed 's/\&amp;/\&/g')
	echo -e " #$rank\t$manufacturer ($incident_count)"
	rank=$(($rank + 1))
done
echo
read -p "Press Enter to return to the menu: "
clear
}
#### FILES BY COMPONENT #######
function files_by_component {
clear
#navigate to reports, if zipped file and function has already been done
#give user notification that it has been done and runs only once
cd $REPORTS
filecheck="$REPORTS/$ZIP_FILE"
if [[ -f $filecheck ]];then
	echo "This process has completed and only runs once"
	read
	clear
	return
fi
cd $PROCESSING
components_list=()
# create the files for each component
while IFS= read -r line
do
	# retrieve component column
	component=$(echo $line | cut -d "," -f5)
	# skip first line of column
	if [[ $component != "Component" ]]; then
		# tr spaces to _
		component=$(echo $component | tr " " "_")
		# tr / to _
		component=$(echo $component | tr "/" "_")
		# create a list from the components in the csv
		components_list+=($component)
	fi
done < $CSV_FILE
#get unique components list
components_list=($(
	for i in ${components_list[*]};
	do
		echo $i
	done | sort -u))
#write the data for each component from list above
for i in ${components_list[*]}
do
	file_component=$(echo $i | tr "_" " ")
	cd $REPORTS
	# write header for each file
	echo "Date,NHTSA ID,Manufacturer,Subject,Component,Campaign Number,Recall Type,Defect Summary" > "$file_component.csv"
	cd $PROCESSING
	while IFS= read -r line
	do
		component=$(echo $line | cut -d "," -f5)
		if [[ $component == "Component" ]];then
			continue
		fi
		component=$(echo $component | tr " " "_")
		component=$(echo $component | tr "/" "_")
		#if the line has the component write it out to the component file
		if [[ $component == $i ]];then
			echo $line >> "$REPORTS/$file_component.csv"
		fi
	done < $CSV_FILE
done
cd $REPORTS
#create zipped file
tar -cf $ZIP_FILE *csv
mouse=$(wc -c < $ZIP_FILE)
echo
echo "Report files have been archived into $ZIP_FILE. Size: $mouse bytes"
# remove csv files that have now been zipped
rm *.csv
echo
read -p "Press Enter to return to the menu: "
clear
}
#### RUN SETUP #####
setup
create_csv

#### MENU ########
while true;
do
#clear
echo "
Recall Notification Menu

Please select from the following options:

    1. Manufacturer Reports
    2. Create Files by Component
    3. Exit
"
read -p "Option #: " user_choice
if [[ $user_choice -eq 1 ]]; then
   screen_report
elif [[ $user_choice -eq 2 ]]; then
   files_by_component
elif [[ $user_choice -eq 3 ]]; then
    break
else
   echo
   read -p "That is not a valid option. Press Enter to continue: "
   clear
fi
done
