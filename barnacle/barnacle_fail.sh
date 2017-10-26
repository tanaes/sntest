#!/bin/bash

snakemake -j 1 --cluster 'qsub -l nodes=1:ppn=1 -l mem=1 -l walltime=00:00:10 ' --cluster-status barnacle/barnacle_status.py