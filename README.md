# Tabix GTF
For all the people who got sick and tired of opening up GTF files with `pyranges`. After indexing your GTF with `tabix`, you can `pysam` the hell out of the indexed GTF.

## Usage
First, set path to your GTF-of-interest in `gtf` of `config.yaml`. Then fix `run_snakemake.sh` and do the following:
```bash
bash run_snakemake.sh
```
