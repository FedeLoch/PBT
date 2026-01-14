import os
import sys
import glob
import csv
import math

def analyze_single_csv(file_path):
    """Analyze improvements from a single CSV file.
    
    Returns:
        dict: Dictionary with computed metrics for this CSV, or None if no data
    """
    improvements = []
    
    try:
        with open(file_path, 'r') as f:
            reader = csv.reader(f)
            next(reader)  # Skip header
            for row in reader:
                if len(row) >= 2:
                    try:
                        # Segunda columna (improvements)
                        improvement = float(row[1])
                        improvements.append(improvement)
                    except (ValueError, IndexError):
                        improvements.append(0)
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
        return None
    
    if not improvements:
        return None
    
    # Filter only positive improvements
    positive_improvements = [val for val in improvements if val > 0]
    
    if len(positive_improvements) == 0:
        return {
            'avg_distance': 0,
            'std_distance': 0,
            'avg_improvement': 0,
            'percent_positive': 0,
            'total_positive': 0
        }
    
    # Find indices of positive improvements in the original array
    positive_indices = [i for i, val in enumerate(improvements) if val > 0]
    
    # Calculate distances between consecutive positive improvements
    if len(positive_indices) > 1:
        distances = [positive_indices[i+1] - positive_indices[i] for i in range(len(positive_indices)-1)]
        avg_distance = sum(distances) / len(distances)
        # Calculate standard deviation
        mean_dist = avg_distance
        variance = sum((d - mean_dist) ** 2 for d in distances) / len(distances)
        std_distance = math.sqrt(variance)
    else:
        avg_distance = 0
        std_distance = 0
    
    # Calculate average of positive improvements
    avg_improvement = sum(positive_improvements) / len(positive_improvements)
    
    # Calculate percentage of positive cases
    percent_positive = (len(positive_improvements) / len(improvements)) * 100
    
    # Total count of positive improvements
    total_positive = len(positive_improvements)
    
    return {
        'avg_distance': avg_distance,
        'std_distance': std_distance,
        'avg_improvement': avg_improvement,
        'percent_positive': percent_positive,
        'total_positive': total_positive
    }


def analyze_improvements(directory_path):
    """Analyze improvements from all CSV files in a directory.
    Calculates metrics for each CSV individually, then averages them.
    
    Returns:
        dict: Dictionary with averaged metrics across all CSVs
    """
    csv_files = glob.glob(os.path.join(directory_path, "*.csv"))
    
    if not csv_files:
        print(f"No CSV files found in {directory_path}")
        return None
    
    # Calculate metrics for each CSV
    csv_metrics = []
    for file_path in csv_files:
        metrics = analyze_single_csv(file_path)
        if metrics is not None:
            csv_metrics.append(metrics)
    
    if not csv_metrics:
        return None
    
    # Average the metrics across all CSVs
    avg_avg_distance = sum(m['avg_distance'] for m in csv_metrics) / len(csv_metrics)
    avg_std_distance = sum(m['std_distance'] for m in csv_metrics) / len(csv_metrics)
    avg_avg_improvement = sum(m['avg_improvement'] for m in csv_metrics) / len(csv_metrics)
    avg_percent_positive = sum(m['percent_positive'] for m in csv_metrics) / len(csv_metrics)
    avg_total_positive = sum(m['total_positive'] for m in csv_metrics) / len(csv_metrics)
    
    return {
        'avg_distance': avg_avg_distance,
        'std_distance': avg_std_distance,
        'avg_improvement': avg_avg_improvement,
        'percent_positive': avg_percent_positive,
        'total_positive': avg_total_positive
    }


def print_table(headers, rows):
    """Print a formatted table without external dependencies."""
    # Calculate column widths
    col_widths = [len(h) for h in headers]
    for row in rows:
        for i, cell in enumerate(row):
            col_widths[i] = max(col_widths[i], len(str(cell)))
    
    # Print top border
    print("+" + "+".join("-" * (w + 2) for w in col_widths) + "+")
    
    # Print headers
    header_row = "|"
    for i, h in enumerate(headers):
        header_row += f" {h.ljust(col_widths[i])} |"
    print(header_row)
    
    # Print separator
    print("+" + "+".join("=" * (w + 2) for w in col_widths) + "+")
    
    # Print rows
    for row in rows:
        row_str = "|"
        for i, cell in enumerate(row):
            row_str += f" {str(cell).ljust(col_widths[i])} |"
        print(row_str)
    
    # Print bottom border
    print("+" + "+".join("-" * (w + 2) for w in col_widths) + "+")

def main():
    # Define the 4 directories to analyze
    directory_paths = [
        '/Users/fede/Documents/PhD/2025-generating-pathological-performance-mutations/Experiment results/New experiments/Regexes/regexes-grammar-literals',
        '/Users/fede/Documents/PhD/2025-generating-pathological-performance-mutations/Experiment results/New experiments/Regexes/regexes-grammar-derivations',
        '/Users/fede/Documents/PhD/2025-generating-pathological-performance-mutations/Experiment results/New experiments/Regexes/regexes-stochastic-base',
        '/Users/fede/Documents/PhD/2025-generating-pathological-performance-mutations/Experiment results/New experiments/Regexes/regexes-weighted-grammar-base'
    ]
    
    # Verify all directories exist
    for dir_path in directory_paths:
        if not os.path.isdir(dir_path):
            print(f"Error: Directory not found: {dir_path}")
            sys.exit(1)
    
    # Prepare table data
    table_data = []
    headers = [
        'Configuration', 
        'Avg Distance (Positive)', 
        'Std Distance (Positive)', 
        'Avg Improvement (Positive)', 
        '% Top Cases', 
        'Total Positive Cases'
    ]
    
    # Process each directory
    for dir_path in directory_paths:
        config_name = os.path.basename(dir_path)
        print(f"Processing: {config_name}")
        
        metrics = analyze_improvements(dir_path)
        
        if metrics is None:
            print(f"Skipping {config_name} due to errors")
            continue
        
        table_data.append([
            config_name,
            f"{metrics['avg_distance']:.2f}",
            f"{metrics['std_distance']:.2f}",
            f"{metrics['avg_improvement']:.2f}",
            f"{metrics['percent_positive']:.2f}%",
            f"{metrics['total_positive']}"
        ])
    
    # Print the table
    print("\n" + "="*120)
    print("ANALYSIS RESULTS - IMPROVEMENTS (Positive Cases Only)")
    print("="*120 + "\n")
    print_table(headers, table_data)
    print("\n" + "="*120)

if __name__ == "__main__":
    main()

