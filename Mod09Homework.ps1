#Homework 1
#Nick Hollman

$SODA_BASE_PRICE=100
$payment=0
$balance=0

clear

$random= Get-Random -Minimum -3 -Maximum 4
$price_variance= (($random/1) * 5)

#Write-Host $random
#Write-Host $price_variance

$soda_price = $SODA_BASE_PRICE + $price_variance

#Write-Host $soda_price

Write-Host "Welcome to the soda machine. You can enter values of 5, 10 or 25 in payment`r`n"
while ($true)
{
    # get user input
    $soda_type = Read-Host "What type of soda would you like?"
    if (($soda_type -ne ""))
    {
        break
    }
    # if they just hit enter give message below
    else
    {
        Write-Host "`r`nYou must enter a value. Press Enter to try again."
        Read-Host
        clear
        continue
    }
}

clear
Write-Host ("The current price of " + $soda_type + " is " + "$soda_price" + " cents`r`n")

while ($true)
{
    # get coin value
    $coin = Read-Host "Enter a coin"
    # only register payment from coin if it is an eligible amount
    if (($coin -eq 5) -or ($coin -eq 10) -or ($coin -eq 25))
    {
        $payment += $coin
    }
    $balance=$soda_price - $payment
    # try dividing user input by 1, if it is a number of some kind it should equal itself
    if ($coin -eq 5)
    {
        clear
        Write-Host "You have inserted a nickel."
    }
    elseif ($coin -eq 10)
    {
        clear
        Write-Host "You have inserted a dime."
    }
    elseif ($coin -eq 25)
    {
        clear
        Write-Host "You have inserted a quarter."
    }
    else
    {
        clear
        Write-Host "That is not a valid amount."
    }
    if ($balance -gt 0)
    {
        Write-Host ("`r`nYou still owe " + $balance + " cents`r`n")
    }
    elseif ($balance -lt 0)
    {
        Write-Host ("`r`nYou have been refunded " + [math]::abs($balance) + " cents`r`n")
        Write-Host "Enjoy your $soda_type!"
        break
    }
    elseif ($balance -eq 0)
    {
        Write-Host "`r`nEnjoy your $soda_type!"
        break
    }
}
Read-Host "`r`nPress enter to close the program"