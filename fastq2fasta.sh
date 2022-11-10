#!/bin/bash
grep -A1 "@SRR*" $1 | sed 's/@SRR/>SRR/g' | sed '/--/d'
