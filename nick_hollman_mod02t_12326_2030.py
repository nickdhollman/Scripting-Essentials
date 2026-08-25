# Nick Hollman
# Mod 02 Tutorial

# imports
import random
import copy

# variable declarations
counter = 0
my_list = []
int_list = []

# functions
def rando_insert(thing_being_inserted):
    position = random.randint(0,9)
    my_list.insert(position, thing_being_inserted)


while counter < 10:
    list_item = input('Please enter a word or an number: ')
    my_list.append(list_item)
    counter += 1

#Task 1 - Check the length of the list
print('\nTask 1')

print('This list has 10 items. ' + str(len(my_list) == 10))

#Task 2 - Print the list
print('\nTask 2')
print(my_list)

#Task 3 - swap the first item with the last item in the list then print the list
print('\nTask 3')
first_thing = my_list[0]
my_list[0] = my_list[-1]
my_list[-1] = first_thing
print(my_list)

#Task 4 - Print the first 3 items in the list and the last three items in the list
print('\nTask 4')
print(my_list[0:3], my_list[-3:])

#Task 5 - loop though and print all the times in the list
print('\nTask 5') 
for i in my_list:
    print(i)

#Task 6 - Use an IF statement to check to see if the word "cat" is in the list and let the user know
print('\nTask 6')
if 'cat' in my_list:
    print('There is a cat in my list')
else:
    print('There is no cat in my list')

#Task 7 - Randomly Insert the Name of a Marvel Character in the List
print('\nTask 7')
another_item = input('Please insert the name of a Marvel character: ')
rando_insert(another_item)

#Task 8 - Get the index for Marvel character and print
print('\nTask 8')
print(another_item + ' is at index ' + str(my_list.index(another_item)))

#Task 9 - copy all the integers in the original list to a new list, then sort and print out that list
print('\nTask 9')
for jim in my_list:
    try:
        int(jim)
        int_list.append(int(jim))
    except:
        continue
int_list.sort()
print('These are the integers from the list')
print(int_list)

#Task 10 - convert the original list to a tuple and print the tuple
print('\nTask 10')
my_tuple = tuple(my_list)
print(my_tuple)

#Task 11 - Try and change the first item in the tuple to "cat", but catch the error and print out "Tuples are immutable!"
print('\nTask 11')
try:
    my_tuple[0] = 'cat'
except:
    print('Tuples are immutable!')

#Task 12 - Copy this new list and print the items within each inner list of the outer list
print('\nTask 12')
list_in_list = [[1,2,3],['a','b','c']]
for i in list_in_list:
    for j in i:
        print(j)

print()
print()
print('Press Enter to End the Script')

input()










































