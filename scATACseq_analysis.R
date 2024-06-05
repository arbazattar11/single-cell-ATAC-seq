# Step 4: Move to R for downstream analysis with Seurat and Signac
cat <<EOF > ${OUTPUT_DIR}/analyze_scATAC.R
# Load necessary libraries
library(Signac)
library(Seurat)
library(GenomicRanges)
library(BSgenome.Hsapiens.UCSC.hg19) # Change according to your reference genome
library(ggplot2)

# Load Cell Ranger output
input_dir <- "${OUTPUT_DIR}/cellranger_output/${SAMPLE_NAME}/outs"
fragments <- Read10X_h5(paste0(input_dir, "/filtered_peak_bc_matrix.h5"))
metadata <- read.csv(paste0(input_dir, "/singlecell.csv"), header = TRUE, row.names = 1)

# Create a Seurat object
atac <- CreateSeuratObject(counts = fragments, assay = "peaks", meta.data = metadata)

# Quality control
atac <- NucleosomeSignal(object = atac)
atac <- TSSEnrichment(object = atac)
atac <- subset(x = atac, subset = nCount_peaks > 500 & nCount_peaks < 20000 & nucleosome_signal < 2 & TSS.enrichment > 2)

# Normalization and Dimensionality Reduction
atac <- RunTFIDF(atac)
atac <- FindTopFeatures(atac, min.cutoff = "q0")
atac <- RunSVD(atac)
atac <- RunUMAP(atac, reduction = 'lsi', dims = 2:30)

# Save the processed object
saveRDS(atac, file = "${OUTPUT_DIR}/atac_processed.rds")

# Plot UMAP
DimPlot(atac, reduction = "umap")
ggsave(filename = "${OUTPUT_DIR}/UMAP_plot.png")

EOF

# Run the R script
Rscript ${OUTPUT_DIR}/analyze_scATAC.R
