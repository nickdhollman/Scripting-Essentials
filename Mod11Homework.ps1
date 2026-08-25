#Module 11 Homework
#Nick Hollman

$Global:name_list = @('Constance Castillo', 'Kerry Goodwin',
 'Dorothy Carson', 'Craig Williams', 'Daryl Guzman', 'Sherman Stewart',
 'Marvin Collier', 'Javier Wilkerson', 'Lena Olson', 'Claudia George',
 'Erik Elliott', 'Traci Peters', 'Jack Burke', 'Jody Turner',
 'Kristy Jenkins', 'Melissa Griffin', 'Shelia Ballard', 'Armando Weaver',
 'Elsie Fitzgerald', 'Ben Evans', 'Lucy Baker', 'Kerry Anderson',
 'Kendra Tran', 'Arnold Wells', 'Anita Aguilar', 'Earnest Reeves',
 'Irving Stone', 'Alice Moore', 'Leigh Parsons', 'Mandy Perez',
 'Rolando Paul', 'Delores Pierce', 'Zachary Webster', 'Eddie Ward',
 'Alvin Soto', 'Ross Welch', 'Tanya Padilla', 'Rachel Logan',
 'Angelica Richards', 'Shelley Lucas', 'Alison Porter', 'Lionel Buchanan',
 'Luis Norman', 'Milton Robinson', 'Ervin Bryant', 'Tabitha Reid',
 'Randal Graves', 'Calvin Murphy', 'Blanca Bell', 'Dean Walters',
 'Elias Klein', 'Madeline White', 'Marty Lewis', 'Beatrice Santiago',
 'Willis Tucker', 'Diane Lloyd', 'Al Harrison', 'Barbara Lawson',
 'Jamie Page', 'Conrad Reynolds', 'Darnell Goodman', 'Derrick Mckenzie',
 'Erika Miller', 'Tasha Todd', 'Aaron Nunez', 'Julio Gomez',
 'Tommie Hunter', 'Darlene Russell', 'Monica Abbott', 'Cassandra Vargas',
 'Gail Obrien', 'Doug Morales', 'Ian James', 'Jean Moran',
 'Carla Ross', 'Marjorie Hanson', 'Clark Sullivan', 'Rick Torres',
 'Byron Hardy', 'Ken Chandler', 'Brendan Carr', 'Richard Francis',
 'Tyler Mitchell', 'Edwin Stevens', 'Paul Santos', 'Jesus Griffith',
 'Maggie Maldonado', 'Isaac Allen', 'Vanessa Thompson', 'Jeremy Barton',
 'Joey Butler', 'Randy Holmes', 'Loretta Pittman', 'Essie Johnston',
 'Felix Weber', 'Gary Hawkins', 'Vivian Bowers', 'Dennis Jefferson',
 'Dale Arnold', 'Joseph Christensen', 'Billie Norton', 'Darla Pope',
 'Tommie Dixon', 'Toby Beck', 'Jodi Payne', 'Marjorie Lowe',
 'Fernando Ballard', 'Jesse Maldonado', 'Elsa Burke', 'Jeanne Vargas',
 'Alton Francis', 'Donald Mitchell', 'Dianna Perry', 'Kristi Stephens',
 'Virgil Goodwin', 'Edmund Newton', 'Luther Huff', 'Hannah Anderson',
 'Emmett Gill', 'Clayton Wallace', 'Tracy Mendez', 'Connie Reeves',
 'Jeanette Hansen', 'Carole Fox', 'Carmen Fowler', 'Alex Diaz',
 'Rick Waters', 'Willis Warren', 'Krista Ferguson', 'Debra Russell',
 'Ellis Christensen', 'Freda Johnston', 'Janis Carpenter', 'Rosemary Sherman',
 'Earnest Peters', 'Kelly West', 'Jorge Caldwell', 'Moses Norris',
 'Erica Riley', 'Ray Gordon', 'Abel Poole', 'Cary Boone',
 'Grant Gomez', 'Denise Chapman', 'Vernon Moran', 'Ben Walker',
 'Francis Benson', 'Andrea Sullivan', 'Wayne Rice', 'Jamie Mason',
 'Jane Figueroa', 'Pat Wade', 'Rudy Bates', 'Clyde Harris',
 'Andre Mathis', 'Carlton Oliver', 'Merle Lee', 'Amber Wright',
 'Russell Becker', 'Natalie Wheeler', 'Maryann Miller', 'Lucia Byrd',
 'Jenny Zimmerman', 'Kari Mccarthy', 'Jeannette Cain', 'Ian Walsh',
 'Herman Martin', 'Ginger Farmer', 'Catherine Williamson', 'Lorena Henderson',
 'Molly Watkins', 'Sherman Ford', 'Adam Gross', 'Alfred Padilla',
 'Dwayne Gibson', 'Shawn Hall', 'Anthony Rios', 'Kelly Thomas',
 'Allan Owens', 'Duane Malone', 'Chris George', 'Dana Holt',
 'Muriel Santiago', 'Shelley Osborne', 'Clinton Ross', 'Kelley Parsons',
 'Sophia Lewis', 'Sylvia Cooper', 'Regina Aguilar', 'Sheila Castillo',
 'Sheri Mcdonald', 'Lynn Hodges', 'Patrick Medina', 'Arlene Tate',
 'Minnie Weber', 'Geneva Pena', 'Byron Collier', 'Veronica Higgins',
 'Leo Roy', 'Nelson Lopez')


# List all names starting with one or more letters of the first name
function first_name {
clear
$input = Read-Host -Prompt "Enter the first name, or a parial start of the first name"
Write-Host
# Standardize input to upper case
$input_upper = $input.ToUpper()
# If input is enter then print all names
if ($input_upper -eq "")
{
    foreach ($i in $Global:name_list)
    {
        Write-Host $i
    }
    Write-Host "`r`nPress Enter to return to the previous menu"
    Read-Host
    clear
}
else
{
# Set counter at 0, that way if counter returns 0 then it means nothing in name list matched entry
$first_name_counter = 0
# For each name in name list
foreach ($i in $Global:name_list )
{
    # split name by space to separate first and last name
    $name_split = $i.Split(" ")
    # Get first name by retrieving [0], and compare with $input by StartsWith
    if ($name_split[0].ToUpper().StartsWith($input_upper))
    {
        Write-Host($name_split[0] + " " + $name_split[1])
        $first_name_counter += 1
    }
}
    if ($first_name_counter -eq 0)
    {
        # print the original input 
        Write-Host("No first names found starting with: " + $input)
    }
    Write-Host "`r`nPress Enter to return to the previous menu"
    Read-Host
    clear
}
}
 
# List all names starting with one or more letters of the last name
function last_name {
clear
$input = Read-Host -Prompt "Enter the last name, or a parial start of the last name"
Write-Host
# Standardize input to upper case
$input_upper = $input.ToUpper()
# If input is enter then print all names
if ($input_upper -eq "")
{
    foreach ($i in $Global:name_list )
    {
        Write-Host $i
    }
    Write-Host "`r`nPress Enter to return to the previous menu"
    Read-Host
    clear
}
else
{
# Set counter at 0, that way if counter returns 0 then it means nothing in name list matched entry
$last_name_counter = 0
# For each name in name list
foreach ($i in $Global:name_list )
{
    # split name by space to separate first and last name
    $name_split = $i.Split(" ")
    # Get last name by retrieving [1], and compare with $input by StartsWith
    if ($name_split[1].ToUpper().StartsWith($input_upper))
    {
        Write-Host($name_split[0] + " " + $name_split[1])
        $last_name_counter += 1
    }
}
    if ($last_name_counter -eq 0)
    {
        Write-Host("No last names found starting with: " + $input)
    }
    Write-Host "`r`nPress Enter to return to the previous menu"
    Read-Host
    clear
}
}


# Add a name
function add_name {
clear
# initialize first and last name strings
$new_first_name = ""
$new_last_name = ""

while ($true)
{
    $new_first_name = Read-Host "Enter the new first name"
    # if new first name contains " " then give error message
    if ($new_first_name -like "* *")
    {
        clear
        Read-Host "`r`nFirst name only, please. Press Enter to continue"
        clear
        continue
    }
    $new_last_name = Read-Host "Enter the new last name"
    break
}
# apply title case to first name and last name
$new_first_name = (Get-Culture).TextInfo.ToTitleCase($new_first_name.ToLower())
$new_last_name = (Get-Culture).TextInfo.ToTitleCase($new_last_name.ToLower())
$new_name = ($new_first_name + " " + $new_last_name)
$Global:name_list  += $new_name
Write-Host ("`r`n$new_name has been added.")
Write-Host "`r`nPress Enter to return to the previous menu"
Read-Host
clear
}

# Delete a name
function delete_name {
clear
while ($true)
{
$user_choice = Read-Host "Enter the full name, `"1`" to view names or `"Q`" to quit"
$user_choice_q = $user_choice.ToUpper()
if ($user_choice_q -eq "Q")
{
    break
}
elseif ($user_choice -eq "1")
{
    first_name
}
else
{
   # title case deleted_name
   $deleted_name = (Get-Culture).TextInfo.ToTitleCase($user_choice.ToLower())
   # create temp_array similar to HW 10 to store name_list results without deleted name
   $new_name_list = @()
   # create name count so we can tell when no match is found
   $name_count = 0

   foreach ($i in $Global:name_list)
   {
        # if name is found add to the name count and don't add to new_name_list
        if ($i -eq $deleted_name)
        {
            $name_count += 1
        }
        # if name is not found don't add to name_count and add to new_name_list
        else
        {
            $new_name_list += $i
        }
       
    }
    # if name was found create new name list and store it as $Global: to be used outside of function when searching for names
    # if name as found also print that name was found in list
    if ($name_count -gt 0)
    {
        $Global:name_list = $new_name_list
        Write-Host "`r`n$deleted_name was deleted from the list."
        Write-Host "`r`nPress Enter to return to the previous menu"
        Read-Host
        clear
    }
    else
    {
        clear
        Write-Host "That name was not found. Press Enter to continue"
        Read-Host
        clear
    }
}
}
}

#Menu system
while ($true)
{
clear
Write-Host '
Please select from the following options: 

    1. List all names starting with one or more letters of the first name
    2. List all names starting with one or more letters of the last name
    3. Add a name
    4. Delete a name
    5. Exit
'
$user_menu_choice = Read-Host "Option #"
    if ($user_menu_choice -eq 1)
    {
        first_name
    }
    elseif ($user_menu_choice -eq 2)
    {
        last_name
    }
    elseif ($user_menu_choice -eq 3)
    {
        add_name
    }
    elseif ($user_menu_choice -eq 4)
    {
        delete_name
    }
    elseif ($user_menu_choice -eq 5)
    {
        clear
        exit
    }
    else
    {
        continue
    }
}