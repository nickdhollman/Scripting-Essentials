# Module 10 Homework
# Nick Hollman

$spades = @(
'Ace of Spades', 'King of Spades',
'Queen of Spades', 'Jack of Spades',
'10 of Spades', '9 of Spades',
'8 of Spades', '7 of Spades',
'6 of Spades', '5 of Spades',
'4 of Spades', '3 of Spades',
'2 of Spades')

$diamonds = @(
'Ace of Diamonds', 'King of Diamonds',
'Queen of Diamonds', 'Jack of Diamonds',
'10 of Diamonds', '9 of Diamonds',
'8 of Diamonds', '7 of Diamonds',
'6 of Diamonds', '5 of Diamonds',
'4 of Diamonds', '3 of Diamonds',
'2 of Diamonds')

$clubs = @(
'Ace of Clubs', 'King of Clubs',
'Queen of Clubs', 'Jack of Clubs',
'10 of Clubs', '9 of Clubs',
'8 of Clubs', '7 of Clubs',
'6 of Clubs', '5 of Clubs',
'4 of Clubs', '3 of Clubs',
'2 of Clubs')


$hearts = @(
'Ace of Hearts', 'King of Hearts',
'Queen of Hearts', 'Jack of Hearts',
'10 of Hearts', '9 of Hearts',
'8 of Hearts', '7 of Hearts',
'6 of Hearts', '5 of Hearts',
'4 of Hearts', '3 of Hearts',
'2 of Hearts')

## New Deck Function
function new_deck()
{
Write-Host "You have a new deck of cards."
$Global:spades_global = @()
$Global:diamonds_global = @()
$Global:clubs_global = @()
$Global:hearts_global = @()

foreach ($i in $spades)
{
    $Global:spades_global += $i
}
foreach ($i in $diamonds)
{
    $Global:diamonds_global += $i
}
foreach ($i in $clubs)
{
    $Global:clubs_global += $i
}
foreach ($i in $hearts)
{
    $Global:hearts_global += $i
}
}


## Remove Card function
function remove_card($array, $card_to_remove)
{
    $temp_array = @()
    for ($i=0; $i -lt $array.Count; $i++)
    {
    if ($i -ne $card_to_remove)
    {
        $temp_array += $array[$i]
    }
    }
    return $temp_array
}

## Card Draw function 
function card_draw {
#while ($true) {
    $cards_remaining = $Global:spades_global.Count + $Global:diamonds_global.Count + $Global:clubs_global.Count + $Global:hearts_global.Count

    clear
    #Write-Host "There are $cards_remaining cards left in the deck.`r`n"

    $cards_requested = Read-Host "How many cards would you like to draw from the deck?"

    #Validation
    if (($cards_requested -notmatch "^[+]?[0-9]") -or ($cards_requested -ne ($cards_requested/1)) -or ($cards_requested -eq ""))
    {
    clear
    Write-Host "The value must be a positive integer. Press Enter to continue"
    Read-Host
    continue
    }
    $cards_requested = [int]$cards_requested

    #error statement
    if ($cards_requested -gt $cards_remaining)
    {
    clear
    Write-Host "There are only $cards_remaining cards left in the deck but you have requested $cards_requested cards."
    Write-Host "`r`nPress the Enter key to return to the main menu"
    Read-Host
    return
    }
    Write-Host "Your cards are:`r`n"

    while ($cards_requested -gt 0)
    {
    # get random between 0 and 3
    $suit = Get-Random -Minimum 0 -Maximum 4
    ##### Spades
        if ($suit -eq 0)
        {
        # If no spades in array then continue
            if ($Global:spades_global.Count -eq 0)
            {
            continue
            }
        # account for Dr. Burkman instruction if count -eq 1
            elseif ($Global:spades_global.Count -eq 1)
            {
            Write-Host $Global:spades_global[0]
            $Global:spades_global = @()
            $cards_requested = $cards_requested - 1
            continue
            }
            elseif ($Global:spades_global.Count -gt 1)
            {
        # If spades in array get random index for random draw
        $index = Get-Random -Minimum 0 -Maximum $Global:spades_global.Count
        # Print out random draw
        Write-Host ($Global:spades_global[$index])
        # Remove card from array
        # by assigning the returned result of remove card as an array I am able to solve the parsing problem
        $Global:spades_global = @(remove_card -array $Global:spades_global -card_to_remove $index)
        # decrease card requested by 1 b/c of card removal
        $cards_requested = $cards_requested - 1
        continue
        }
        }
    ###### Diamonds
        elseif ($suit -eq 1)
        {
        # If no spades in array then continue
            if ($Global:diamonds_global.Count -eq 0)
            {
            continue
            }
        # account for Dr. Burkman instruction if count -eq 1
            elseif ($Global:diamonds_global.Count -eq 1)
            {
            Write-Host $Global:diamonds_global[0]
            $Global:diamonds_global = @()
            $cards_requested = $cards_requested - 1
            continue
            }
            elseif ($Global:diamonds_global.Count -gt 1)
            {
        # If spades in array get random index for random draw
        $index = Get-Random -Minimum 0 -Maximum $Global:diamonds_global.Count
        # Print out random draw
        Write-Host ($Global:diamonds_global[$index])
        # Remove card from array
        $Global:diamonds_global = @(remove_card -array $Global:diamonds_global -card_to_remove $index)
        # decrease card requested by 1 b/c of card removal
        $cards_requested = $cards_requested - 1
        continue
        }
        }
    ###### Clubs
        elseif ($suit -eq 2)
        {
        # If no spades in array then continue
            if ($Global:clubs_global.Count -eq 0)
            {
            continue
            }
        # account for Dr. Burkman instruction if count -eq 1
            elseif ($Global:clubs_global.Count -eq 1)
            {
            Write-Host $Global:clubs_global[0]
            $Global:clubs_global = @()
            $cards_requested = $cards_requested - 1
            continue
            }
            elseif ($Global:clubs_global.Count -gt 1)
            {
        # If spades in array get random index for random draw
        $index = Get-Random -Minimum 0 -Maximum $Global:clubs_global.Count
        # Print out random draw
        Write-Host ($Global:clubs_global[$index])
        # Remove card from array
        $Global:clubs_global = @(remove_card -array $Global:clubs_global -card_to_remove $index)
        # decrease card requested by 1 b/c of card removal
        $cards_requested = $cards_requested - 1
        continue
        }
        }
    ###### Hearts
        else
        {
        # If no spades in array then continue
            if ($Global:hearts_global.Count -eq 0)
            {
            continue
            }
        # account for Dr. Burkman instruction if count -eq 1
          elseif ($Global:hearts_global.Count -eq 1)
            {
            Write-Host @($Global:hearts_global[0])
            $Global:hearts_global = @()
            $cards_requested = $cards_requested - 1
            continue
            }
            elseif ($Global:hearts_global.Count -gt 1)
            {
        # If spades in array get random index for random draw
        $index = Get-Random -Minimum 0 -Maximum $Global:hearts_global.Count
        # Print out random draw
        Write-Host ($Global:hearts_global[$index])
        # Remove card from array
        $Global:hearts_global = @(remove_card -array $Global:hearts_global -card_to_remove $index)
        # decrease card requested by 1 b/c of card removal
        $cards_requested = $cards_requested - 1
        continue
        }
        }
    }
    # Read-Host to make user press enter after being shown cards and break out of loop to go back to menu
    Read-Host
    return
}

new_deck

while ($true)
{
    clear
    Write-Host ('
Welcome to the card deck simulator.

Please select from the following options:

    1. Draw a selected number of cards from the current deck
    2. Get a new deck of cards
    3. Exit

    ')
    $user_menu_choice = Read-Host "Option#"
    if ($user_menu_choice -eq 1)
    {
        card_draw
    }
    elseif ($user_menu_choice -eq 2)
    {
        new_deck
    }
    elseif ($user_menu_choice -eq 3)
    {
        clear
        exit
    }
    else
    {
        clear
        Read-Host "That is not a valid selection. Press Enter to continue"
    }
}
Read-Host