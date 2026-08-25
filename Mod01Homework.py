# Nick Hollman
# Mod 01 Homework

print('Welcome to the soda machine. You can enter values of 5, 10, or 25 in payment')
soda = input('What type of soda would you like? ')
PRICE = 100
total_payment = 0
import random
for i in range(0, 6, 1):
    random_value = random.randint(-3, 3)
    price_variance = random_value * 5
    soda_price = PRICE + price_variance
    print('The current price of ' + soda + ' is ' + str(soda_price) + ' cents')
    while True:
        payment = input('Enter a coin: ')
        total_payment = int(payment) + int(total_payment) 
        balance = int(soda_price) - int(total_payment)
        if balance > 0:
            print('You still owe ' + str(balance) + ' cents')
        elif balance < 0:
            print('You have been refunded ' + str(abs(balance)) + ' cents.')
            print('Enjoy your ' + soda + '!')
            break
        else:
            print('You still owe ' + str(balance) + ' cents')
            print('Enjoy your ' + soda + '!')
            break
    break

input()
    
    
