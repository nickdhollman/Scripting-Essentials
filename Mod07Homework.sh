#! /bin/bash

#Mod 07 Homework
#Nick Hollman

name_array=('Constance_Castillo' 'Kerry_Goodwin' 'Dorothy_Carson' 'Craig_Williams' 
'Daryl_Guzman' 'Sherman_Stewart' 'Marvin_Collier' 'Javier_Wilkerson' 'Lena_Olson' 
'Claudia_George' 'Erik_Elliott' 'Traci_Peters' 'Jack_Burke' 'Jody_Turner' 'Kristy_Jenkins' 
'Melissa_Griffin' 'Shelia_Ballard' 'Armando_Weaver' 'Elsie_Fitzgerald' 'Ben_Evans' 'Lucy_Baker' 
'Kerry_Anderson' 'Kendra_Tran' 'Arnold_Wells' 'Anita_Aguilar' 'Earnest_Reeves' 'Irving_Stone' 
'Alice_Moore' 'Leigh_Parsons' 'Mandy_Perez' 'Rolando_Paul' 'Delores_Pierce' 'Zachary_Webster' 
'Eddie_Ward' 'Alvin_Soto' 'Ross_Welch' 'Tanya_Padilla' 'Rachel_Logan' 'Angelica_Richards' 
'Shelley_Lucas' 'Alison_Porter' 'Lionel_Buchanan' 'Luis_Norman' 'Milton_Robinson' 'Ervin_Bryant' 
'Tabitha_Reid' 'Randal_Graves' 'Calvin_Murphy' 'Blanca_Bell' 'Dean_Walters' 'Elias_Klein' 
'Madeline_White' 'Marty_Lewis' 'Beatrice_Santiago' 'Willis_Tucker' 'Diane_Lloyd' 'Al_Harrison' 
'Barbara_Lawson' 'Jamie_Page' 'Conrad_Reynolds' 'Darnell_Goodman' 'Derrick_Mckenzie' 
'Erika_Miller' 'Tasha_Todd' 'Aaron_Nunez' 'Julio_Gomez' 'Tommie_Hunter' 'Darlene_Russell' 
'Monica_Abbott' 'Cassandra_Vargas' 'Gail_Obrien' 'Doug_Morales' 'Ian_James' 'Jean_Moran' 
'Carla_Ross' 'Marjorie_Hanson' 'Clark_Sullivan' 'Rick_Torres' 'Byron_Hardy' 'Ken_Chandler' 
'Brendan_Carr' 'Richard_Francis' 'Tyler_Mitchell' 'Edwin_Stevens' 'Paul_Santos' 
'Jesus_Griffith' 'Maggie_Maldonado' 'Isaac_Allen' 'Vanessa_Thompson' 'Jeremy_Barton' 
'Joey_Butler' 'Randy_Holmes' 'Loretta_Pittman' 'Essie_Johnston' 'Felix_Weber' 'Gary_Hawkins' 
'Vivian_Bowers' 'Dennis_Jefferson' 'Dale_Arnold' 'Joseph_Christensen' 'Billie_Norton' 
'Darla_Pope' 'Tommie_Dixon' 'Toby_Beck' 'Jodi_Payne' 'Marjorie_Lowe' 'Fernando_Ballard' 
'Jesse_Maldonado' 'Elsa_Burke' 'Jeanne_Vargas' 'Alton_Francis' 'Donald_Mitchell' 'Dianna_Perry' 
'Kristi_Stephens' 'Virgil_Goodwin' 'Edmund_Newton' 'Luther_Huff' 'Hannah_Anderson' 'Emmett_Gill' 
'Clayton_Wallace' 'Tracy_Mendez' 'Connie_Reeves' 'Jeanette_Hansen' 'Carole_Fox' 'Carmen_Fowler' 
'Alex_Diaz' 'Rick_Waters' 'Willis_Warren' 'Krista_Ferguson' 'Debra_Russell' 'Ellis_Christensen' 
'Freda_Johnston' 'Janis_Carpenter' 'Rosemary_Sherman' 'Earnest_Peters' 'Kelly_West' 
'Jorge_Caldwell' 'Moses_Norris' 'Erica_Riley' 'Ray_Gordon' 'Abel_Poole' 'Cary_Boone' 
'Grant_Gomez' 'Denise_Chapman' 'Vernon_Moran' 'Ben_Walker' 'Francis_Benson' 'Andrea_Sullivan' 
'Wayne_Rice' 'Jamie_Mason' 'Jane_Figueroa' 'Pat_Wade' 'Rudy_Bates' 'Clyde_Harris' 'Andre_Mathis' 
'Carlton_Oliver' 'Merle_Lee' 'Amber_Wright' 'Russell_Becker' 'Natalie_Wheeler' 'Maryann_Miller' 
'Lucia_Byrd' 'Jenny_Zimmerman' 'Kari_Mccarthy' 'Jeannette_Cain' 'Ian_Walsh' 'Herman_Martin' 
'Ginger_Farmer' 'Catherine_Williamson' 'Lorena_Henderson' 'Molly_Watkins' 'Sherman_Ford' 
'Adam_Gross' 'Alfred_Padilla' 'Dwayne_Gibson' 'Shawn_Hall' 'Anthony_Rios' 'Kelly_Thomas' 
'Allan_Owens' 'Duane_Malone' 'Chris_George' 'Dana_Holt' 'Muriel_Santiago' 'Shelley_Osborne' 
'Clinton_Ross' 'Kelley_Parsons' 'Sophia_Lewis' 'Sylvia_Cooper' 'Regina_Aguilar' 
'Sheila_Castillo' 'Sheri_Mcdonald' 'Lynn_Hodges' 'Patrick_Medina' 'Arlene_Tate' 'Minnie_Weber' 
'Geneva_Pena' 'Byron_Collier' 'Veronica_Higgins' 'Leo_Roy' 'Nelson_Lopez')

#Option 1
option_1 () {
echo
fname_count=0
# retrieve the entry for first name
read -p "Enter the first name, or a partial of the first name: " letters
# get the length of the entry for comparison
echo
len=${#letters}
# lowercase letters for comparison
letters=$(echo $letters | tr [:upper:] [:lower:])
# similar to song in tutorial, iterate through each name in name list
for i in ${name_array[*]};
do
  if [[ $len -eq 0 ]];then
   echo $i | tr "_" " "
  else
	# extract first name from name array
	first_name=$(echo $i | cut -d "_" -f1)
	# convert first_name to lowercase
	first_name_l=$(echo $first_name | tr [:upper:] [:lower:])
	# extract the number of letters from the first_name as input
	first_letters=${first_name_l:0:$len}
	#if letters entered equal then print name and add to count
	if [[ $first_letters  == $letters ]];then
		fname_clean=$(echo $i | tr "_" " ")
		echo "$fname_clean"
		fname_count=$((fname_count + 1))
	fi
  fi
done
if [[ $fname_count -eq 0 ]] && [[ $len -ne 0 ]] ;then
	echo "No first names were found starting with $letters"
fi
}

#option 2
option_2 () {
echo
lname_count=0
# retrieve the entry for last name
read -p "Enter the last name, or a partial of the last name: " letters
# get the length of the entry for comparison
echo
len=${#letters}
# lowercase letters for comparison
letters=$(echo $letters | tr [:upper:] [:lower:])
# similar to song in tutorial, iterate through each name in name list
for i in ${name_array[*]};
do
  if [[ $len -eq 0 ]];then
	echo $i | tr "_" " "
  else
	# extract last name from name array
	last_name=$(echo $i | cut -d "_" -f2)
	# convert last_name to lowercase
	last_name_l=$(echo $last_name | tr [:upper:] [:lower:])
	# extract the number of letters from the last_name as input
	last_letters=${last_name_l:0:$len}
	#if letters entered equal then print name and add to count
	if [[ $last_letters  == $letters ]];then
		lname_clean=$(echo $i | tr "_" " ")
		echo "$lname_clean"
		lname_count=$((lname_count + 1))
	fi
  fi
done

if [[ $lname_count -eq 0 ]] && [[ $len -ne 0 ]];then
	echo "No last names were found starting with $letters"
fi
}

#option 3
option_3 () {
echo
while true;
do
	read -p "Enter the new first name: " first_name
	# attempt to match first name with a space
	# if a space is foud, present error
	if [[ $first_name == *" "* ]];then
		echo "Just the first name, please. No spaces."
	else
		break
	fi
done
read -p "Enter the new last name: " last_name
# normalize the name to titlecase
# first convert entire entry to lowercase
first_name=$(echo $first_name | tr [:upper:] [:lower:])
first_initial=$(echo ${first_name:0:1} | tr [:lower:] [:upper:])
#get remaining
first_remaining=${first_name:1}
#zip together
first_name=$first_initial$first_remaining
#repeat above with last name
last_name=$(echo $last_name | tr [:upper:] [:lower:])
initial_last=$(echo ${last_name:0:1} | tr [:lower:] [:upper:])
last_remaining=${last_name:1}
last_name=$initial_last$last_remaining
#prep for entry to array
full_name="$first_name $last_name"
full_name_array=$(echo $full_name | tr " " "_")
name_array+=($full_name_array)
echo
echo "$full_name has been added"
}

#option 4
option_4 () {
echo
while true;
do
echo "Delete a name by entering the full name ie: John Smith"
read -p "Enter the full name (Q to return to the main menu, 1 to search first names): " user_input
	if [[ $user_input == "1" ]];then
		option_1
		echo
		continue
	fi
	if [[ $user_input == "Q" ]] || [[ $user_input == "q" ]];then
		break
	fi
	counter=0
	for i in ${!name_array[*]};
	do
		#below sees if the name is in array, and if so finds the index
		name_cleaned=$(echo ${name_array[i]} | tr "_" " ")
		if [[ $name_cleaned == $user_input ]];then
			counter=1
			index=$i
			break
		fi
	done
	#if the name is not found, print the statement below
	if [[ counter -eq 0 ]];then
		echo -e  "\nNo names were found matching $user_input\n "
		continue
	fi

	#if the name is found, delete from the index value
	name_array=(${name_array[*]:0:$index} ${name_array[*]:$(($index + 1))})
	echo -e "\n$user_input has been deleted from the array.\n"
	continue
done
}

# Menu Loop
while true;
do
	echo "
Please select from the following options:

    1. List all names starting with one or more letters of the first name
    2. List all names starting with one or more letters of the last name
    3. Add a name
    4. Delete a name
    5. Exit
"
read -p "Option#: " user_menu_choice

	if [[ $user_menu_choice -eq 1 ]];then
		option_1
	elif  [[ $user_menu_choice -eq 2 ]];then
		option_2
	elif  [[ $user_menu_choice -eq 3 ]];then
		option_3
	elif  [[ $user_menu_choice -eq 4 ]];then
		option_4
	elif [[ $user_menu_choice -eq 5 ]];then
		break
	else
		clear
		read -p "That is not a valid selection. Press Enter to continue: "
	fi
done
