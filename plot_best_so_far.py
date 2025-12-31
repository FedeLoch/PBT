import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import sys

# ==========================================
# CONFIGURATION
# ==========================================
# You can set the default file path and upper bound here.
# These can also be passed as command line arguments for flexibility.

DEFAULT_FILE_PATH = '/Users/fede/Documents/Pharo/images/PBT-ReplicatingPharoHashProblem/best-generation-regexes-derivation-mutator.csv'
DEFAULT_UPPER_BOUND = 1584323553  # Microseconds (e.g., 1 second)

# ==========================================

def plot_performance(file_path, upper_bound):
    print(f"Loading results from: {file_path}...")
    
    try:
        # Read the CSV. PBTResult >> exportAsCSV uses 'time-microseconds' and 'improvement'
        df = pd.read_csv(file_path)
    except Exception as e:
        print(f"Error: Could not read the file. {e}")
        return

    # Extract execution times (micro-seconds)
    # Using column name if available, otherwise fallback to first column
    if 'time-microseconds' in df.columns:
        times = df['time-microseconds']
    else:
        times = df.iloc[:, 0]

    # Convert to numeric just in case there are formatting issues
    times = pd.to_numeric(times, errors='coerce').fillna(0)

    # Calculate the "Best So Far" (Cumulative Maximum)
    # This represents the most expensive discovery made at each point in time.
    best_discovery = np.maximum.accumulate(times)

    # Create the Plot
    plt.figure(figsize=(12, 7))
    
    # Step plot is better for cumulative discoveries (discrete jumps)
    plt.step(range(len(best_discovery)), best_discovery, where='post', 
             label='Best Discovery So Far (Latency)', color='#1f77b4', linewidth=2)
    
    # Fill the area under the discovery for better visibility
    plt.fill_between(range(len(best_discovery)), best_discovery, step='post', alpha=0.1, color='#1f77b4')

    # Plot the Upper Bound as a horizontal line
    plt.axhline(y=upper_bound, color='#d62728', linestyle='--', 
                label=f'Target Upper Bound ({upper_bound:,} µs)', linewidth=1.5)

    # Formatting accurately
    plt.title('PBT Performance Discovery: Incremental Best Cases', fontsize=14, fontweight='bold')
    plt.xlabel('Iterative Test Case Index', fontsize=12)
    plt.ylabel('Execution Time (Microseconds)', fontsize=12)
    
    plt.legend(loc='best')
    plt.grid(True, which='both', linestyle=':', alpha=0.6)
    
    # Use log scale if the range is very large (common in perfuzzing)
    if best_discovery.max() > upper_bound * 10:
        plt.yscale('log')
        plt.ylabel('Execution Time (µs) - Log Scale', fontsize=12)

    plt.tight_layout()
    
    print("Graph generated. Opening viewer...")
    plt.show()

if __name__ == "__main__":
    # Allow overrides via CLI: python plot_best_so_far.py <path> <bound>
    file_to_plot = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_FILE_PATH
    bound = int(sys.argv[2]) if len(sys.argv) > 2 else DEFAULT_UPPER_BOUND
    
    plot_performance(file_to_plot, bound)
