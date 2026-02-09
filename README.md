<p align="center">
  <img src="ume-images/ume_logo.png" alt="Ume Logo" width="200"/>
</p>

# Ume - Property-Based Testing & Guided Performance Fuzzing

Ume is a framework for Pharo designed to discover both functional bugs and performance outliers (Perfuzzing). It combines traditional random generation with grammar-based mutations, feedback-oriented exploration, and automatic regression test generation. To know more about Ume:

- [Getting Started](https://github.com/FedeLoch/Ume/wiki/Getting-Started)
- [How Ume Works](https://github.com/FedeLoch/Ume/wiki/How-Ume-Works)
- [Generators](https://github.com/FedeLoch/Ume/wiki/Generators)
- [Examples](https://github.com/FedeLoch/Ume/wiki/Examples)
- [Defining Custom Grammars](https://github.com/FedeLoch/Ume/wiki/Grammars)
- [Performance Analysis with Charts](https://github.com/FedeLoch/Ume/wiki/Charts)
- [Low-Cost instrumentation API](https://github.com/FedeLoch/Ume/wiki/Low-Cost-API)


## Core Objective

The goal of Ume is to automate the discovery of **worst-case scenarios**. Whether you are looking for inputs that break your invariants (Property Testing) or inputs that maximize execution time/memory, Ume guides the search using feedback from the system under test.


## Architecture Overview

Ume is built with a highly modular and decoupled architecture, allowing for flexible instrumentation and search strategies.

![Ume Architecture](ume-images/ume.png)

### Key Components
- **`UmeRunner`**: The engine of the search. Orchestrates execution, chooses the guidance strategy, and manages stop criteria.
- **`UmeSchema`**: Defines the "shape" of fuzzing configuration. It maps receiver and argument constraints to a target method and defines the **Assert** (the property to maintain).
- **`UmeEvaluator`**: Instruments the code to measure specific costs (e.g., coverage, execution time, method calls). Evaluate each UmeCase and provide its results to the feedback evaluator.
- **`UmeFeedbackEvaluator`**: Analyzes results. It uses profiling metrics to assign a score table to each case.
- **`UmeShrinker`**: (Work in progress) Designed to work internally within the evaluation loop to automatically shrink each **top case** as it is discovered.

---

## Quick Start: Property Testing

To test a method, you define a **Schema** and run it through the **Runner**.

```smalltalk
"1. Define how to generate the receiver"
receiverConstraint := UmeObjectConstraint new 
    generator: (UmeGenerator oneOf: (1 to: 100)).

"2. Define the property (Assertion)"
assert := [ :n :args :result | n * (n - 1) factorial = result ].

"3. Create the Schema"
schema := UmeSchema new 
    receiverConstraint: receiverConstraint; 
    assert: assert.

"4. Run the tests"
UmeRunner test: Integer >> #factorial from: schema.
```

---

## Performance Fuzzing

Ume excels at finding performance bottlenecks. Unlike traditional tools, **the Runner guides the search** toward high-cost inputs.

```smalltalk
runner := UmeRunner test: RxMatcher >> #matches: from: schema for: 1 minute.

"Guide the search to maximize execution time"
runner guidedByExecutionTime.

"Other guidance strategies include:"
runner guidedByCoverage.
runner guidedByAllocatedMemory.
runner guidedByMethodsCalls.

result := runner run.
```

---

## Analyzing Results

The `UmeResult` object contains the history of the search and tools to identify outliers.

- **`topCases`**: Access the most interesting cases found (the "best" discoveries).
- **`tests`**: Inspect every single execution case.
- **Visual Analysis**:
  - `result plotByExecutionTime open`
  - `result plotByScore open`
  - `result plotOutliers open`
- **Persistence & Export**:
  - `result exportAsCSV`: Save results for external analysis (e.g., Python scripts).
  - `result writeToFile: 'results.ston'`: Serialize the entire result set using STON.
- **Iterative Search**:
  - `result continue: 1000`: Run another 1000 cases based on the existing results.
  - `result continueFor: 5 minutes`: Continue searching for a specific duration.

---

## Advanced Generation: Tree-Grammar Mutations

For complex inputs like JSON or Regex, Ume uses structural mutations. **`UmeTreeGrammarMutator`** parses inputs into ASTs and uses **Monte Carlo Tree Search (MCTS)** to intelligently explore the grammar space.

```smalltalk
mutator := (UmeTreeGrammarMutator from: JSONGrammar new) maxInputSize: 100.
generator := UmeCorpusWithMutationsGenerator new
    seedGenerator: (UmeConstantGenerator new value: '[]');
    mutators: { mutator }.
```

---

## Automatic Test Generation

One of the most powerful workflows in Ume is the ability to automatically turn discovered bugs into permanent unit tests.

### Using `UmeUnitTest`
Subclass `UmeUnitTest` to define your search parameters once. You can then run a script to automatically verify and "install" discovered cases as standard Pharo test methods.

```smalltalk
"Inside your UmeUnitTest subclass"
MyRegressionTest >> generateTests [
    <script: 'self new generateTests'> "Run this in Pharo"
    super generateTests: 15 minutes.
]

"Ume will execute for 15 minutes and automatically compile methods like:"
test_12345678 [
    self doTest: {
        'method' -> #matches:.
        'receiver' -> 'RxMatcher...'.
        'arguments' -> '[''discovered_evil_input'']'.
    } asDictionary.
]
```

---

## Mutator Configurations

Ume supports three primary mutation levels, allowing you to choose the right balance between search speed and structural validity. These are typically used with `UmeCorpusWithMutationsGenerator`.

![Corpus Generator](ume-images/corpus-gen.png)

### 1. Stochastic Byte-Level Mutators
Works at the raw string/byte level. Fast and can find "invalid" but interesting inputs (e.g., buffer overflows, encoding issues).

```smalltalk
mutators := {
    (UmeAddByteMutator new maxInputSize: 100).
    UmeByteFlipMutator new.
    UmeDelByteMutator new
}.

generator := UmeCorpusWithMutationsGenerator new
    seedGenerator: (UmeConstantGenerator new value: '{"a":1}');
    mutators: mutators.
```

### 2. Grammar Mutators
Uses a grammar to ensure that any mutation results in a **structurally valid** string. Slower than byte-level but much more effective for deep logic testing.

```smalltalk
mutator := UmeGrammarMutator from: JSONGrammar new.

generator := UmeCorpusWithMutationsGenerator new
    seedGenerator: (UmeConstantGenerator new value: '{"key": "value"}');
    mutators: { mutator }.
```

### 3. Tree-Grammar Mutators
Parses the input into an AST and performs structural rotations, node replacements, and sub-tree generation using **Monte Carlo Tree Search (MCTS)**. This is the most powerful way to explore complex deeply-nested structures.

```smalltalk
mutator := (UmeTreeGrammarMutator from: JSONGrammar new) maxInputSize: 200.

generator := UmeCorpusWithMutationsGenerator new
    seedGenerator: (UmeConstantGenerator new value: '[]'); "Initial seed"
    mutationsPerIteration: 3;
    mutators: { mutator };
    heuristic: UmePickBestElementDifferenceHeuristic new.
```

