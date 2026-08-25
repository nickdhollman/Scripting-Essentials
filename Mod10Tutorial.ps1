# Module 10 Tutorial
# Nick Hollman

# Declare variables
$input_counter=0
$myArray=@('seven', '7', '120', 'monkey', 'cat', 'the', 'heck', '3.1', '-1384', 'banana')

# Functions
# This function randomly inserts whatever is passed to it into the string
function RandoInsert($myArray, $thingBeingInserted)
{
    $tempArray = @()
    $indexPosition = Get-Random -Minimum 0 -Maximum ($myArray.Length + 1)
    if($indexPosition -eq 0)
    {
        $tempArray += $thingBeingInserted
        for($i = 0;$i -lt $myArray.Length;$i++)
        {
            $tempArray += $myArray[$i]
        }
        return $tempArray
    }
    elseif($indexPosition -ge $myArray.Length)
    {
        for($i = 0;$i -lt $myArray.Length;$i++)
        {
            $tempArray += $myArray[$i]
        }
        $tempArray += $thingBeingInserted
        return $tempArray
    }
    else
    {
        for($i = 0;$i -lt $indexPosition;$i++)
        {
            $tempArray += $myArray[$i]
        }
        $tempArray += $thingBeingInserted
        for($i = $indexPosition;$i -lt $myArray.Length;$i++)
        {
            $tempArray += $myArray[$i]
        }
        return $tempArray
    }
}

clear
Read-Host "Press enter to move from task to task"
clear

<#
# Task 1
# Fill an array with user input
clear
Write-Host "Task 1`r`n"
Write-Host ("Create an array filled with some words and numbers")
while ($input_counter -lt 10)
{
    $user_input = Read-Host "Please enter a number or word"
    $myArray += $user_input
    $input_counter += 1
}
Read-Host
#>

# Task 2
# Print the length of the array as "This array has x items. <boolean>"
clear
Write-Host "Task 2`r`n"
$myArrayLength = $myArray.Length
$boolCheck = $myArrayLength -eq 10
Write-Host ("This array has $myArrayLength items. $boolCheck")

Read-Host

# Task 3
# Print the array
clear
Write-Host "Task 3`r`n"
Write-Host "This is the array:"
Write-Host $myArray

Read-Host

# Task 4
# Swap the first and the last items and print the array
Write-Host "Task 4`r`n"
$firstThing = $myArray[0]
$myArray[0] = $myArray[-1]
$myArray[-1] = $firstThing
Write-Host "This is the array after swapping the first and last items:"
Write-Host $myArray

Read-Host

# Task 5
# Print the first 3 and last 3 items
Write-Host "Task 5 `r`n"
Write-Host ("These are the first three and last three items in the array:")
Write-Host ($myArray[0..2], $myArray[-3..-1])

Read-Host

# Task 6
# Loop the array and print the items
clear
Write-Host "Task 6`r`n"
foreach ($i in $myArray)
{
    Write-Host $i
}
Read-Host

# Task 7
# Check to see if 'cat' is in the array and report
clear
Write-Host "Task 7`r`n"
if ($myArray.Contains("cat"))
{
    Write-Host "There is a cat in my array"
}
else
{
    Write-Host "There is no cat in my array"
}
Read-Host


# Task 8
# Get a Marval name and pass that to a function for random insert
clear
Write-Host "Task 8`r`n"
$userHero = Read-Host "Please insert the name of a Marvel character"
$myArray = RandoInsert -myArray $myArray -thingBeingInserted $userHero
Write-Host ("The array is now: $myArray")
Read-Host

# Task 9
# Print the index position of that Marvel name and the new array
clear
Write-Host "Task 9`r`n"
Write-Host $userHero "is at position" $myArray.IndexOf($userHero) "in the array"

Read-Host

# Task 10
# Copy integers to a new array, sort, and print
clear
Write-Host "Task 10`r`n"
$intArray = @()
foreach ($i in $myArray)
{
    try
    {
        # if it is a decimal the diff will not be 0
        $diff = $i - [int]$i
        # this will throw an error if it is non-numeric; if it is non-numeric it will proceed to catch
        $i = [int]$i
        if ($diff -ne 0)
        {
            continue
        }
        else
        {
            $intArray += $i 
        }
    }
    catch
    {
        continue
    }
}

$intArray = $intArray | sort
Write-Host "The integers in the original array, sorted, are: $intArray"

Read-Host

# Task 11
# Create and unpack an array of arrays 
clear
Write-Host "Task 11`r`n"
$a = @(1,2,3)
$b = @("a","b","c")
$c = @(1.1, "house", 7)
$d = @($a, $b, $c) 

foreach ($i in $d)
{
    foreach ($j in $i)
    {
        Write-Host $j
    }
}
Read-Host -Prompt "`r`nPress enter to close the program"