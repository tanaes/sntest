#!/bin/bash

snakemake -j 1 -w 90 --cluster 'qsub -l nodes=1:ppn=1 -l mem=1 -l walltime=00:00:10 -o /dev/null -e /dev/null ' --cluster-status barnacle/barnacle_status.py
