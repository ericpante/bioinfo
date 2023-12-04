# Solution for exercice 4, proposed by Rachel and Manon, from the 2023 class

**Exercice 4** : 
*Create a function to parse a vcf file and keep variants according to the number of alleles (a) within individuals, (b) among individuals.*

Ci-dessous le code entier utilisé pour résoudre l'exercice 4. 

````
#!/bin/bash

##loci
tail -n +12 $1 | cut -f 1 >> loci.txt

##variants
tail -n +12 $1 | cut -f 5 >> variants.txt
sed 's/[^,]//g' variants.txt | awk '{ print length +2 }' >> inter.txt 

##individus
tail -n +12 $1 | cut -f 10 | cut -d ':' -f 3 >> individu1.txt
sed 's,10,1,g' individu1.txt | sed 's,20,1,g' | sed 's,30,1,g' | sed 's,40,1,g' |  sed 's,50,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c2 >> intra1.txt
tail -n +12 $1 | cut -f 11 | cut -d ':' -f 3 >> individu2.txt
sed 's,10,1,g' individu2.txt | sed 's,20,1,g' | sed 's,30,1,g' | sed 's,40,1,g' |  sed 's,50,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c2 >> intra2.txt
tail -n +12 $1 | cut -f 12 | cut -d ':' -f 3 >> individu3.txt
sed 's,10,1,g' individu3.txt | sed 's,20,1,g' | sed 's,30,1,g' | sed 's,40,1,g' |  sed 's,50,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c2 >> intra3.txt

##assemble le tout
paste loci.txt intra1.txt intra2.txt intra3.txt inter.txt > collage.txt
( echo -e "LOCUS   IND1   IND2    IND3    ALLELES"; cat collage.txt ) >final.txt

cat final.txt


````
Dans cette section nous commenterons les différentes étapes du code généré ci-dessus.

````
##loci
tail -n +12 $1 | cut -f 1 >> loci.txt
````

Premièrement, nous coupons les douze premières lignes informatives du fichier .vcf. Puis, nous extrayons la première colonne du fichier .vcf, qui comporte les noms des loci, et nous la stockons dans le fichier 'loci.txt'. 

````
##variants
tail -n +12 $1 | cut -f 5 >> variants.txt
sed 's/[^,]//g' variants.txt | awk '{ print length +2 }' >> inter.txt
````
Dans cette section, nous coupons les douze premières lignes du .vcf, nous extrayons la colonne 5 correspondant aux variants interindividuels, puis la stockons dans le fichier 'variants.txt'. Dans ce fichier nous comptons, pour chaque ligne, le nombre de virgules présentes. Ce nombre est ensuite affiché en lui ajoutant +2. En effet, on ajoute systématiquement +1 pour inclure l'allèle de référence (colonne REF du .vcf). On ajoute ensuite une autre fois +1 car la présence d'une virgule révèle l'existence de deux variants alléliques. La colonne ainsi obtenue est stockée dans le fichier 'inter.txt'. 

````
##individus
tail -n +12 $1 | cut -f 10 | cut -d ':' -f 3 >> individu1.txt
sed 's,10,1,g' individu1.txt | sed 's,20,1,g' | sed 's,30,1,g' | sed 's,40,1,g' |  sed 's,50,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c2 >> intra1.txt
````
Ici, après avoir coupé les douzes premières lignes du fichier .vcf, nous extrayons la colonne 10 correspondant aux données génotypiques de l'individu 1. Puis, nous souhaitons conserver uniquement le dénombrement des nucléotides (A,T,G,C). Pour ce faire nous choisissons ":" comme délimiteur de champs, et nous gardons seulement le champs 3 correspondant au dénombrement des nucléotides. Ce résultat est stocké dans le fichier 'individu1.txt'. 

Dans le fichier 'individu1.txt' généré précédement, nous remplaçons les dizaines (de 10 à 50), par des 1, dans le but de ne retenir que les 0 pour chaques lignes, sans que la présence de 10,20,30,.. n'affecte le comptage des valeurs nulles. Ces 0 sont ensuite comptés et correspondent donc à des allèles non présents. Dans l'objectif d'afficher les nombres d'allèles effectivements présents, nous soustrayons 4 (correspondant au maximum de nucléotides) aux nombres de 0 obtenus. Afin de s'affranchir des valeurs négatives nous coupons le premier caractère de chaque ligne. Nous stockons ce résultat dans le fichier 'intra1.txt'. 


````
tail -n +12 $1 | cut -f 11 | cut -d ':' -f 3 >> individu2.txt
sed 's,10,1,g' individu2.txt | sed 's,20,1,g' | sed 's,30,1,g' | sed 's,40,1,g' |  sed 's,50,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c2 >> intra2.txt
tail -n +12 $1 | cut -f 12 | cut -d ':' -f 3 >> individu3.txt
sed 's,10,1,g' individu3.txt | sed 's,20,1,g' | sed 's,30,1,g' | sed 's,40,1,g' |  sed 's,50,1,g' | sed 's/[^0]//g' | awk '{ print length -4 }' | cut -c2 >> intra3.txt

````
Le même processus est répété pour les individus 2 et 3. 

````
##assemble le tout
paste loci.txt intra1.txt intra2.txt intra3.txt inter.txt > collage.txt
( echo -e "LOCUS   IND1   IND2    IND3    ALLELES"; cat collage.txt ) >final.txt
cat final.txt
````

Tous les fichiers .txt générés précédement, sont regroupés dans le fichier 'collage.txt' dans l'odre suivant : Noms des loci, Individu 1, Individu 2, Inidvidu 3, et les variants interindividuels. 
La fonction "echo" permet ensuite d'ajouter le nom des colonnes, pour obtenir le fichier final 'final.txt'. L'ensemble du fichier 'final.txt' peut être affiché via la fonction "cat". 


Afin d'identifier les locus pour lesquels la richesse génétique intraindividuelle est supérieure à 2, nous pouvons effectuer la ligne de code suivante, et regarder dans les colonnes de chaque individu les valeurs affichées en rouge. 
````
grep '3' final.txt
````
Nous pouvons observer que, pour certain loci, la richesses génétique intraindividuelle est effectivement supérieure à 2 (ex : RAD_14793, individu 3). 

A noter cependant, qu'une telle situation est, le plus souvent, corrigée lors de l'analyse. Par exemple pour RAD_14793, l'individu 3, malgré l'occurence de 3 allèles différents, est considéré comme homozygote et la présence des deux autres allèles (détectés une seule fois) est négligée car considérée comme une erreur. 
