#!/bin/bash

# run-all-parallel.sh
# Launches Pharo experiments in parallel, each downloading its own environment.

scripts=(
    "run-regexes-grammar-derivations.st"
    "run-regexes-grammar-literals.st"
    "run-regexes-stochastic-base.st"
    "run-regexes-weighted-grammar-base.st"
)

folders=(
    "regexes-grammar-derivations"
    "regexes-grammar-literals"
    "regexes-stochastic-base"
    "regexes-weighted-grammar-base"
)

# Base directory for the execution
BASE_DIR="$(pwd)"

for i in "${!scripts[@]}"; do
    script="${scripts[$i]}"
    run_dir="${folders[$i]}"
    
    echo "Queueing $script in isolated directory $run_dir"
    
    # Create directory and run in background
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
