# Module 11 Tutorial
# Nick Hollman

cls

$lyrics_string=("Quisiera:Ayer:cambiarle:conocí:el:un:final" +
               ":cielo:al:sin:cuento|Las:sol|Y:barras:un:y" +
               ":hombre:los:sin:tragos:suelo|Un:han:santo:" +
               "sido:en:testigo|De:prision|Y:el:una:dolor:" +
               "canción:que:triste:me:sin:causaste:dueño|Y:" +
               "y:conocí:to':tus:lo:ojos:que:negros|Y:hiciste" +
               ":ahora:conmigo|Un:sí:infeliz:que:en:no:el:" +
               "puedo:amor,:vivir:que:sin:aun:ellos:no:yo|" +
               "Le:te:pido:supera|Que:al:ahora:cielo:camina" +
               ":solo:solo:un:sin:deseo|Que:nadie:en:por:tus" +
               ":todas:ojos:las:yo:aceras|Preguntándole:pueda" +
               ":a:vivir|He:Dios:recorrido:si:el:en:mundo:verdad" +
               ":entero|te:el:vengo:amor:a:existe|:decir|") 

#Initializations
$lyrics = @();
$song1 = @();
$song2 = @();
$duplicates = @();


#Make the array from the string
$lyrics += $lyrics_string.Split(":")

#one loop to split this into two strings
for ($i=0; $i -lt $lyrics.length; $i += 2)
{
    $song1 += $lyrics[$i] 
    $song2 += $lyrics[$i + 1]
}

#Build the song lyrics and print for the first song
foreach ($i in $song1)
{
    $song1_print += $i + " "
}

#Build the song lyrics and print for the first song
foreach ($i in $song2)
{
    $song2_print += $i + " "
}

#Break the lines up for both songs
$song1_print = $song1_print -replace "\|", "`r`n"
$song2_print = $song2_print -replace "\|", "`r`n"

#Print the lyrics for both songs
write-host $song1_print
write-host $song2_print

#Untangle the strings in song1 with | - break these words up and make them lower case
$song1_lower = @()
$tangled_pair = @()
foreach ($i in $song1)
{
    if ($i.Contains("|"))
    {
        $tangled_pair = $i.Split("|")
        if ($tangled_pair[0].Length -ne 0)
        {
            $song1_lower += $tangled_pair[0].ToLower();
        }
        if ($tangled_pair[1].Length -ne 0)
        {
            $song1_lower += $tangled_pair[1].ToLower();
        }
    }
    # if string does not contain | then just add it to the song
    else
    {
        $song1_lower += $i.ToLower();
    }
}

#Untangle the strings in song2 with | - break these words up and make them lower case
$song2_lower = @()
$tangled_pair = @()
foreach ($i in $song2)
{
    if ($i.Contains("|"))
    {
        $tangled_pair = $i.Split("|")
        if ($tangled_pair[0].Length -ne 0)
        {
            $song2_lower += $tangled_pair[0].ToLower();
        }
        if ($tangled_pair[1].Length -ne 0)
        {
            $song2_lower += $tangled_pair[1].ToLower();
        }
    }
    # if string does not contain | then just add it to the song
    else
    {
        $song2_lower += $i.ToLower();
    }
}

#Collect duplicates into song3
$song3 = @()
foreach ($j in $song1_lower)
{
    if ($song2_lower.Contains($j))
    {
        if (-Not $song3.Contains(($j.toLower())))
        {
            $song3 += $j.ToLower()
        }
    }
}

$song3 = $song3 | sort
write-host $song3

write-host
Read-host "Press Enter to exit script"



















