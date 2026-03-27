# Shrinking Strategies in Ume

This document describes the different shrinking strategies implemented to minimize inputs while maintaining the performance threshold.

## Architecture

```
UmeBaseShrinker (Abstract)
    ├── UmeShrinker              - Original, based on candidates
    ├── UmeDeltaDebuggingShrinker - Zeller's ddmin
    ├── UmeBinarySearchShrinker  - Binary search
    ├── UmeGreedyShrinker        - Aggressive removal
    ├── UmeHierarchicalShrinker  - By levels
    └── UmeHybridShrinker        - Combines strategies
```

## Strategy Comparison

| Strategy | Best For | Speed | Reduction | Complexity |
|----------|----------|-------|-----------|------------|
| Original | Complex grammars | Medium | Medium | Medium |
| Delta Debugging | Strings/bytes | High | High | Low |
| Binary Search | Linear inputs | Very High | Medium | Very Low |
| Greedy | Aggressive reduction | High | Very High | Low |
| Hierarchical | Nested structures | Medium | High | High |
| Hybrid | General use | High | High | Medium |

## Usage

### Basic Usage

```smalltalk
"Create a shrinker"
shrinker := UmeGreedyShrinker new
    grammar: JSONGrammar new;
    evaluator: myEvaluator;
    feedbackEvaluator: myFeedbackEvaluator;
    programBlock: [ :input | MyParser parse: input ];
    classesToProfile: { MyParser };
    threshold: 0.95;
    maxIterations: 1000;
    yourself.

"Execute shrinking"
shrunkInput := shrinker shrink: originalInput.
```

### Comparative Benchmark

```smalltalk
"Compare all shrinkers"
testCases := { 
    'input1' asJSONString. 
    'input2' asJSONString.
    'input3' asJSONString
}.

comparison := UmeShrinkerBenchmark runComparisonOn: testCases
    grammar: JSONGrammar new
    evaluator: myEvaluator
    feedbackEvaluator: myFeedbackEvaluator
    programBlock: [ :input | JSON readFrom: input readStream ].

"View results"
Transcript show: comparison printDetailedReport.

"Best by reduction"
best := comparison bestByReduction.  "=> UmeGreedyShrinker -> 85.5"

"Best by speed"
fastest := comparison bestBySpeed.  "=> UmeBinarySearchShrinker -> 2.3ms"
```

## Details of Each Strategy

### 1. UmeShrinker (Original)

**Approach**: Selects candidates based on "reward" of AST tree nodes.

```smalltalk
shrink: input [
    candidates := node allNodes 
        select: [ :n | n reward: grammar root: node ].
    "Try to remove nodes with minimum reward"
]
```

**Advantages**: Works well with complex grammars.
**Disadvantages**: Can be slow, doesn't guarantee optimality.

---

### 2. UmeDeltaDebuggingShrinker (ddmin)

**Approach**: Zeller's classic algorithm. Splits input into partitions and removes fragments that don't affect the result.

```smalltalk
shrinkWithDD: current from: granularity [
    partitions := self splitIntoPartitions: node count: granularity.
    removable := partitions select: [ :p | self canRemove: p ].
    granularity := granularity // 2
]
```

**Advantages**: Solid theory, 1-minimal guarantee, fast.
**Disadvantages**: Can be inefficient with hierarchical structures.

**Reference**: Zeller & Hildebrandt, "Simplifying and Isolating Failure-Inducing Input", TSE 2002.

---

### 3. UmeBinarySearchShrinker

**Approach**: Divides input in halves and searches for the minimum boundary.

```smalltalk
binarySearch: input from: bestScore [
    midpoint := (left + right) // 2.
    "Can we keep the left half?"
    "Or the right half?"
]
```

**Advantages**: Very fast O(log n), easy to understand.
**Disadvantages**: Only works well for linear inputs.

---

### 4. UmeGreedyShrinker

**Approach**: Removes the largest chunks first, then descends to smaller chunks.

```smalltalk
"Strategy 1: Remove largest subtrees"
sortedCandidates := candidates sorted: [ :a :b | a inputSize > b inputSize ].

"Strategy 2: Remove from the end"
[ input size > 1 ] whileTrue: [
    candidate := input allButLast.
    candidate valid ifTrue: [ ^ candidate ]
]
```

**Advantages**: Best percentage reduction, intuitive.
**Disadvantages**: May not find the optimal solution.

---

### 5. UmeHierarchicalShrinker

**Approach**: Works by abstraction levels, from general to specific.

```smalltalk
"Level 1: Replace subtrees with minimal equivalents"
current := self shrinkLevel1: current from: bestScore.

"Level 2: Remove complete branches"  
current := self shrinkLevel2: current from: bestScore.

"Level 3: Reduce remaining structures"
current := self shrinkLevel3: current from: bestScore.
```

**Advantages**: Respects hierarchical structure, preserves validity.
**Disadvantages**: More complex to implement and debug.

---

### 6. UmeHybridShrinker

**Approach**: Combines strategies automatically, selects the most effective one.

```smalltalk
[ iteration < maxIterations ] whileTrue: [
    "Try current strategy"
    current := self applyStrategy: strategy to: current.
    
    "If no progress, try other strategies"
    changed ifFalse: [
        otherStrategies do: [ :s |
            current := self applyStrategy: s to: current.
            current changed ifTrue: [ strategy := s ] ] ]
]
```

**Advantages**: Adapts automatically, robust.
**Disadvantages**: More overhead for trying multiple strategies.

---

## Threshold Configuration

The threshold controls how close to the original score should be maintained:

```smalltalk
shrinker threshold: 0.95.  "Maintain 95% of original score"
shrinker threshold: 0.80.  "More reduction, less strict"
shrinker threshold: 0.99.  "Very strict, less reduction"
```

## Recommendations

### To Get Started
Use `UmeHybridShrinker` - combines the best of all strategies.

### For Critical Performance
Use `UmeBinarySearchShrinker` if input is linear.

### For Complex Grammars
Use `UmeGreedyShrinker` or `UmeHierarchicalShrinker`.

### For Optimality Guarantee
Use `UmeDeltaDebuggingShrinker` (ddmin).

## Common API

All shrinkers share this interface:

```smalltalk
"Configuration"
shrinker
    grammar: aGrammar;
    evaluator: anEvaluator;
    feedbackEvaluator: aFeedbackEvaluator;
    programBlock: aBlock;
    classesToProfile: someClasses;
    threshold: 0.95;
    maxIterations: 1000.

"Execution"
shrinker shrink: input.

"Utilities"
shrinker evalInput: input.
shrinker resetMemoization.
shrinker parse: input.
```
