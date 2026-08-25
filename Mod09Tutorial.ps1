#Nick Hollman
#Mod 09 Tutuorial 

clear
Read-Host "Press enter to move from task to task"
clear

# Task 1
clear
# Below `r`n is how to skip line
Write-Host "Task 1`r`n"
Write-Host "Hello World"
# Below is if you want the user to press enter to end 
Read-Host

# Task 2
clear
Write-Host "Task 2`r`n"
while ($true)
{
    # get user input
    $user_guess = Read-Host "Please enter an integer"
    # try dividing user input by 1, if it is a number of some kind it should equal itself
    try
    {
    # | Out-Null is saying we don't want the True message, we want to throw it out
        $user_guess -eq $user_guess/1 | Out-Null
    }
    # if it does not equal itself divided by one give the below message
    catch
    {
        Write-Host "`r`n$user_guess is not an integer. Press Enter to try again."
        Read-Host
        clear
        continue
    }
    # if user guess / 1 is integer and is not empty (they did not just hit enter) give message below
    # you could put another and condition if you wanted greater than or equal to a certain value, etc.
    if (($user_guess/1 -is [int]) -and ($user_guess -ne ""))
    {
        Write-Host "`r`nYou entered $user_guess which is an integer."
        Read-Host
        break
    }
    # if user guess is not an integer or they just hit enter give message below
    else
    {
        Write-Host "`r`n$user_guess is not an integer. Press Enter to try again."
        Read-Host
        clear
        continue
    }
}


# Task 3
clear
Write-Host("Task 3`r`n")
# we divide by 1 to convert $user guess to a number
# we use + to concat things
Write-Host ("$user_guess times 3 is " + (($user_guess/1) * 3))
Read-Host

# Task 4
clear
Write-Host("Task 4`r`n")
# below could be $i-- if we want to go in descending order
for ($i =1; $i -le 20; $i++)
{
    if ($i -eq 7)
    {
        Write-Host "Snowflake"
    }
    # if it is an even number modulus 2 (%2) will result in 0
    # if it is an odd number %2 will result in 1
    elseif ($i%2 -eq 1)
    {
        Write-Host "Odd"
    }
    else
    {
        Write-Host "Even"
    }

}
Read-Host

# Task 5
clear
Write-Host("Task 5`r`n")
while ($true)
{
    $user_guess = Read-Host "Enter a number greater than 13"
    try
    {
    # | Out-Null is saying we don't want the True message, we want to throw it out
        $user_guess -eq $user_guess/1 | Out-Null
    }
    # if it does not equal itself divided by one give the below message
    catch
    {
        Write-Host "`r`n$user_guess is not an integer. Press Enter to try again."
        Read-Host
        clear
        continue
    }
    # if user guess / 1 is integer and is not empty (they did not just hit enter) 
    # and because we want to additionally check if the integer is gt 13 we add the third condition
    if (($user_guess/1 -is [int]) -and ($user_guess -ne "") -and ($user_guess/1 -gt 13))
    {
        break
    }
    # if user guess is not an integer or they just hit enter or integer is le 13 give message below
    else
    {
        Write-Host "`r`n$user_guess is not an appropriate choice. Press Enter to try again."
        Read-Host
        clear
        continue
    }
}
# if the above condition is met and the user entered an integer greater than 13 send the user input to this for loop
for ($i = 1; $i -le $user_guess; $i++)
{
    if ($i -eq 7)
    {
        Write-Host "Lucky"
    }
    elseif ($i -eq 13)
    {
        Write-Host "Unlucky"
    }
    elseif ($i%2 -eq 1)
    {
        Write-Host "Odd"
    }
    else
    {
        Write-Host "even"
    }
}
Read-Host

# Task 6
clear
Write-Host ("Task 6`r`n")
while ($true)
{
    $user_name = Read-Host "Please enter a last name (Hollman)"
    if ($user_name -eq "Hollman")
    {
        break
    }
    else
    {
        continue
    }
}

# Task 7
clear
Write-Host ("Task 7`r`n")
$counter = 0
while ($counter -lt 10)
{
    Write-Host $counter
    $counter += 1

}
Read-Host

# Task 8
clear
Write-Host ("Task 8`r`n")
$ran_low=0
$ran_high=0
# for loop from 0 - 29 (incriment by 1, so loop 30 times)
for ($i = 0; $i -lt 30; $i += 1)
{
    # Get randmo number from -10 to 10
    $my_random= Get-Random -Minimum -10 -Maximum 11
    if ($my_random -gt $ran_high)
    {
        $ran_high = $my_random
    }
    if ($my_random -lt $ran_low)
    {
        $ran_low = $my_random
    }
}

Write-Host "The lowest value was $ran_low and the highest value was $ran_high"
Read-Host "`r`nPress Enter to end the script"





