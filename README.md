# PBT - Property-Based Testing Framework for Pharo
###  ⚠️ This framework is currently a work in progress

## Getting started

To install the framework you must execute this Metacello script in your playground or add the project as a dependency

```Smalltalk
Metacello new
    baseline: 'PBT';
    repository: 'github://FedeLoch/PBT/tree/main/src';
    load
```

## How does PBT work ?

PBT works with Object generators ( for the moment ) provided by hand, automatically generating receiver objects and call arguments.

A PBT execution looks like the following:

```Smalltalk
PBTRunner test: SmallInteger >> #+ from: schema
```

What we are saying to the framework

"Test this method ( **SmallInteger >> #+** ) using the following schema"

But for the framework to be able to test the method we need to create a schema with the following information:

- **ReceiverConstraint**: An Object Constraint specification of how to generate the message's receiver.
- **ArgumentConstraints:**: An array of Object Constraint specifications of how to generate each message's argument.
- **Assert**: A block that will validate whether a result is accomplished with your properties or not.

Following the previous usage, to be able to test the addition method of the class SmallInteger we are going to provide the next schema:

```Smalltalk
range := SmallInteger minVal to: SmallInteger maxVal.
receiverConstraint := PBTObjectConstraint new generator: (PBTGenerator oneOf: range).

argumentConstraints := {
    (PBTObjectConstraint new generator: (PBTGenerator oneOf: range))
}.

assert := [ :n :args :result | args first + n = result ]. "<- Note that the assert block receives the object receiver, the arguments used for the call and the method's call result"

schema := PBTSchema new
                receiverConstraint: receiverConstraint;
                argumentConstraints: argumentConstraints;
                assert: assert
```

#### Observation: We use predefined **PBTGenerator** to generate dynamically SmallInteger providing a range of possible values. The built-in generators will be explained later.

### PBT Result

As a result, PBT Provides a **PBTResult** which has the following information:
- **Tests**: The set of every PBT test, representing every test instance, with its own generated receiver, arguments, results, coverage and time consumed.
- **Segmented tests**: The set of tests segmented by his result ( Success, Fail or Error ).
- **Total time**: The total time it takes to perform the whole PBT Execution.
- **Total Coverage**: An incremental coverage result with the union of all test executions.
- **Performance Result**: A performance result with information about test times.

## PBT parameters

### Stop criteria

PBT can be executed by calling it with different methods, the default is just calling as above, which means that the framework will execute only 1000 test cases.

```Smalltalk
PBTRunner test: targetMethod from: schema
```

In case you want to specify the amount of time you want the framework to generate test cases, you can use the following method:

```Smalltalk
PBTRunner test: targetMethod from: schema for: time
```

In case you want to specify the number of generated tests:

```Smalltalk
PBTRunner test: targetMethod from: schema times: times
```

If you want to set out that you want the framework to execute until you get 100% of coverage or define a bound of tolerance for not improving coverage tests:

```Smalltalk
PBTRunner test: targetMethod from: schema withCoverageTolerance: numberOfTolerance
```

## Generators

We provide several built-in generators that must be enough to define generators for every object. However, you can define your generators to reduce code duplication. These built-in generators are:

- **PBTConstantGenerator**: Generator that always returns the same value.
- **PBTDyncamicSelectionGenerator**: Generator that receives a list of generators and, based on feedback, balances the weight of every option to give more chance to the generator that got good solutions probabilistically.
- **PBTGrammarGenerator**: Generator that receives a grammar and generates a random valid value accepted for that grammar.
- **PBTObjectGenerator**: Generator that, given a block, fills the instance object.
- **PBTOptionsGenerator**: Generator that returns a random value from a series of options.
- **PBTPointGenerator**: Generator that returns a random point.

## Performance result

## Coverage result

## Other examples

### Integer#factorial

```Smalltalk
receiverConstraint := PBTObjectConstraint new generator: (PBTGenerator oneOf: (10 to: 100)).

assert := [ :n :args :result | n * (n - 1) factorial = result ].

schema := PBTSchema new receiverConstraint: receiverConstraint; assert: assert

PBTRunner test: Integer >> #factorial from: schema times: 2542 "<- Specifying the number of tests desired"
```

### SequenceableCollection#sort

```Smalltalk
receiverConstraint := PBTObjectConstraint new
		                     objectClass: OrderedCollection;
		                     generator:
			                     (PBTGenerator onceInstance: [ :instance :props |
					                      (Random new nextIntegerBetween: 1 and: 100)
						                      timesRepeat: [
							                      instance add: (props at: 'item') gen ].
					                      instance ]);
		                     props: { ('item' -> (PBTObjectConstraint new
					                       objectClass: SmallInteger;
					                       generator: (PBTGenerator oneOf: (10 to: 100)))) }.

assert := [ :coll :args :result | result = coll sort and: result size = coll size ].
schema := PBTSchema new receiverConstraint: receiverConstraint; assert: assert

PBTRunner test: SequenceableCollection >> #sort from: schema for: 2 seconds "<- Specifying the maximum time"
```

### Rectangle#area

```Smalltalk
generator := PBTGenerator onceInstance: [ :instance :props | instance
                    setPoint: (props at: 'origin') gen
                    point: (props at: 'corner') gen.
                    instance
                ].

receiverConstraint := PBTObjectConstraint new
                            objectClass: Rectangle;
                            generator: generator;
                            props: {
                                    ('origin' -> (PBTObjectConstraint new
                                            objectClass: Point;
                                            generator: PBTPointGenerator new)).
                                    ('corner' -> (PBTObjectConstraint new
                                        objectClass: Point;
                                        generator: PBTPointGenerator new)) }.
argumentConstraints := {}.

assert := [ :rect :args :result | result >= 0 ].
schema := PBTSchema new
                receiverConstraint: receiverConstraint;
                argumentConstraints: argumentConstraints;
                assert: assert

PBTRunner test: Rectangle >> #area from: schema withCoverageTolerance: 100 "<-Specifying the number of tests that don't improve the coverage tolerated before stopping the execution"
```

### DateParser#parse

```Smalltalk
dateConstraint := PBTObjectConstraint new
		  objectClass: String;
		  generator: (PBTGrammarGenerator new grammar: PzDateMDYYYYGrammar new).

receiverConstraint := PBTObjectConstraint new
                            objectClass: DateParser;
                            generator:
                                (PBTGenerator onceInstance: [ :parser :props |
                                        DateParser
                                            readingFrom:
                                                (props at: 'date') gen readStream
                                            pattern: 'm-d-yyyy' ]);
                            props: { ('date' -> dateConstraint) }.

assert := [ :coll :args :result | result class = Date ].
schema := PBTSchema new
                receiverConstraint: receiverConstraint;
                assert: assert

PBTRunner test: DateParser >> #parse from: schema
```
