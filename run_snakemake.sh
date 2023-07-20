CLUSTER_CMD=("bsub -n {threads} -R {cluster.resources} -M {cluster.memory} -oo {cluster.output} -eo {cluster.error} -J {cluster.name} -W {cluster.time}")
cluster_yaml=./cluster.yaml

cmd="snakemake"
cmd="$cmd --jobs 30"
cmd="$cmd --restart-times 0"
cmd="$cmd --rerun-incomplete"
cmd="$cmd --cluster-config $cluster_yaml"
cmd="$cmd --cluster \"${CLUSTER_CMD}\""
cmd="$cmd --cluster-cancel bkill"
cmd="$cmd --use-singularity"
cmd="$cmd --singularity-args \"--bind /juno --bind /home\""
cmd="$cmd -p"
# cmd="$cmd --dry-run"

echo $cmd
eval $cmd
