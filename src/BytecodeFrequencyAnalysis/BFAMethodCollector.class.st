"
Each iteration of selected methods stores all combinations of bytecode sequences (up to a n-gram order), along with the occurrence number of the current bytecode sequence, in a `DataFrame`. After all iterations are completed, write its contents to a file.

"
Class {
	#name : #BFAMethodCollector,
	#superclass : #BFACollector,
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFAMethodCollector class >> example1 [

	BFAMethodCollector new
		collect;
		writeDataFrame.
]

{ #category : #examples }
BFAMethodCollector class >> example2 [

	^ BFAMethodCollector new
		selectMathMethods;
		collect;
		writeDataFrame
]

{ #category : #examples }
BFAMethodCollector class >> example3 [

	^ BFAMethodCollector new
		selectFileSystemMethods;
		collect;
		writeDataFrame
]

{ #category : #examples }
BFAMethodCollector class >> example4 [

	^ BFAMethodCollector new
		selectNECompletionnMethods;
		collect;
		writeDataFrame
]

{ #category : #examples }
BFAMethodCollector class >> example5 [

	^ BFAMethodCollector new
		selectStonMethods;
		collect;
		writeDataFrame
]

{ #category : #examples }
BFAMethodCollector class >> example6 [

	^ BFAMethodCollector new
		selectMorphicMethods;
		collect;
		writeDataFrame
]

{ #category : #private }
BFAMethodCollector >> analyzeMethod: cm rowIndex: rowIndex [

	| classMethodRow |
	classMethodRow := String streamContents: [ : stream |
		stream 
			<< cm methodClass asString;
			<< '>>';
			<< cm selector;
			<< '|';
			<<  rowIndex asString ].
	(self dataFrame rowNames includes: classMethodRow)
		ifFalse: [ 
			self dataFrame
				addEmptyRowNamed: classMethodRow
				atPosition: rowIndex ].
	super analyzeMethod: cm rowIndex: rowIndex

]

{ #category : #private }
BFAMethodCollector >> analyzeMethod: cm rowIndex: rowIndex order: order [
	"Private - Iterate over the cm <CompiledMethod> symbolic bytecodes combinations,
	order is an <Integer> which specifies combinations of how many are built.
	Write 1 if combination is found, 0 otherwise "

	(cm symbolicBytecodes ngrams: order) do: [ :bytecodeCombination |
		| bytecodeColumnName |
		bytecodeColumnName := bytecodeCombination opCodeNames.
		(self dataFrame columnNames includes: bytecodeColumnName) ifFalse: [
			self dataFrame addEmptyColumnNamed: bytecodeColumnName ].
		self dataFrame
			at: rowIndex
			at: (self dataFrame indexOfColumnNamed: bytecodeColumnName)
			transform: [ :val | val ifNil: [ 1 ] ifNotNil: [ :arg | val + 1 ] ] ]
]

{ #category : #private }
BFAMethodCollector >> writeDataFrame [

	self dataFrame replaceNilsWithZero.
	self dataFrame writeToCsv: 
		(self selectedSubsetName ,  '-compiled-methods.csv') asFileReference.
]
