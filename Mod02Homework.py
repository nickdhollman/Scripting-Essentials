# Nicholas Hollman
# Mod 02 Homework

# imports
import random
import copy
import sys

# variable declarations

spades_tuple = ('Ace of Spades', 'King of Spades', \
            'Queen of Spades', 'Jack of Spades', \
            '10 of Spades', '9 of Spades', \
            '8 of Spades', '7 of Spades', \
            '6 of Spades', '5 of Spades', \
            '4 of Spades', '3 of Spades', \
            '2 of Spades')

diamonds_tuple = ('Ace of Diamonds', 'King of Diamonds', \
            'Queen of Diamonds', 'Jack of Diamonds', \
            '10 of Diamonds', '9 of Diamonds', \
            '8 of Diamonds', '7 of Diamonds', \
            '6 of Diamonds', '5 of Diamonds', \
            '4 of Diamonds', '3 of Diamonds', \
            '2 of Diamonds')

clubs_tuple = ('Ace of Clubs', 'King of Clubs', \
            'Queen of Clubs', 'Jack of Clubs', \
            '10 of Clubs', '9 of Clubs', \
            '8 of Clubs', '7 of Clubs', \
            '6 of Clubs', '5 of Clubs', \
            '4 of Clubs', '3 of Clubs', \
            '2 of Clubs')

hearts_tuple = ('Ace of Hearts', 'King of Hearts', \
            'Queen of Hearts', 'Jack of Hearts', \
            '10 of Hearts', '9 of Hearts', \
            '8 of Hearts', '7 of Hearts', \
            '6 of Hearts', '5 of Hearts', \
            '4 of Hearts', '3 of Hearts', \
            '2 of Hearts')

# functions
## function to get a new deck where each suit is a list

##spades_copy = copy.copy(spades_tuple)
##diamonds_copy = copy.copy(diamonds_tuple)
##clubs_copy = copy.copy(clubs_tuple)
##hearts_copy = copy.copy(hearts_tuple)
##spades_list = list(spades_copy)
##diamonds_list = list(diamonds_copy)
##clubs_list = list(clubs_copy)
##hearts_list = list(hearts_copy)

def new_deck():
    global spades_list, diamonds_list, clubs_list, hearts_list
    spades_copy = copy.copy(spades_tuple)
    diamonds_copy = copy.copy(diamonds_tuple)
    clubs_copy = copy.copy(clubs_tuple)
    hearts_copy = copy.copy(hearts_tuple)
    spades_list = list(spades_copy)
    diamonds_list = list(diamonds_copy)
    clubs_list = list(clubs_copy)
    hearts_list = list(hearts_copy)

## function to draw cards
def draw_cards():

    while True:
        card_balance = len(spades_list) + len(diamonds_list) + len(clubs_list) + len(hearts_list)
        if card_balance == 0:
                print('''\n
-------------------------------------------
No more cards remain. Returning to the menu
-------------------------------------------''')
                return
        print('\nThere are '+ str(card_balance) + ' cards left in this deck.')
        cards_drawn = input('\nHow many cards would you like to draw from the deck?: ')
        if cards_drawn == "":
            break
        try:
            card_check = int(cards_drawn)
        except:
            print('\nEnter a valid integer to continue')
            continue
        if card_check > card_balance:
                print('\nThere are '+ str(card_balance) + ' left in the deck but you have requested ' + str(card_check) + ' cards')
                user_choice = input('Press Enter to select again or Exit to return to the menu: ')
                if user_choice == "":
                    continue
                else:
                    return

        print('\nYour cards are:\n')
        
        while card_check > 0:
                
            suit = random.randint(0, 3)

            if suit == 0:
                if len(spades_list) == 0:
                    continue
                random_draw = random.randint(0, len(spades_list) - 1)
                print(spades_list[random_draw])
                del spades_list[random_draw]
                    
            elif suit == 1:
                if len(diamonds_list) == 0:
                    continue
                random_draw = random.randint(0, len(diamonds_list) - 1)
                print(diamonds_list[random_draw])
                del diamonds_list[random_draw]
                    
            elif suit == 2:
                if len(clubs_list) == 0:
                    continue
                random_draw = random.randint(0, len(clubs_list) - 1)
                print(clubs_list[random_draw])
                del clubs_list[random_draw]
                    
            elif suit== 3:
                if len(hearts_list) == 0:
                    continue
                random_draw = random.randint(0, len(hearts_list) - 1)
                print(hearts_list[random_draw])
                del hearts_list[random_draw]
                        
            card_check -= 1


# Call new deck function
new_deck()
print("\nYou now have a new deck of cards.")

# Menu loop

while True:
    print('''\n        Welcome to the card deck simulator.

        Please select from the following options:

            1. Draw a selected number of cards from the current deck
            2. Get a new deck of cards
            3. Exit
    ''')
    option = int(input('\nOption #: '))
    if option == 1:
        draw_cards()
    elif option == 2:
        new_deck()
        print("\nYou now have a new deck of cards.")
    elif option == 3:
        print('\nexit the script')
        break
    else:
        print('\ninvalid selection text')

print()
print()
print('Press enter to end the script')

input()


















