# Nick Hollman
# Module 5 Project

# imports
import shutil, zipfile, random, sys, os, getpass

# I used consequency summary as the header label and the defect summary as the data to match what was in the output Dr. Burkman showed
# in practice I would just change all the 'w' sections to write the header using defect summary to match the data

# static variables
PROJECT_FILE = 'recall.rdf'
MAIN_DIRECTORY = 'Project 1'
ARCHIVE = 'Project 1\\Archive'
PROCESSING = 'Project 1\\Processing'
REPORTS = 'Project 1\\Reports'
ZIP_FILE = 'components.zip'
MANUFACTURERS = ('Hyundai', 'Ford', 'Nissan', 'Kia', 'BMW', 'Volvo', 'Honda', 'Toyota')
CSV_FILE = 'parsed_recall_data.csv'
zip_file = 'components.zip'

# declarations
# Initialize any lists you need here
recall_notices = []
incident_list = []
components_list = []
unique_components_list = []

# move to user desktop
the_desktop = os.path.join('C:\\Users',getpass.getuser(),'Desktop')
os.chdir(the_desktop)

# setup function
# checks for the project file and makes the necessary folders
def setup():
    #check for the project file on the desktop
    if os.path.isfile(PROJECT_FILE) is True:
        #print('File exists')
        #remove the Project 1 directory from the desktop if it exists
        if os.path.isdir(MAIN_DIRECTORY) is True:
            shutil.rmtree(MAIN_DIRECTORY)
        #make the project directories
        if not os.path.exists(MAIN_DIRECTORY):
            os.mkdir(MAIN_DIRECTORY)
            os.mkdir(os.path.join(the_desktop, PROCESSING))
            os.mkdir(os.path.join(the_desktop, ARCHIVE))
            os.mkdir(os.path.join(the_desktop, REPORTS))
            #move the project file into the processing folder (NOTE: I suggest copying it to the folder until you are all done)
            shutil.copy(PROJECT_FILE, PROCESSING)

# make the .csv file
# this function opens the rdf file and tears it apart
# first we get the hole line for each variable we want
# when we hit th3 <dbase line we join all those variables together with piples and append that string (with \n at the end) to a list)
def csv_creation():
    #move to the processing folder
    os.chdir(os.path.join(the_desktop, PROCESSING))

    #open the project file for read (NOTE: we will add a keyword. Your code must be like this: "with open (PROJECT_FILE, 'r', errors='ignore') as whatever
    with open(PROJECT_FILE, 'r', errors='ignore') as f: #r = read
        #skip the next two lines
        next(f)
        next(f)
        for line in f:
            if '<ds:report_received_date>' in line:
                date = line.strip()
            elif '<ds:nhtsa_id>' in line:
                nhtsa = line.strip()
            elif '<ds:manufacturer>' in line:
                manufacturer = line.strip()
            elif '<ds:subject>' in line:
                subject = line.strip()
            elif '<ds:component>' in line:
                component = line.strip()
            elif '<ds:mfr_campaign_number>' in line:
                campaign_number = line.strip()
            elif '<ds:recall_type>' in line:
                recall_type = line.strip()
            elif '<ds:defect_summary>' in line:
                defect_summary = line.strip()
            elif '<dsbase:' in line:
                joined_recall = '|'.join([date,nhtsa,manufacturer,subject,component,campaign_number,recall_type,defect_summary])
                recall_notices.append(joined_recall)
                date = '<ds:report_received_date>NR (Not Reported)</ds:report_received_date>\n'
                nhtsa = '<ds:nhtsa_id>NR (Not Reported)</ds:nhtsa_id>\n'
                manufacturer = '<ds:manufacturer>NR (Not Reported)</ds:manufacturer>\n'
                subject = '<ds:subject>NR (Not Reported)</ds:subject>\n'
                component = '<ds:report_received_date>NR (Not Reported)</ds:report_received_date>\n'
                campaign_number = '<ds:mfr_campaign_number>NR (Not Reported)</ds:mfr_campaign_number>\n'
                recall_type = '<ds:recall_type>NR (Not Reported)</ds:recall_type>\n'
                defect_summary = '<ds:defect_summary>NR (Not Reported)</ds:defect_summary>\n'
            else:
                continue

    # Write csv file with headers
    with open(CSV_FILE, 'w') as f: # w = write
        f.write('Date,NHTSA ID,Manufacturer,Subject,Component,Campaign Number,Recall Type,Consequence Summary\n')
        for line in recall_notices:
            csv_item = line.split('|')
            date = csv_item[0]
            date_split1 = date.split('>')
            date_split2 = date_split1[1]
            date_split2 = date_split2.split('<')
            date_split2 = date_split2[0].strip()
            date_f = date_split2[0:10]
            date = date_f[5:7] + '/' + date_f[8:10] + '/' + date_f[0:4]
            #print(date_split2)
            #break
            #print(date_f)
            nhtsa = csv_item[1]
            nhtsa_split1 = nhtsa.split('>')
            nhtsa_split2 = nhtsa_split1[1]
            nhtsa_split2 = nhtsa_split2.split('<')
            nhtsa_split2 = nhtsa_split2[0].strip()
            nhtsa = nhtsa_split2.replace(',','|')
            #print(nhtsa)
            manufacturer = csv_item[2]
            manufacturer_split1 = manufacturer.split('>')
            manufacturer_split2 = manufacturer_split1[1]
            manufacturer_split2 = manufacturer_split2.split('<')
            manufacturer_split2 = manufacturer_split2[0].strip()
            manufacturer = manufacturer_split2.replace(',','|')
            #print(manufacturer)
            subject = csv_item[3]
            subject_split1 = subject.split('>')
            subject_split2 = subject_split1[1]
            subject_split2 = subject_split2.split('<')
            subject_split2 = subject_split2[0].strip()
            subject = subject_split2.replace(',','|')
            #print(subject)
            component = csv_item[4]
            component_split1 = component.split('>')
            component_split2 = component_split1[1]
            component_split2 = component_split2.split('<')
            component_split2 = component_split2[0].strip()
            component_split2 = component_split2.replace(',',' AND') # to match Dr. Burkman output 
            component_split2 = component_split2.replace('/',' AND ') # to match Dr. Burkman output
            component = component_split2.replace(',','|')
            #print(component)
            campaign_number = csv_item[5]
            campaign_number_split1 = campaign_number.split('>')
            campaign_number_split2 = campaign_number_split1[1]
            campaign_number_split2 = campaign_number_split2.split('<')
            campaign_number_split2 = campaign_number_split2[0].strip()
            campaign_number = campaign_number_split2.replace(',','|')
            #print(campaign_number)
            recall_type = csv_item[6]
            recall_type_split1 = recall_type.split('>')
            recall_type_split2 = recall_type_split1[1]
            recall_type_split2 = recall_type_split2.split('<')
            recall_type_split2 = recall_type_split2[0].strip()
            recall_type = recall_type_split2.replace(',','|')
            #print(recall_type)
            defect_summary = csv_item[7]
            defect_summary_split1 = defect_summary.split('>')
            defect_summary_split2 = defect_summary_split1[1]
            defect_summary_split2 = defect_summary_split2.split('<')
            defect_summary_split2 = defect_summary_split2[0].strip()
            defect_summary = defect_summary_split2.replace(',','|')
            #print(defect_summary)
            with open(CSV_FILE, 'a') as file: #a = append
                f.write(date + ',' 
                           + nhtsa + ','
                           + manufacturer + ','
                           + subject + ','
                           + component + ','
                           + campaign_number + ','
                           + recall_type + ','
                           + defect_summary + '\n')
                    # I didn't use what was given below because it resulted in the entire summary being surrounded by quotes which was not shown in the output
                           #+ '\"'+ defect_summary_f + '\"' + '\n')

    # move to the desktop. Use join and move the project file from the processing to archive
    os.chdir(the_desktop)
    shutil.move(os.path.join(PROCESSING, PROJECT_FILE), os.path.join(the_desktop, ARCHIVE))

def screen_report():
    # clear the screen
    os.system('cls')
    print('RANK'.center(4) + '\tMANUFACTURER'.ljust(45) + 'INCIDENT COUNT'.center(14))
    os.chdir(os.path.join(the_desktop, PROCESSING))
    print('-' * 4 + ' ' * 4 + '-' * 12 + ' ' * 32 + '-' * 14)

    counter = 0
    # count incident occurrence for each manufacturer 
    for i in MANUFACTURERS:
        with open(CSV_FILE, 'r', errors='ignore') as f: # r = read
            next(f)
            for line in f:
                if i in line:
                #print(line)
                    line_split = line.split(',')
                    manufacturer = line_split[2]
                    counter += 1
        incident_list.append([counter, manufacturer])
        counter = 0
    incident_list.sort(reverse=True)
    # create user friendly print out to match header 
    for i in range(len(incident_list)):
        MANUFACTURER = incident_list[i][1]
        INCIDENT_COUNT = incident_list[i][0]
        MANUFACTURER = MANUFACTURER.replace('|', ',')
        MANUFACTURER = MANUFACTURER.replace('&amp; ','')
        RANK = i + 1
        print(' #'+str(RANK) + '\t' + MANUFACTURER.ljust(50) + str(INCIDENT_COUNT))
    input('\nPress Enter to return to the menu: ')
    #clear the system
    os.system('cls')

#files by component
def files_by_component():
    # clear the screen
    os.system('cls')
    os.chdir(the_desktop)
    os.chdir(PROCESSING)
    with open(CSV_FILE, 'r', errors='ignore') as f: #r = read
        next(f)
        # iterate through each line
        for line in f:
        #print(line)
            line_split = line.split(',')
            # extract components and append
            components_list.append(line_split[4])
            #print(components_list)
            # iterate through components list and create unique components list 
            for j in range(len(components_list)):
                try:
                    if components_list[j] not in unique_components_list:
                        unique_components_list.append(components_list[j])
                except:
                    continue
    #print(unique_components_list)
    # append x ocurring in unique components list to Bob list
    for x in range(len(unique_components_list)):
        Bob = []
        x = unique_components_list[x]
        #print(x)
        os.chdir(the_desktop)
        os.chdir(PROCESSING)
        with open(CSV_FILE, 'r', errors='ignore') as f: # r = read
            next(f)
            for line in f:
                line_split = line.split(',')
                if line_split[4] == x:
                    Bob.append(line_split)

        # change directory
        os.chdir(the_desktop)
        os.chdir(REPORTS)

        # write header and files to reports
        filename = str(x) + '.csv'
        with open(filename, 'w') as f: #w = write
            f.write('Date,NHTSA ID,Manufacturer,Subject,Component,Campaign Number,Recall Type,Consequence Summary\n')
        with open(filename, 'a') as f: #a = append
            for y in Bob:
                y_string = str(y)
                y_string = y_string.replace("'",'')
                y_string.replace('â€','')
                f.write(y_string + '\n')

    # zip above files to zip file and close
    #create zip file components.zip
    list_directory = os.listdir()
    # make zip file object 
    zip_f = zipfile.ZipFile(zip_file, 'a', zipfile.ZIP_DEFLATED) #a = append
    for x in list_directory:
        x_title = x.title()
        x_title = x_title.replace('Csv', 'csv')
        x_title = x_title.replace('Esc', 'ESC')
        x_title = x_title.replace('And', 'and')
        zip_f.write(x_title)
    # close the zipfile 
    zip_f.close

    #print out zip file size 
    zip_size = os.path.getsize(zip_file)
    print('\nReport files have been zipped into components.zip. Size: ' + str(zip_size))

    #iterate through the listdir() list
    for i in list_directory:
        #assign the last three letters to a variable
        last_three = i[-3:]
        # if they equal .csv remove the file
        if last_three == 'csv':
            os.remove(i)

    #input prompt from the user
    input('\nPress Enter to return to the menu: ')
    #clear the system
    os.system('cls')

# call the setup function
setup()

# call the csv_creation function
csv_creation()
    
# Menu loop with options of manufacture reports or create files by component
while True:
    
    print('''
Recall Notification Menu

Please select from the following options:

    1. Manufacturer Reports
    2. Create Files by Component
    3. Exit
    ''')

    user_menu_choice = input('Option #: ')

    if user_menu_choice == '1':
        screen_report()
        continue
    elif user_menu_choice == '2':
        files_by_component()
        continue
    elif user_menu_choice == '3':
        sys.exit()
    else:
        print()
        input('That is not a valid selection. Press Enter to continue: ')
    #clear the system
    os.system('cls')

print()
print()
input()
