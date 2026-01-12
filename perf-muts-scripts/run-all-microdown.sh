#!/bin/bash

# run-all-parallel.sh
# Launches Pharo experiments in parallel, each downloading its own environment.

scripts=(
    "run-microdown-grammar-derivations.st"
    "run-microdown-grammar-literals.st"
    "run-microdown-stochastic-base.st"
    "run-microdown-weighted-grammar-base.st"
)

folders=(
    "microdown-grammar-derivations"
    "microdown-grammar-literals"
    "microdown-stochastic-base"
    "microdown-weighted-grammar-base"
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
