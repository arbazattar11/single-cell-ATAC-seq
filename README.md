# Single-Cell ATAC-seq Analysis Pipeline

This repository contains a script for analyzing single-cell ATAC-seq (scATAC-seq) data using commonly used bioinformatics tools. The workflow includes preprocessing, quality control, and downstream analysis steps.

## Overview

The analysis pipeline performs the following steps:
1. Quality control of raw sequencing reads using FastQC and MultiQC.
2. Preprocessing of scATAC-seq data using Cell Ranger ATAC.
3. Downstream analysis in R using the Seurat and Signac packages, including quality control, normalization, and dimensionality reduction.

## Requirements

### Software
- [Cell Ranger ATAC](https://support.10xgenomics.com/single-cell-atac/software/overview/welcome)
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [MultiQC](https://multiqc.info/)
- R with the following packages:
  - Seurat
  - Signac
  - GenomicRanges
  - BSgenome.Hsapiens.UCSC.hg19 (or other reference genome packages)
  - ggplot2

### Data
- Raw FASTQ files from scATAC-seq experiments.
- Reference genome for alignment.

## Setup

1. Install the required software tools.
2. Ensure R and the necessary R packages are installed.
3. Prepare your raw FASTQ files and reference genome.

## Usage

1. Clone this repository or download the script.

```
git clone https://github.com/arbazattar11/single-cell-ATAC-seq
cd single-cell-ATAC-seq
```

2. Modify the variables in the script (`scATACseq_analysis.sh`) to match your data and paths:
    - `SAMPLE_NAME`: Name of your sample.
    - `FASTQ_DIR`: Directory containing the raw FASTQ files.
    - `OUTPUT_DIR`: Directory where output files will be saved.
    - `REF_GENOME`: Path to the reference genome.
    - `CELLRANGER_ATAC`: Path to the Cell Ranger ATAC executable.

3. Make the script executable:

```bash
chmod +x scATACseq_analysis.sh
```

4. Run the script:

```bash
./scATACseq_analysis.sh
```

## Script Details

### scATACseq_analysis.sh

This bash script performs the following steps:

1. **FastQC**: Runs quality control checks on raw sequence data.
2. **MultiQC**: Aggregates FastQC reports into a single report.
3. **Cell Ranger ATAC**: Processes raw reads, performs alignment, and generates count matrices.
4. **R Analysis**: Analyzes the processed data using Seurat and Signac in R, performing quality control, normalization, and dimensionality reduction.

### analyze_scATAC.R

This R script is embedded within the bash script and performs the following steps:

1. Loads the processed data from Cell Ranger ATAC.
2. Performs quality control using nucleosome signal and TSS enrichment.
3. Normalizes the data and performs dimensionality reduction using UMAP.
4. Saves the processed Seurat object and generates a UMAP plot.

## Output

The script generates several output files and directories:
- `fastqc/`: Directory containing FastQC reports.
- `multiqc_report.html`: Aggregated report from MultiQC.
- `cellranger_output/`: Directory containing Cell Ranger ATAC output.
- `atac_processed.rds`: Processed Seurat object saved as an RDS file.
- `UMAP_plot.png`: UMAP plot visualizing the scATAC-seq data.

## Troubleshooting

If you encounter any issues, ensure that:
- All paths and filenames are correct.
- All required software tools are installed and accessible.
- The R packages are correctly installed and loaded.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [10x Genomics](https://www.10xgenomics.com/) for Cell Ranger ATAC.
- [Babraham Bioinformatics](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) for FastQC.
- [MultiQC](https://multiqc.info/) for aggregating QC reports.
- [Satija Lab](https://satijalab.org/) for Seurat and Signac packages.

## Contact

For any questions or issues, please contact [Arbaz] at [arbazattar1137@gmail.com].
