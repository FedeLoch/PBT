Metacello new
    baseline: 'PBT';
    repository: 'github://FedeLoch/PBT:main';
	onConflictUseIncoming;
    load.

(Smalltalk at: #DataFrameExperiment) run: 'stochastic-base'.