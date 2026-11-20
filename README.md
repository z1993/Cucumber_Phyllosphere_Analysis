# Cucumber_Phyllosphere_Analysis
Core R scripts for analyzing cucumber phyllosphere microbiome, including diversity, indicator species, and co-occurrence networks.
# Complete Analysis Pipeline for Cucumber Phyllosphere Microbiome

## Description
This repository contains the complete R scripts and analytical pipelines used in the study *"Exploring phyllosphere microbiomes and their responses to powdery mildew in cucumber"*. 

The scripts cover standard statistical workflows and visualization for:
*   **Alpha/Beta diversity calculation** (Chao1, Shannon, Pielou's evenness, Faith's PD, Bray-Curtis via `vegan` and `picante`)
*   **Community structure analysis** (PCoA and PERMANOVA/Adonis via `vegan`)
*   **Indicator species analysis** (via `indicspecies`)
*   **Microbial co-occurrence networks** (Spearman correlation using `Hmisc`, network and module construction using `igraph`)

These scripts are provided to support the full reproducibility of the main statistical findings reported in the manuscript.

## Data Availability
The raw sequencing data and processed OTU tables are publicly available at the NCBI Sequence Read Archive (SRA):
*   Bacterial sequence data: **PRJNA1379487**
*   Fungal sequence data: **PRJNA1380014**
*   Re-sequencing data: **PRJNA1031793**

Source data for Figures 1–8 are provided in Supplementary Data 11 of the manuscript.

## Running the Code
1. Ensure you have R (>= 4.0.5) installed.
2. Install required packages: `vegan`, `picante`, `indicspecies`, `Hmisc`, `igraph`, `ape`, `ggplot2`.
3. Place your OTU table, metadata, and phylogenetic tree (if applicable) in the working directory.
4. Run the `Core_analysis_pipeline.R` script. Note that file paths and specific grouping column names in the script may need to be adjusted to match your local dataset.
