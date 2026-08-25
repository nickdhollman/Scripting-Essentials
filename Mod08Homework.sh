#! /bin/bash

# write the header for the .csv file
echo "Date,Time,Priority,Classification,Description,Source IP,Destination IP" > ~/alert_data.csv

echo -e  "Processing the pcap file..."
while IFS= read -r line
do
	date_time=$(echo $line | cut -d ' ' -f1)
	date=$(echo $date_time | cut -d '-' -f1)
	time=$(echo $date_time | cut -d '-' -f2)
	time_adj=$(echo $time | cut -d ':' -f1,2)
	priority=$(echo $line | cut -d '[' -f6)
	priority_adj=$(echo $priority | cut -d ']' -f1)
	priority_adj=$(echo $priority_adj | tr -d ' ')
	priority_adj_b=$(echo $priority_adj | cut -d ':' -f2)
	classification_block=$(echo $line | cut -d '[' -f5)
	classification_trim=$(echo $classification_block | cut -d ']' -f1)
	classification=$(echo $classification_trim | cut -d ':' -f2)
	description=$(echo $line | cut -d ']' -f3)
	description_adj=$(echo $description | cut -d '[' -f1)
	ip_line=$(echo $line | tr '}' '|')
	ip_segment=$(echo $ip_line | cut -d '|' -f2)
	ip_segment=$(echo $ip_segment | tr -d ' ')
	source_ip=$(echo $ip_segment | cut -d '-' -f1)
	destination_ip=$(echo $ip_segment | cut -d '-' -f2)
	destination_ip_adj=$(echo $destination_ip | cut -d '>' -f2)
	#echo $date
	#echo $time_adj
	#echo $priority_adj_b
	#echo $classification
	#echo $description_adj
	#echo $source_ip
	#echo $destination_ip_adj
	echo "$date,$time_adj,$priority_adj_b,$classification,$description_adj,$source_ip,$destination_ip_adj" >> alert_data.csv
done < fast_short.pcap
clear
echo -e  "The pcap file has been processed\n"
