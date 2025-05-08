# Basic Community Analyses

This repository comes from the online workshop, Introduction to Ecological Data Analysis using R. I designed and taught this workshop for students of the bachelor's degree in resource management at the Universidad Tecnológica de Calakmul in México.

The main objective of the course was to provide students with the most relevant tools to analyze ecological data using the free software R, with a focus on natural resource management. Specifically, this repository focuses on some basic community analysis, such as rank-abundance curves and taxonomic diversity using the Hill numbers. As the intention was for undergraduate students, the scripts are commented in a guideline fashion so they can be easier to follow and understand.

## Rank-Abundance Curves (rankabundance.R)

This script uses the *mariposas.csv* file. The data from this file is fictitious and comes from an in-class exercise. The data has one site and twelve species. The main function of the script is to visualize rank-abundance curves using ggplot. For this reason, the output is a rank-abundance graph in TIFF format. 

## Taxonomic Diversity (diversity.R)
This script uses the *aves.csv* file. Again, this information is fictitious and comes from an in-class exercise. The data has four sites and seven bird species. As it must be in every study, the first part of the script gives the sample completeness in a CSV format. The second part performs the taxonomic diversity analysis using the iNEXT function and plots a graph with the three q-diversity orders. The output of this script is the completeness and diversity files (CSV) and a graph in TIFF format. 
