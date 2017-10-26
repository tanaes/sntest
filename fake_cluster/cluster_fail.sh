#!/bin/bash

snakemake -j 1 -w 90 --cluster 'bash ' --cluster-status fake_cluster/fake_cluster_status.sh