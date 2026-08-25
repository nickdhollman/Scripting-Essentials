# Nick Hollman
# Mod 03 Tutorial

# variable declarations
lyrics_string=("Quisiera:Ayer:cambiarle:conocí:el:un:final"
               ":cielo:al:sin:cuento|Las:sol|Y:barras:un:y"
               ":hombre:los:sin:tragos:suelo|Un:han:santo:"
               "sido:en:testigo|De:prision|Y:el:una:dolor:"
               "canción:que:triste:me:sin:causaste:dueño|Y:"
               "y:conocí:to':tus:lo:ojos:que:negros|Y:hiciste"
               ":ahora:conmigo|Un:sí:infeliz:que:en:no:el:"
               "puedo:amor,:vivir:que:sin:aun:ellos:no:yo|"
               "Le:te:pido:supera|Que:al:ahora:cielo:camina"
               ":solo:solo:un:sin:deseo|Que:nadie:en:por:tus"
               ":todas:ojos:las:yo:aceras|Preguntándole:pueda"
               ":a:vivir|He:Dios:recorrido:si:el:en:mundo:verdad"
               ":entero|te:el:vengo:amor:a:existe|:decir|")

#Task 1 - Use the split method to make a list
lyrics = lyrics_string.split(':')
# print(lyrics_split) - print list to ensure split was successful

#Task 2 - Make a loop to append the list elements into two different list
song1 = []
song2 = []
for i in range(0, len(lyrics), 2):
    song1.append(lyrics[i])
    song2.append(lyrics[i + 1])
#print(song1)
#print(song2)

#Task 3 - Join song1 list items separated by space
song1_print = ' '.join(song1)
# print(song1_print)

#Task 4 - Replace song1 variable created | with new line
song1_print = ' '.join(song1)
song1_print = song1_print.replace('|', '\n')
# print(song1_print)

#Task 5 - Join song2 list items separated by space
song2_print = ' '.join(song2)
# print(song2_print)

#Task 6 - Replace song2 variable created | with new line
song2_print = ' '.join(song2)
song2_print = song2_print.replace('|', '\n')
# print(song2_print)

#Task 7 - strip white space before and after each line in variables above
song1_print = ' '.join(song1)
song1_print = song1_print.replace('|', '\n')
print(song1_print.strip())
print()
print()
song2_print = ' '.join(song2)
song2_print = song2_print.replace('|', '\n')
print(song2_print.strip())

#Task 8 - for loop to make song 3
song3 = []
print('\nWords that are in both songs:')
for j in range(len(song1)):
    try:
        if song1[j] in song2:
            if song1[j] not in song3:
                song3.append(song1[j])
    except:
        continue
#print(song3)

#Task 9 - print out each word in song 3
# the below print statement is what is in the tutorial doc
# but I needed to sort first to get the same print out
song3 = sorted(song3)
for m in range(len(song3)):
    print(song3[m])


print()
print()
input() 











































