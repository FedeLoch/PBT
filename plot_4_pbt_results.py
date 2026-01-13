import os
import sys
import glob
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def process_directory(directory_path, color, label):
    """Process all CSV files in a directory and return the padded runs and max_len."""
    csv_files = glob.glob(os.path.join(directory_path, "*.csv"))
    
    if not csv_files:
        print(f"No CSV files found in {directory_path}")
        return None, 0
    
    print(f"Found {len(csv_files)} CSV files in {directory_path}")
    
    all_runs_y = []
    max_len = 0
    
    for file_path in csv_files:
        try:
            df = pd.read_csv(file_path)

            exec_times = pd.to_numeric(df.iloc[:, 0], errors='coerce').fillna(0).values
            
            cum_max_discovery = np.maximum.accumulate(exec_times)
            
            all_runs_y.append(cum_max_discovery)
            max_len = max(max_len, len(cum_max_discovery))
            
        except Exception as e:
            print(f"Error reading {file_path}: {e}")
    
    if not all_runs_y:
        return None, 0
    
    padded_runs = np.full((len(all_runs_y), max_len), np.nan)
    for i, run in enumerate(all_runs_y):
        last_val = run[-1] if len(run) > 0 else 0
        padded_runs[i, :len(run)] = run
        padded_runs[i, len(run):] = last_val
    
    return padded_runs, max_len

def main():
    directory_paths = [
        '/Users/fede/Documents/Experiments/TEST-PAPER-V2/PBT/perf-muts-scripts/regexes-grammar-literals',
        '/Users/fede/Documents/Experiments/TEST-PAPER-V2/PBT/perf-muts-scripts/regexes-grammar-derivations',
        '/Users/fede/Documents/Experiments/TEST-PAPER-V2/PBT/perf-muts-scripts/regexes-stochastic-base',
        '/Users/fede/Documents/Experiments/TEST-PAPER-V2/PBT/perf-muts-scripts/regexes-weighted-grammar-base'
    ]
    
    for dir_path in directory_paths:
        if not os.path.isdir(dir_path):
            print(f"Error: Directory not found: {dir_path}")
            sys.exit(1)
    
    # Paleta profesional: suave, distinguible y agradable a la vista
    colors = ['#5DADE2', '#F1948A', '#48C9B0', '#BB8FCE']  # Sky Blue, Coral, Teal, Lavender
    line_colors = ['#3498DB', '#E74C3C', '#16A085', '#8E44AD']  # Versiones más saturadas para líneas
    
    labels = [os.path.basename(path) for path in directory_paths]
    
    plt.figure(figsize=(14, 8))
    
    global_max_len = 0
    
    for i, (dir_path, color, line_color, label) in enumerate(zip(directory_paths, colors, line_colors, labels)):
        print(f"\nProcessing directory {i+1}: {dir_path}")
        
        padded_runs, max_len = process_directory(dir_path, color, label)
        
        if padded_runs is None:
            continue
        
        global_max_len = max(global_max_len, max_len)
        
        mean_y = np.mean(padded_runs, axis=0)
        std_y = np.std(padded_runs, axis=0)
        x_axis = np.arange(max_len)
        
        n_bands = 20
        for j in range(1, n_bands + 1):
            sigma_level = (j / n_bands) * 0.5
            alpha = (1.0 / n_bands) * 0.8
            plt.fill_between(x_axis, 
                             np.maximum(1, mean_y - std_y * sigma_level), 
                             mean_y + std_y * sigma_level, 
                             step='post', color=color, alpha=alpha)
        
        plt.step(x_axis, mean_y, where='post', color=line_color, linewidth=2.5, label=label, zorder=10)
    
    plt.title('Heat map comparison (Best case as far)')
    plt.xlabel('Iteration (Case)')
    plt.ylabel('Microseconds (Best found as far)')
    
    plt.yscale('log')
    
    plt.legend(loc='best')
    plt.grid(True, which='both', linestyle='--', alpha=0.5)
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()
