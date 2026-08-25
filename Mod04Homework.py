# Nick Hollman
# Mod 04 Homework

# import packages
import os, getpass

# Set working directory to desktop
the_desktop = os.path.join('C:\\Users',getpass.getuser(),'Desktop')
os.chdir(the_desktop)

# Write csv file with headers
# in example output date and time are separate columns so that is what I went with below
with open('alert_data.csv', 'w') as f: # w = write
    f.write('Date,Time,Priority,Classification,Description,Source IP,Destination IP\n')


# open pcap file to read, append to csv file
# split removes (consumes) the delimiter in a string and creates a list of what is between the delimiters
# we can index or slice using [starting index(included):stopping index(excluded)] to trim down the results we want
with open('fast_short.pcap', 'r') as f: #r = read
    for line in f:
        split1 = line.split('[**]')
        date_time = split1[0] #date/time
        attack_date = date_time[:5] #date
        attack_time = date_time[6:11] #time
        split2 = split1[1].split(']')
        description = split2[1].strip() #description
        split3 = split1[2].split('] [')
        classification = split3[0]
        classification = classification.strip('[')
        classification = classification[18:] 
        classification.strip() #classification
        split4 = split3[1]
        priority = split4[10:11] #priority
        split5 = split3[1].split('->')
        dest_ip = split5[1]
        destination_ip = dest_ip.strip() #destination IP
        source_ip = split5[0]
        source_ip = source_ip[19:] 
        source_ip = source_ip.strip() #source IP
        with open('alert_data.csv', 'a') as f: # a = append
            f.write(attack_date + ',' +
                    attack_time + ',' +
                    priority + ',' +
                    classification + ',' +
                    description + ',' +
                    source_ip + ',' +
                    destination_ip + '\n')

print()
input()










