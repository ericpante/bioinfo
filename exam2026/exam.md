# 2026 final exam

**Prerequisites:** the terminal basics from `0_terminal.md` (navigation, redirection, pipes, globbing, variables, `grep`, `sed`, scripts).
**Tools allowed:** bash and the commands seen in class. A few `awk` one-liners are *given* to you (marked **awk**): you do not need to understand `awk` yet, only to use it.
**Time:** about 3 h.

---

## 0. Data

- create a `data` folder in your $HOME
- create a `work` folder in your $HOME
- get the dummy dataset from GitHub and place it in `data/`: 

| File(s) | What it is |
|---|---|
| `popA_ind01.fastq` ... `popA_ind03.fastq` | RAD-seq reads of 3 individuals from population A |
| `popB_ind01.fastq` ... `popB_ind03.fastq` | RAD-seq reads of 3 individuals from population B |
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
