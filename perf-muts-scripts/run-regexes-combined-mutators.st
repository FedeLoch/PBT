Metacello new
    baseline: 'PBT';
    repository: 'github://FedeLoch/PBT:main';
	onConflictUseIncoming;
    load.

(Smalltalk at: #RegexExperiment) run: 'combined-grammar-mutators'.