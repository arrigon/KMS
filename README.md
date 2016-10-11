# KMS

Welcome to the KMS script collection! In short, KMS clusters individuals according to their genotypes. Any presence/ absence or SNP dataset is suitable for the analysis. Just contact me if you need further help.

These scripts are provided to your convinience; and WITHOUT guarantee.
If you use this script; please cite the following article:

http://onlinelibrary.wiley.com/doi/10.1111/j.1469-8137.2010.03328.x/full


The following repository contains:

1. STR2.2.P287ind167loc.txt
Demo file, AFLP dataset, 
ready to be inputted in STRUCTURE (haploid coding, one line = one individual, first column = populations)


2. Script1_KMN_a.r

This short script shows how to import data (AFLPs, file formatted as for STRUCTURE) and run the Kmeans function.
BEFORE running it, make sure that the working directory of R is properly set,
to check it; prompt the following command:

getwd()

if the path is not correct:

setwd("MyGoodPath")


3. KMNruns.r
The Kmeans function, this file must be in the same directory as the previous one. It is called by the previous script and should not be modified.
This function will produce several files:
- 'KMNruns10000A.txt' = results of clustering, only the replicate that maximises the inter-group inertia is kept
			(first line = inter-group inertia of this best run, remaining lines = individuals, columns = groupings obtained for each K value)
- 'KMNruns_distri10000A.txt' = all inertia values obtained during the replicates, useful to compute the SD of inertia for each K value
- 'KMNruns_Inertia_SD_10000A.txt' = The inertia SD of each K value
- pdfs of Inertia ~ K value and Second derivative of inertia ~ K value


4. DiagGraphs.xls
Example of how the outputs of the Kmeans function can be used to
decide what K value might be optimal (similar to the Evanno et al.'s strategy for Structure)


Good luck!
Nils ARRIGO


NB this project is finished and might not evolve much in a near future.

