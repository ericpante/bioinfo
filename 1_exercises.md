# Unix Shell and BASH exercices

## Exercise 1


FASTQ :
```
@SRR1754715.1.1 GRC13_0027_FC:4:1:12560:1179 length=74
TGCAGGAAGGAGATTTTCGNACGTAGTGNNNNNNNNNNNNNNGCCNTGGATNNANNNGTGTGCGTGAAGAANAN
+SRR1754715.1.1 GRC13_0027_FC:4:1:12560:1179 length=74
??????????????????????????????????????????????????????????????????????????
```
FASTA :
```
>SRR1754715.1.1 GRC13_0027_FC:4:1:12560:1179 length=74
TGCAGGAAGGAGATTTTCGNACGTAGTGNNNNNNNNNNNNNNGCCNTGGATNNANNNGTGTGCGTGAAGAANAN
```

ecrire un script en bash (`fichier.sh` qui est exécutable) qui convertit un fichier fastq en fasta
-> input "fastq"
-> output "fasta"
par exemple, en utilisant `grep` et `sed`
utiliser les variables dans le script bash

------------------------------------------------------------------------

## Exercise 2

*utiliser saucisson <-> seitan selon vos préférences.*

1. créer une répertoire qui s'appelle saucisson. 
2. dans saucisson : découper le fichier SRR...fastq en x fichiers de 10,000 séquences chacun. 
3. hors saucisson : écrire un script qui donne le nombre de séquence pour chacun des fichiers de saucisson. 
