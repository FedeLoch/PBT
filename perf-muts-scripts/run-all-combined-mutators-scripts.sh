#!/bin/bash

# run-all-parallel.sh
# Launches Pharo experiments in parallel, each downloading its own environment.

scripts=(
    "run-regexes-combined-mutators.st"
    "run-json-combined-mutators.st"
    "run-microdown-combined-mutators.st"
    "run-dataframe-combined-mutators.st"
)

folders=(
    "regexes-combined-mutators"
    "json-combined-mutators"
    "microdown-combined-mutators"
    "dataframe-combined-mutators"
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
