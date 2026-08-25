#! /bin/sh

#Nick Hollman
#Mod 05 Homework

# clear so the Welcome screen is the first thing you see when you run the script
clear

# create static variables just like in Python code 
SODA_BASE_PRICE=100
payment=0
balance=0

# create price variance which is a random variable between -3,3 * 5
# -1 * 5 = -5, 2 * 5 = 10, 3 * 5 = 15
# we use RANDOM%7 because that will give us a number between 0-6
# we then subtract 3 to get us a number between -3 and 3
random_int=$(((RANDOM%7)-3))
# the price variance below will turn -3 - 3 to -15 - 15
price_variance=$(($random_int*5))
# now  create soda_price (base +/- variance)
soda_price=$((  $SODA_BASE_PRICE + $price_variance ))

echo -e "Welcome to the soda machine. You can enter values of 5, 10 or 25 in payment.\n"
read -p "What type of soday would you like? " soda_type

#clear for readability
echo -e "\nThe current price of $soda_type is $soda_price cents\n"

while true;
do
  # I inserted the payment under all other than invalid so the
  # invalid payment would not count toward the balance
  read -p "Enter a coin: " coin
  if [ $coin -eq 5 ];then
    echo "You have inserted a nickel."
    payment=$(( $payment + $coin ))
  elif [ $coin -eq 10 ];then
    echo "You have inserted a dime."
    payment=$(( $payment + $coin ))
  elif [ $coin -eq 25 ];then
    echo "You have inserted a quarter."
    payment=$(( $payment + $coin ))
  else
    echo -e "That is not a valid amount." 
  fi
  balance=$(( $soda_price - $payment ))
  if [[ $balance -gt 0 ]];then
      echo -e "You still owe $balance cents.\n"
  elif [[ $balance -lt 0 ]];then
      abs_balance=$((balance*-1))
      echo -e "\nYou have been refunded $abs_balance cents."
      echo -e "\nYour $soda_type is being dispensed. Thank you!\n"
      break
  else
      echo -e "\nYour $soda_type is being dispensed. Thank you!\n"
      break
  fi
done
read -p "Press the enter key to close the script"
