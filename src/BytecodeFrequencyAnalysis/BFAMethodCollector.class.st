Class {
	#name : #BFAMethodCollector,
	#superclass : #BFACollector,
	#instVars : [
		'dataFrame'
	],
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
	classMethodRow := cm methodClass asString , '>>' , cm selector , '|' , rowIndex asString.
	(self dataFrame rowNames includes: classMethodRow)
		ifFalse: [ 
			self dataFrame
				addEmptyRowNamed: classMethodRow
				atPosition: rowIndex ].
	(2 to: 3) do: [ : order |
		self 
			analyzeMethod: cm 
			rowIndex: rowIndex 
			order: order ]

]

{ #category : #private }
BFAMethodCollector >> analyzeMethod: cm rowIndex: rowIndex order: order [

	(cm bytecodes ngrams: order) do: [ : bytecodeCombination |
		| bytecodeColumnName |
		bytecodeColumnName := bytecodeCombination asArray.
		(self dataFrame columnNames includes: bytecodeColumnName)
				ifFalse: [ self dataFrame addEmptyColumnNamed: bytecodeColumnName ].
		self dataFrame 
			at: rowIndex 
			at: (self dataFrame indexOfColumnNamed: bytecodeColumnName)
			transform: [ : val |
				val isNil 
					ifTrue: [ 1 ] 
					ifFalse: [ val + 1 ] ] ]

]

{ #category : #accessing }
BFAMethodCollector >> dataFrame [

	^ dataFrame
		ifNil: [ dataFrame := DataFrame new ]
]

{ #category : #accessing }
BFAMethodCollector >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #private }
BFAMethodCollector >> writeDataFrame [

	self dataFrame replaceNilsWith: 0.
	self dataFrame writeToCsv: 
		(self selectedSubsetName ,  '-compiled-methods.csv') asFileReference.
]
