# Exam_bioinfo : exercice 5

**Exercice 5** : *Create a function to annotate ITS-SSU-LSU RAD loci with blastn*

Ci-dessous le code entier utilisé pour résoudre l'exercice 5. 

````
#!/bin/bash

##Transformation du ".loci" en ".fasta" pour l'individu 1
grep "SRR1754724" $1 | cut -d ' ' -f 6 | sed 's,-,, g' >> fasta1.txt
grep "//" $1 | sed 's,-,,g' | sed 's,*,,g' | tr -s " " | cut -d " " -f 2 >> IDlocus.txt
paste IDlocus.txt fasta1.txt > ID_SEQ
grep "|" ID_SEQ |sed 's,|,>RAD_,' > FASTArad
sed 's,|,\n,' FASTArad > FASTApedicularis

##Comparaison aux bases de données
##Télécharger les bases de données ITS, LSU et SSU puis les dézipper.
tar xvf ITS_eukaryote_sequences.tar
tar xvf LSU_eukaryote_rRNA.tar
tar xvf SSU_eukaryote_rRNA.tar
#Création d'un alias compilant les 3 bases de données utilisées
blastdb_aliastool -dblist "ITS_eukaryote_sequences LSU_eukaryote_rRNA SSU_eukaryote_rRNA" -dbtype nucl -out all_ribosomal -title "all_ribosomal"
blastn -db all_ribosomal -query FASTApedicularis -outfmt 6 -max_target_seqs 1
````

Dans cette section nous commenterons les différentes étapes du code généré ci-dessus.

Pour commencer, nous cherchons à transformer le fichier pedicularis.loci généré via ipyrad en fichier de type .fasta. Pour cela, nous nous basons sur un seul individu (ici l'individu 1) car le blaster nous permettra d'identifier les séquences répétées malgré la présence d'éventuels SNPs. 

````
##Transformation du ".loci" en ".fasta" pour l'individu 1
grep "SRR1754724" $1 | cut -d ' ' -f 6 | sed 's,-,, g' >> fasta1.txt
````

Premièrement, nous gardons uniquement les séquences correspondant à l'individu 1 (*SRRR1754724*). Ensuite, nous définissions 'espace' comme séparateur de colonne, et nous gardons seulement le 6ème champs correspondant aux séquences brutes. Nous choisissons ensuite de retirer les '-' représentant les délétions résultant de l'alignement. Le résultat est stocké dans le fichier 'fasta1.txt'. 

````
grep "//" $1 | sed 's,-,,g' | sed 's,*,,g' | tr -s " " | cut -d " " -f 2 >> IDlocus.txt
````

En parallèle, nous extrayons uniquement les lignes correspondant aux numéros des loci à partir du fichier pedicularis.loci.
Pour cela, nous ne gardons que les lignes d'intérêts commençant par '//'. Nous enlevons les symboles ( - et * ) de ces lignes, pour ne garder que les numéros. Nous procédons aussi au nettoyage des '//' en début de lignes. Le fichier de sortie est nommé 'IDlocus.txt'. 

````
paste IDlocus.txt fasta1.txt > ID_SEQ
````

Nous regroupons les deux fichiers générés précédement (la liste des loci et les séquences correspondantes), via la fonction "paste", au sein du fichier ID_SEQ. 

````
grep "|" ID_SEQ |sed 's,|,>RAD_,' > FASTArad
sed 's,|,\n,' FASTArad > FASTApedicularis
````

Afin de formater correctement le fichier en .fasta, nous devons effectuer quelques transformations à partir du fichier ID_SEQ. A partir des numéros de lignes de type |47|, nous remplaçons la première barre verticale '|' par un premier symbole supérieur suivi du prefixe RAD ('>RAD_'), et la seconde par un retour à la ligne ('\n'). Ces étapes nous permettent d'obtenir le fichier fasta intitulé 'FASTApedicularis'.

````
##Comparaison aux bases de données
##Télécharger les bases de données ITS, LSU et SSU puis les dézipper.
tar xvf ITS_eukaryote_sequences.tar
tar xvf LSU_eukaryote_rRNA.tar
tar xvf SSU_eukaryote_rRNA.tar
````
Concernant l'utilisation des bases de données, il faut, dans un premier temps, télécharger les bases de données ITS, SSU, LSU (eucaryotes) sur le site de la ncbi. Une fois ces bases dézippées (via la fonction 'gunzip') et disponibles dans notre répertoire de travail, nous exécutons la fonction 'tar xvf' pour accéder au contenu des archives. 

````
#Création d'un alias compilant les 3 bases de données utilisées
blastdb_aliastool -dblist "ITS_eukaryote_sequences LSU_eukaryote_rRNA SSU_eukaryote_rRNA" -dbtype nucl -out all_ribosomal -title "all_ribosomal"
````

Pour une histoire de praticité et pour bénéficier d'un plus large éventail de données, nous regroupons les trois bases de données ITS, SSU, LSU, en créant un alias via la fonction 'blastdb_aliastools'. L'alias obtenu se nomme 'all_ribosomal". 

Finalement la ligne de code suivante permet de blaster le fichier FASTApedicularis avec l'alias 'all_ribosomal'. L'argument '-outfmt6' permet de formater le fichier de sortie sous format tableau, tandis que l'argument '-max_target_seqs 1' permet de garder, pour chaque match, uniquement la meilleure correpsondance. Cet argument nous permet d'éviter les répétitions de matchs et de quantifier correctement la proportion de séquences de type ITS dans notre jeu de données. 

````
blastn -db all_ribosomal -query FASTApedicularis -outfmt 6 -max_target_seqs 1
````
Dans notre cas, à partir de notre jeu de données, nous obtenons seulement une seule correspondance. Cette correspondance est faite pour le locus RAD_6619, qui correspond à une séquence ITS de type 5.8S de *Pedicularis chamissonis*. Ce résultat signifie que, sur les 14 804 loci analysés ici, nous obtenons un seul locus correspondant à une séquence d'ITS.

Pour déterminer si ce locus ITS présente davantage d'allèles que les autres loci, nous avons cherché à retrouver ce locus (RAD_6619) dans le tableau "final.txt" généré à l'exercice 4. Cependant, le locus RAD_6619 n'a pas été retenu dans pedicularis.vcf, car possiblement filtré par *ipyrad* en amont, ce qui nous a empêché de dénombrer le nombre d'allèles de cette séquence répétée. 
