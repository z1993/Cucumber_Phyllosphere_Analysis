# ==============================================================================
# Core Analysis Pipeline for Cucumber Phyllosphere Microbiome
# 
# Manuscript: "Exploring phyllosphere microbiomes and their responses to 
#             powdery mildew in cucumber"
#
# Note: This script provides the core analytical workflow corresponding to the 
# "Statistical analysis" section of the manuscript. It uses standard, publicly 
# available R packages to demonstrate the reproducibility of the main results. 
# Highly customized plotting scripts and specific data-cleaning steps are not 
# included due to collaborator IP agreements.
# ==============================================================================

# 1. Load required packages
# ------------------------------------------------------------------------------
# Please install these packages if they are not already installed:
# install.packages(c("vegan", "indicspecies", "Hmisc", "igraph", "picante", "ape"))

library(vegan)
library(indicspecies)
library(Hmisc)
library(igraph)
library(picante)
library(ape)

# 2. Data Loading (Example)
# ------------------------------------------------------------------------------
# Note: Replace with your actual data files
# otu_table <- read.csv("otu_table.csv", row.names = 1)
# metadata <- read.csv("metadata.csv", row.names = 1)

# Ensure OTU table is transposed for vegan functions (samples in rows, taxa in columns)
# otu_t <- t(otu_table)

# Ensure sample names match between OTU table and metadata
# otu_t <- otu_t[rownames(metadata), ]

# 3. Alpha Diversity Calculation
# ------------------------------------------------------------------------------
# Calculate Chao1 index and Observed OTUs using vegan::estimateR
# alpha_div <- estimateR(otu_t)
# chao1 <- alpha_div["S.chao1", ]

# Calculate Shannon index
# shannon <- diversity(otu_t, index = "shannon")

# Calculate Pielou's evenness (Shannon / ln(Observed Species))
# pielou <- shannon / log(alpha_div["S.obs", ])

# Calculate Faith's Phylogenetic Diversity (Requires picante and a phylogenetic tree)
# tree <- read.tree("tree.nwk")
# faith_pd <- pd(otu_t, tree, include.root = FALSE)$PD

# 4. Beta Diversity and Community Structure
cat("Calculating Beta Diversity...\n")

# Bray-Curtis distance matrix
bray_dist <- vegdist(otu_t, method = "bray")

# PCoA (Principal Coordinate Analysis)
pcoa_res <- cmdscale(bray_dist, k = 2, eig = TRUE)
pcoa_df <- data.frame(
  PCoA1 = pcoa_res$points[, 1],
  PCoA2 = pcoa_res$points[, 2],
  Group = group_vec
)
# Plot PCoA
p_pcoa <- ggplot(pcoa_df, aes(x = PCoA1, y = PCoA2, color = Group)) +
  geom_point(size = 3) +
  theme_bw() +
  labs(title = "PCoA of Bray-Curtis Distance")

# PERMANOVA (Adonis test)
adonis_res <- adonis2(bray_dist ~ group_vec, permutations = 999)
# print(adonis_res)
# 5. Indicator Species Analysis
# ------------------------------------------------------------------------------
# Use indicspecies package to identify indicator taxa for different ecotypes
# set.seed(123)
# indval_res <- multipatt(otu_t, metadata$Ecotype, 
#                         control = how(nperm = 999), 
#                         func = "IndVal.g")
# summary(indval_res)

# 6. Co-occurrence Network Construction
# ------------------------------------------------------------------------------
# Calculate pairwise Spearman correlations using Hmisc package
# cor_res <- rcorr(t(otu_t), type = "spearman")
# cor_matrix <- cor_res$r
# p_matrix <- cor_res$P
# Apply thresholding: keep correlations with |R| > 0.85 and p < 0.05 (as stated in the manuscript)
# keep_matrix <- (abs(cor_matrix) > 0.85) & (p_matrix < 0.05)
# Construct network using igraph
# adj_matrix <- keep_matrix * cor_matrix
# network <- graph_from_adjacency_matrix(adj_matrix, mode = "undirected", weighted = TRUE, diag = FALSE)

# Identify modules using greedy optimization
# set.seed(123)
# modules <- cluster_fast_greedy(network)

# Save network edge list for reproducibility
# write.csv(as_data_frame(network), "network_edges.csv", row.names = FALSE)

# ==============================================================================
# END OF SCRIPT
# ==============================================================================
