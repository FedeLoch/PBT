Metacello new
    baseline: 'PBT';
    repository: 'github://FedeLoch/PBT:main';
	onConflictUseIncoming;
    load.

(Smalltalk at: #NeoJSONExperiment) run: 'weighted-grammar-base'.