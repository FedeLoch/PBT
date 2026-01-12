#!/bin/bash

# run-all-parallel.sh
# Launches Pharo experiments in parallel, each downloading its own environment.

scripts=(
    "run-dataframe-grammar-derivations.st"
    "run-dataframe-grammar-literals.st"
    "run-dataframe-stochastic-base.st"
    "run-dataframe-weighted-grammar-base.st"
)

folders=(
    "dataframe-grammar-derivations"
    "dataframe-grammar-literals"
    "dataframe-stochastic-base"
    "dataframe-weighted-grammar-base"
)

BASE_DIR="$(pwd)"

for i in "${!scripts[@]}"; do
    script="${scripts[$i]}"
    run_dir="${folders[$i]}"
    
    echo "Queueing $script in isolated directory $run_dir"
    
    mkdir -p "$run_dir"
    (
        cd "$run_dir"
        ../run.sh "../$script" > "../$script.log" 2>&1
    ) &
done

echo "All experiments launched in parallel. Check *.log files for updates."
echo "Waiting for all processes to finish..."
wait
echo "All experiments finished."
