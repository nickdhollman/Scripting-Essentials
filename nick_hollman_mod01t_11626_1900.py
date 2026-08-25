# Nick Hollman
# Tutorial 1

print('\nTask 1')
print('Hello World')

print('\nTask 2')
user_guess = input('Please enter an integer: ')
print(user_guess)

print('\nTask 3')
user_guess = int(user_guess)
converted_user_guess = int(user_guess)
print(user_guess * 3)
print(converted_user_guess * 3)

user_guess = str(user_guess)
print(user_guess * 3)

print('I entered ' + user_guess)
# the below line results in an error
# print('I entered ' + converted_user_guess)

print('\nTask 4')
for i in range(1, 21, 1):
    if i == 7:
        print('Snowflake')
    elif (i % 2) == 0:
        print('Even')
    else:
        print('Odd')

print('\nTask 5')
for i in range(1, int(input('Enter a number greater than 13: '))+1, 1):
    if (i) == 7:
        print('Lucky')
    elif (i) == 13:
        print('Unlucky')
    elif (i % 2) == 0:
        print('Even')
    else:
        print('Odd')

print('\nTask 6')
while True:
    user_name = input('Please enter a name (Hollman): ')
    if user_name == 'Hollman':
        break

print('\nTask 7')
counter = 0
while counter < 10:
    print (counter)
    counter += 1

print('\nTask 8')
import random

for i in range(0, 5, 1):
    random_value = random.randint(-10,10)
    print(random_value, end = " ")

print()
print()
print('Press Enter to end the script')

input()
