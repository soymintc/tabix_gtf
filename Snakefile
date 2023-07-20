import os
import pandas as pd

CHROMS = [str(c) for c in range(1, 22+1)] + ['X', 'Y']
configfile: "config.yaml"
gtf = config['gtf']

log_dir = config['log_dir']
tmp_dir = config['tmp_dir']
for dir_path in [log_dir, tmp_dir]:
    if not os.path.exists(dir_path):
        os.system(f"mkdir {dir_path}")

rule all:
    input: 
        'results/genes.gtf.gz.tbi',

rule grep_and_sort:
    input:
        gtf=gtf,
    output:
        chrom_gtf=temp(os.path.join(tmp_dir, '{chrom}.gtf')),
    shell: # cat Homo_sapiens.GRCh38.93.gtf | grep -P "^MT\t" | sed 's/^MT/M/g' | sort -k4,5 -n
        'grep -P "^{wildcards.chrom}\t" {input.gtf} | '
        'sort -k4,5 -n > {output.chrom_gtf}'

rule merge_gtf:
    input:
        expand(os.path.join(tmp_dir, '{chrom}.gtf'), chrom=CHROMS),
    output:
        gtf_gz='results/genes.gtf.gz'
    shell:
        'cat {input} | bgzip > {output.gtf_gz}'

rule tabix_gtf:
    input:
        gtf_gz='results/genes.gtf.gz'
    output:
        gtf_tbi='results/genes.gtf.gz.tbi'
    shell:
        'tabix -f -p gff {input.gtf_gz}'
        
