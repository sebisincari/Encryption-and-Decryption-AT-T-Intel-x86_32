# Conway’s Game of Life 
Conway’s Game of Life este unzero-player gamebidimensional, inventat de matematicianul John
Horton Conway in anul 1970. Scopul acestui joc este de a observa evolutia unui sistem de celule,
pornind de la o configuratie initiala, introducand reguli referitoare la moartea, respectiv crearea unei
noi celule in sistem. Acest sistem evolutiv esteTuring-complete.
Starea unui sistem este descrisa de starea cumulata a celulelor componente, iar pentru acestea
avem urmatoarele reguli:

1.Subpopulare. Fiecare celula (care este in viata in generatia curenta) cu mai putin de doi
vecini in viata, moare in generatia urmatoare.

2.Continuitate celule vii.Fiecare celula (care este in viata in generatia curenta), cu doi sau
trei vecini in viata, va exista si in generatia urmatoare.

3.Ultrapopulare.Fiecare celula (care este in viata in generatia curenta), care are mai mult de
trei vecini in viata, moare in generatia urmatoare.

4.Creare.O celula moarta care are exact trei vecini in viata, va fi creata in generatia urmatoare.

5.Continuitate celule moarte. Orice alta celula moarta, care nu se incadreaza in regula de
creare, ramane o celula moarta.

Vecinii unei celule se considera urmatorii 8, intr-o matrice bidimensionala:

```
00          01          02
10    celula curenta    12
20          21          22
```

Definim starea unui sistem la generatianca fiind o matriceSn∈Mm×n({ 0 , 1 }) (m- numarul de
linii, respectivn- numarul de coloane), unde elementul 0 reprezinta o celula moarta, respectiv 1
reprezinta o celula in viata (in generatia curenta).
Definim ok-evolutie (k≥0) a sistemului o iteratieS 0 → S 1 → ··· → Sk, unde fiecareSi+1se
obtine dinSi, aplicand cele cinci reguli enuntate mai sus.
Observatie.Pentru celulele aflate pe prima linie, prima coloana, ultima linie, respectiv ultima
coloana, se considera extinderea la 8 vecini, prin considerarea celor carenuse afla in matrice ca
fiind celule moarte.
Exemplificare.Fie urmatoarea configuratie initialaS 0 :

```
0 1 1 0
1 0 0 0
0 0 1 1
```

In primul rand, vom considera extinderea acestei matriceS 0 de dimensiuni 3 × 4 intr-o matrice
extinsaS 0 de dimensiuni 5 × 6 , astfel:

```
0 0 0 0 0 0
0 0 1 1 0 0
0 1 0 0 0 0
0 0 0 1 1 0
0 0 0 0 0 0
```

In cele ce urmeaza, vom lucra doar in interiorul matricei principale, dar considerand extinderea
pentru procesarea corecta a vecinilor. Vom parcurge fiecare element, si vom vedea ce regula evolutiva
putem aplica. De exemplu, pentru elementul de pe pozitia(0,0)in matricea initiala, vom aplica
regula de continuitate a celulelor moarte, deoarece este o celula moarta si nu are exact trei vecini in
viata.
Urmatoarea celula este in viata, si are exact doi vecini in viata, astfel ca se aplica regula conti-
nuitatii celulelor in viata.
Pentru celula de pe pozitia(0,2)inS 0 , observam ca are un singur vecin, astfel ca se aplica
regula de subpopulare - celula va muri in generatia urmatoare.
Urmand acelasi rationament pentru toate celulele, configuratia sistemului intr-o iteratie (inS 1 )
va fi:

```
0 0 0 0 0 0
0 0 1 0 0 0
0 0 0 0 1 0
0 0 0 0 0 0
0 0 0 0 0 0
```

# Schema de criptare simetrica.

<img src="./encrypt.gif" width="75%"/>

Definim o cheie de criptare (pornind de la o configuratie
initialaS 0 si ok-evolutie) ca fiind operatia<S 0 , k >, care reprezinta tabloulunidimensionalde
date (inteles ca sir de biti) obtinut in urma concatenarii liniilor din matrice din matricea extinsa
obtinuta,Sk.
De exemplu, pornind de la configuratia anterioaraS 0 , si aplicand doar o 1-evolutie, se obtine
matricea extinsaS 1 descrisa anterior, care va avea ca efect al aplicarii operatiei<S 0 , 1 >obtinerea
urmatorului tablou unidimensional (inteles ca sir de biti):

```
0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
```

Considerammun mesaj in clar (un sir de caractere fara spatii). Criptarea{m}<S 0 ,k>va insemna
XOR-area mesajului in clarmcu rezultatul dat de<S 0 , k >. Sunt urmatoarele cazuri:

- daca mesajul si cheia au aceeasi lungime, se XOR-eaza element cu element, pana se obtine
  rezultatul;
- daca mesajul este mai scurt decat cheia, se foloseste doar prima parte din cheie, corespunza-
  toare lungimii mesajului;
- daca mesajul este mai lung decat cheia, se considera replicarea cheii de oricate ori este nevoie
  pentru a cripta intreg mesajul.

Consideram cam=parola, si utilizam drept cheie<S 0 , 1 >, undeS 0 este configuratia initiala
descrisa anterior. Am vazut ca rezultatul obtinut este sirul de biti:

```
0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
```

pe care il vom considera fara spatii:

```
000000001000000010000000000000
```

Pentru a efectua criptarea, trebuie sa analizam sirul de criptat, si anumeparola. Vom vedea
care este codificarea ASCII (binara) a fiecarui caracter din acest sir:

```
p 01110000
a 01100001
r 01110010
o 01101111
l 01101100
a 01100001
```

Sirulparolava fi, astfel, sirul binar

```
011100000110000101110010011011110110110001100001
```

Observam, in acest caz, ca sirul de criptat este mai lung decat cheia de criptare, astfel ca daca
incercam acum o XOR-are, am avea urmatoarea situatie:

```
mesaj = 011100000110000101110010011011110110110001100001
cheie = 000000001000000010000000000000
```

```
Vom considera, in acest caz, ca vom concatena iar cheia la cheia initiala:
```

```
mesaj = 011100000110000101110010011011110110110001100001
cheie = 000000001000000010000000000000000000001000000010000000000000
```

Iar apoi vom pastra din noua cheie doar cat ne este suficient pentru a cripta mesajul:

```
mesaj = 011100000110000101110010011011110110110001100001
cheie = 000000001000000010000000000000000000001000000010
```

Mesajul criptat se va obtine prin XOR-are element cu element, stiind ca0 XOR 0 = 1 XOR 1 =
0 , respectiv0 XOR 1 = 1 XOR 0 = 1. In acest caz,

```
mesaj = 011100000110000101110010011011110110110001100001
cheie = 000000001000000010000000000000000000001000000010
cript = 011100001110000111110010011011110110111001100011
```

Mesajul criptat afisat va fi in hexadecimal (pentru a nu fi probleme de afisare a caracterelor), iar
in acest caz vom avea:

```
cript = 0111 0000 1110 0001 1111 0010 0110 1111 0110 1110 0110 0011
= 7 0 E 1 F 2 6 F 6 E 6 3
= 0x70E1F26F6E
```

Pentru decriptare se aplica acelasi mecanism, mesajul decriptat se va XOR-a cu cheia calculata,
si vom avea in finalm XOR k XOR k = m. (k XOR k = 0, iarm XOR 0 = m, din asociativitatea lui
XOR, respectiv din regulile de calcul). La decriptare, mesajul nu va fi afisat in hexadecimal, ci in
clar.
