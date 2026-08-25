#! /bin/sh

#Nick Hollman
#Module 6 Homework

#declare and fill the four suits for the deck
declare -a spades_=('Ace_of_Spades' 'King_of_Spades' \
            'Queen_of_Spades' 'Jack_of_Spades' \
            '10_of_Spades' '9_of_Spades' \
            '8_of_Spades' '7_of_Spades' \
            '6_of_Spades' '5_of_Spades' \
            '4_of_Spades' '3_of_Spades' \
            '2_of_Spades')

declare -a diamonds_=('Ace_of_Diamonds' 'King_of_Diamonds' \
            'Queen_of_Diamonds' 'Jack_of_Diamonds' \
            '10_of_Diamonds' '9_of_Diamonds' \
            '8_of_Diamonds' '7_of_Diamonds' \
            '6_of_Diamonds' '5_of_Diamonds' \
            '4_of_Diamonds' '3_of_Diamonds' \
            '2_of_Diamonds')

declare -a clubs_=('Ace_of_Clubs' 'King_of_Clubs' \
            'Queen_of_Clubs' 'Jack_of_Clubs' \
            '10_of_Clubs' '9_of_Clubs' \
            '8_of_Clubs' '7_of_Clubs' \
            '6_of_Clubs' '5_of_Clubs' \
            '4_of_Clubs' '3_of_Clubs' \
            '2_of_Clubs')

declare -a hearts_=('Ace_of_Hearts' 'King_of_Hearts' \
            'Queen_of_Hearts' 'Jack_of_Hearts' \
            '10_of_Hearts' '9_of_Hearts' \
            '8_of_Hearts' '7_of_Hearts' \
            '6_of_Hearts' '5_of_Hearts' \
            '4_of_Hearts' '3_of_Hearts' \
            '2_of_Hearts')

# new deck function
new_deck() {
clear
echo "The deck has been shuffled. Press Enter to continue"
read
clear
spades=(${spades_[*]})
clubs=(${clubs_[*]})
hearts=(${hearts_[*]})
diamonds=(${diamonds_[*]})
}


# draw cards function
card_draw () {
clear
while true;
do
  cards_remaining=$((${#spades[*]} + ${#clubs[*]} + ${#hearts[*]} + ${#diamonds[*]}))
  if [[ $cards_remaining -eq 0 ]];then
    echo
    echo -e "-------------------------------------------------------------"
    echo -e "No more cards remain. Press Enter to return to the main menu."
    echo -e "-------------------------------------------------------------"
    read
    break
  fi
  echo -e "There are $cards_remaining cards left in the deck.\n"
  read -p "How many cards would you like to draw from this deck? (0 to return to the main menu):  " cards_requested
  # below only allows positive integers, similar to ^-?[0-9]+$ as in our tutorial 
  # but taking out the -? for only positive integers
  if [[ $cards_requested =~ ^[0-9]+$ ]];then
    if [[ $cards_requested -eq 0 ]];then
      break
    fi
  else
    clear
    echo "The value must be a postive integer. Press Enter to continue"
    read
    clear
    continue
  fi
  if [[ $cards_requested -gt $cards_remaining ]]; then
    clear
    echo -e "There are $cards_remaining cards left in the deck but you have requested $cards_requested cards\n"
    read -p "Press 1 to select again or 2 to return to the main menu: " user_input
    clear
    if [[ $user_input -eq 1 ]];then
      continue
    else
      break
    fi
  fi
  clear
  echo "Your cards are: "
  echo
  drawn=0
  while [[ $drawn -lt $cards_requested ]];
    do
    suit=$((RANDOM%4))
    if [[ $suit -eq 0 ]];then
      if [[ ${#spades[*]} -eq 0 ]];then
       continue
      fi
      index=$((RANDOM%${#spades[*]}))
      echo "${spades[$index]}" | tr "_" " "
      spades=(${spades[*]:0:$index} ${spades[*]:$(($index + 1))})
      drawn=$((drawn + 1))
    elif [[ $suit -eq 1 ]];then
      if [[ ${#clubs[*]} -eq 0 ]];then
       continue
      fi
      index=$((RANDOM%${#clubs[*]}))
      echo "${clubs[$index]}" | tr "_" " "
      clubs=(${clubs[*]:0:$index} ${clubs[*]:$(($index + 1))})
      drawn=$((drawn + 1))
    elif [[ $suit -eq 2 ]];then
      if [[ ${#hearts[*]} -eq 0 ]];then
       continue
      fi
      index=$((RANDOM%${#hearts[*]}))
      echo "${hearts[$index]}" | tr "_" " "
      hearts=(${hearts[*]:0:$index} ${hearts[*]:$(($index + 1))})
      drawn=$((drawn + 1))
    elif [[ $suit -eq 3 ]];then
      if [[ ${#diamonds[*]} -eq 0 ]];then
       continue
      fi
      index=$((RANDOM%${#diamonds[*]}))
      echo "${diamonds[$index]}" | tr "_" " "
      diamonds=(${diamonds[*]:0:$index} ${diamonds[*]:$(($index + 1))})
      drawn=$((drawn + 1))
    fi
   done
   echo
   read -p "Press Enter to continue"
   clear
done
}

clear
new_deck

while true;
do
  echo
  echo "Welcome to the card deck simulator."
  echo
  echo "Please select from the following options:"
  echo
  echo "        1. Draw a selected number of cards form the current deck"
  echo "        2. Shuffle the current deck of cards"
  echo "        3. Exit"
  echo
  read -p "Option#: " choice

  if [[ $choice -eq 1 ]];then
    card_draw
    clear
  elif [[ $choice -eq 2 ]];then
    new_deck
    clear
  elif [[ $choice -eq 3 ]];then
    break
  else
    clear
    read -p "That is not a valid selection. Press Enter to continue: "
    clear
  fi
done
