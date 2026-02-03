Metacello new
    baseline: 'Ume';
    repository: 'github://FedeLoch/Ume:main';
	onConflictUseIncoming;
    load.

(Smalltalk at: #DataFrameExperiment) run: 'weighted-grammar-base'.