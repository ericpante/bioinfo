# 2026 final exam

**Prerequisites:** the terminal basics from `0_terminal.md` (navigation, redirection, pipes, globbing, variables, `grep`, `sed`, scripts).
**Tools allowed:** bash and the commands seen in class. A few `awk` one-liners are *given* to you (marked **awk**): you do not need to understand `awk` yet, only to use it.
**Time:** about 2h but and extra 1h for (3h) ; you have until Monday Nov16, 5PM. 

---

## 0. Data

- create a `data` folder in your $HOME
- create a `work` folder in your $HOME
- get the dummy dataset from GitHub and place it in `data/`: 

| File(s) | What it is |
|---|---|
| `popA_ind01.fastq` ... `popA_ind03.fastq` | fake RAD-seq reads of 3 individuals from population A |
| `popB_ind01.fastq` ... `popB_ind03.fastq` | fake RAD-seq reads of 3 individuals from population B |
| `macoma_cox1.fasta` | COX1 haplotypes of *Macoma balthica* (FASTA, sequences wrapped on several lines) |

Filenames follow the pattern `population_individual.fastq`. This is not an accident: the name carries information that you will extract with `cut`.

**Good habits (they will be checked):**

1. Every script starts with `#!/bin/bash` and a comment line explaining its usage.
2. Make your scripts executable: `chmod a+x myscript.sh`, then run them with `./myscript.sh`.
3. Never edit the raw files in `data/`. Write your results in new files and place them in `work`.
4. Test on **one** file first, then loop over all of them.
5. Always put variables between double quotes: `"$f"`.

---

## Toolbox

| I want to... | Use |
|---|---|
| count lines | `wc -l < file` |
| arithmetic | `$(( 8 / 4 ))` |
| store the output of a command | `n=$(wc -l < file)` |
| loop over files | `for f in *.fastq ; do ... done` |
| loop over arguments | `for f in "$@" ; do ... done` |
| first argument / drop it | `$1` / `shift` |
| split a name on `_` and keep field 1 | `echo "$f" \| cut -d '_' -f 1` |
| keep matching lines / count them | `grep "pattern" file` / `grep -c "pattern" file` |
| invert a match | `grep -v "pattern" file` |
| keep one extra line after a match | `grep -A1 "pattern" file` |
| replace text | `sed 's/old/new/'` |
| delete lines matching a pattern | `sed '/pattern/d'` |
| print line number *n* only | `sed -n "${n}p" file` |
| first *n* lines | `head -n 40 file` |
| tab in `echo` | `echo -e "a\tb"` |
| write / append to a file | `>` / `>>` |

**Two `awk` one-liners you may use (given):**

```bash
awk 'NR%4==2' file.fastq        # keeps only the SEQUENCE line of every FASTQ record
awk 'NR%4==1' file.fastq        # keeps only the NAME line of every FASTQ record
```

---

## Exercise 1: Take inventory of the dataset

**Context:** in population genetics, if one individual has 10 times more reads than another, comparisons between them are biased. Before anything else you must know how many reads each individual has.

1. Look at the first record of `popA_ind01.fastq` with `head`. Identify the four lines.
2. Count the lines of `popA_ind01.fastq`, then compute the number of reads using `$(( ... ))`. Store it in a variable `n` and display it with `echo`.
3. Write a script `ex1_count_reads.sh` that takes **any number of files** as arguments and prints one line per file: `filename  population  number_of_reads`, separated by tabs.
4. Run it on the files of population A only (`popA_*.fastq`), then on all files.
5. How many reads in total for population A? For population B? (Pipe `cat` into `wc -l`.)
6. **Trap.** Run `grep -c "^@" popA_ind01.fastq` and compare with your count. Why is it different? Try `grep -c "^@SRR" popA_ind01.fastq`. What do you conclude about counting reads with `grep`?

> **Think:** which individual has the fewest reads? Would you trust a comparison of its diversity with the others?

---

## Exercise 2: Which individuals look unusable?

**Context:** sequencers write `N` when a base could not be called. Individuals with many `N` are suspicious (poor DNA, failed library).

1. For `popA_ind01.fastq`, extract the sequence lines (**awk** one-liner above) and count how many contain **no** `N` (`grep -v`).
2. Compute the percentage of reads without any `N` (integer arithmetic is fine).
3. Write `ex2_quality_N.sh`: for every file given as argument, print `file  n_reads  n_reads_without_N  percent`. Print a header line first.
4. Run it on all individuals. **Which one would you remove from a population genetic analysis?**

---

## Exercise 3: Check the restriction site

**Context:** in RAD-seq, DNA is cut by a restriction enzyme, so nearly all reads should start with the same short motif. In the *Pedicularis* data of the course this motif is `TGCA`. Reads that do not start with it come from something else (contamination, adapters, a failed digest).

1. Count the reads of `popA_ind01.fastq` whose **sequence** starts with `TGCA`. (`^` anchors a pattern at the start of a line.)
2. Write `ex3_cutsite.sh` taking the **motif as first argument** and the files as the following arguments, for example:
   `./ex3_cutsite.sh TGCA popA_*.fastq`
   (hint: `motif=$1` then `shift`).
3. Output: `file  motif  n_reads_with_motif  percent`.
4. Which individual behaves differently? Give two possible explanations. Is it the same individual as in exercise 2?

---

## Exercise 4: A small test dataset, and archiving

**Context:** you never test a new pipeline on the full dataset. You build a small subsample first, and you archive and compress what you send to collaborators.

1. Create a folder `subsample`.
2. Write `ex4_subsample.sh` taking the number of reads to keep as `$1` and the files as the other arguments. It writes, in `subsample/`, the first *n* reads of each file.
   **Careful:** `head` counts *lines*, and a read is 4 lines. Compute the number of lines in the script.
3. Check your result: `wc -l subsample/*`. Does it match what you asked for?
4. Make a compressed archive `subsample.tar.gz` of the folder with `tar`.
5. Compare `du -h subsample` with `ls -lh subsample.tar.gz`.
6. Compress **a copy** of one full FASTQ file with `gzip` and compare the sizes with `ls -lh`. What is the compression ratio? Why does it matter for a sequencing project with 500 individuals?

---

## Exercise 5: From FASTQ to FASTA

**Context:** many programs need FASTA, which has no quality line.

```
FASTQ                                  FASTA
@read1 ...                             >read1 ...
TGCAGG...                              TGCAGG...
+read1 ...
IIIIII...
```

1. Using `grep -A1`, `sed` and a pipe, produce the FASTA version of `popA_ind01.fastq`.
2. You will see lines made of `--` in your output. Where do they come from, and how do you delete them with a second `sed`?
3. Write `ex5_fq2fa.sh`: `$1` is the input file, and the output file is named like the input but with `.fasta` instead of `.fastq`. (Hint: `${1%.fastq}` removes the suffix.)
4. Convert all the files of population A with a loop.
5. **Check your work:** the number of `>` lines must equal the read count of exercise 1.
6. **Bug hunt:** your script searches for names beginning with `@SRR`. What happens with a file whose read names start with something else? Write a second version, `ex5_fq2fa_robust.sh`, that does not depend on the read names. (Hint: the **awk** one-liners of the toolbox keep lines 1 and 2 of each record.)

---

## Exercise 6: Read the headers of a haplotype FASTA

**Context:** public databases give you sequences with long headers that hold the metadata. Let us extract it.

```
>ENA|AY000001|AY000001.1 Macoma balthica haplotype 29 cytochrome c oxidase subunit I (COX1) gene, partial cds; mitochondrial.
```

1. How many sequences does `macoma_cox1.fasta` contain?
2. Print only the header lines. Then print only the **accession numbers** (field 2 when splitting on `|`).
3. Extract the **haplotype number** with
   `sed 's/.*haplotype \([0-9]*\).*/\1/'`
   (read it aloud: "everything, the word haplotype and a space, then digits that I remember, then everything").
4. Write `ex6_count_seqs.sh` which, for any file given as argument, prints `file contains N sequences`, **whether it is a FASTA or a FASTQ**. It must decide with an `if` on the file name. Test it on `popA_ind01.fastq`, `popA_ind01.fasta` and `macoma_cox1.fasta`.
5. Save a two-column table `accession  haplotype` in a file `haplotypes.tsv`.

---

## Exercise 7: How different are two haplotypes?

**Context:** the simplest measure of divergence between two aligned sequences of equal length is *p*, the proportion of sites that differ: *p = differences / sites*.

**Step 1: put each sequence on one line.** Your FASTA is wrapped, which is inconvenient. Your teacher gives you the script `ex7_unwrap.sh`. Run:

```bash
./ex7_unwrap.sh macoma_cox1.fasta > macoma_1line.fasta
```

and check with `head` that each sequence now fits on one line.

**Step 2: a toy example first.** In the terminal:

```bash
a="ACGTACGT"
b="ACGAACGA"
echo ${#a}          # length of the string
echo ${a:3:1}       # one character, starting at position 3 (counting from 0)
```

Write a `for` loop over positions `0` to `7` that counts the differences between `a` and `b`. You should find 2.

**Step 3: the real thing.** Write `ex7_diff.sh` taking the FASTA file and the numbers of two sequences:
`./ex7_diff.sh macoma_1line.fasta 1 2`

- In a one-line-per-sequence FASTA, sequence *n* is on line 2*n*. Fetch it with `sed -n "${l}p" file`.
- Count the differences with your loop.
- Print: `seq 1 vs seq 2: X differences over L sites`.

**Questions**

- Which two haplotypes are the most similar? The most different? (Loop over the pairs.)
- Why must the sequences be **aligned** and of equal length for this to make sense?

---
