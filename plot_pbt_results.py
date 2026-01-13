import os
import sys
import glob
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

def main():
    directory_path = '/Users/fede/Documents/Experiments/TEST-PAPER-V2/PBT/perf-muts-scripts/regexes-grammar-literals'
    csv_files = glob.glob(os.path.join(directory_path, "*.csv"))

    if not csv_files:
        print(f"No CSV files found in {directory_path}")
        sys.exit(1)

    print(f"Found {len(csv_files)} CSV files. Processing execution times per case...")

    all_runs_y = []
    max_len = 0

    plt.figure(figsize=(12, 7))
    color = 'tab:blue'

    for file_path in csv_files:
        try:
            df = pd.read_csv(file_path)
            # Col 1: Tiempo de ejecución del caso
            exec_times = pd.to_numeric(df.iloc[:, 0], errors='coerce').fillna(0).values
            
            # Eje Y: Mejor descubrimiento hasta el momento por índice de caso
            cum_max_discovery = np.maximum.accumulate(exec_times)
            
            # Graficar corrida individual con transparencia
            # plt.step(range(len(cum_max_discovery)), cum_max_discovery, where='post', color=color, alpha=0.5, linewidth=1)
            
            all_runs_y.append(cum_max_discovery)
            max_len = max(max_len, len(cum_max_discovery))
            
        except Exception as e:
            print(f"Error reading {file_path}: {e}")

    if all_runs_y:
        # Padding con el último valor (el mejor encontrado) para promediar
        padded_runs = np.full((len(all_runs_y), max_len), np.nan)
        for i, run in enumerate(all_runs_y):
            last_val = run[-1] if len(run) > 0 else 0
            padded_runs[i, :len(run)] = run
            padded_runs[i, len(run):] = last_val
            
        mean_y = np.mean(padded_runs, axis=0)
        std_y = np.std(padded_runs, axis=0)
        x_axis = np.arange(max_len)
        
        # Crear un efecto de "mapa de calor" usando múltiples bandas de desviación estándar
        # Dibujamos varias capas con alfas bajos para crear el gradiente
        n_bands = 20
        base_color = 'royalblue'
        for i in range(1, n_bands + 1):
            sigma_level = (i / n_bands) * 0.5
            alpha = (1.0 / n_bands) * 1
            plt.fill_between(x_axis, 
                             np.maximum(1, mean_y - std_y * sigma_level), 
                             mean_y + std_y * sigma_level, 
                             step='post', color=base_color, alpha=alpha)
        
        # Plotear Media en el centro
        plt.step(x_axis, mean_y, where='post', color='darkblue', linewidth=2, label='Average of better case', zorder=10)

    plt.title('Heat map (Best case as far)')
    plt.xlabel('Iteration (Case)')
    plt.ylabel('Microseconds (Best found as far)')
    
    plt.yscale('log')
    
    plt.legend()
    plt.grid(True, which='both', linestyle='--', alpha=0.5)
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    main()
