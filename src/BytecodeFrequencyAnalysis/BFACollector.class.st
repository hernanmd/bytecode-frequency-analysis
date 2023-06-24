"
# Usage Example

```language=Pharo
SuperInstructionCollector new
	collect;
	writeDataFrame.
```

"
Class {
	#name : #BFACollector,
	#superclass : #Object,
	#instVars : [
		'selectedMethods',
		'selectedSubsetName',
		'bytecodeGrams'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFACollector class >> example1 [

	^ BFACollector new 
		selectAllMethods;
		collect.
]

{ #category : #examples }
BFACollector class >> example3 [

	^ BFACollector new
		selectFileSystemMethods;
		collect
]

{ #category : #private }
BFACollector >> analyzeMethod: cm rowIndex: rowIndex [

	(2 to: 3) do: [ : order |
		self 
			analyzeMethod: cm 
			rowIndex: rowIndex 
			order: order ]

]

{ #category : #private }
BFACollector >> analyzeMethod: cm rowIndex: rowIndex order: order [

	(cm bytecodes ngrams: order) do: [ : bytecodeCombination |
		self bytecodeGrams add: bytecodeCombination asArray ]

]

{ #category : #accessing }
BFACollector >> bytecodeGrams [

	^ bytecodeGrams
		ifNil: [ bytecodeGrams := Set new ]
]

{ #category : #accessing }
BFACollector >> bytecodeGrams: anObject [

	bytecodeGrams := anObject
]

{ #category : #accessing }
BFACollector >> collect [

	self selectedMethods doWithIndex:  [ : cm : rowIndex | 
		self analyzeMethod: cm rowIndex: rowIndex ].

]

{ #category : #private }
BFACollector >> excludeTestFromPackage: p [

	^ (p name findTokens: '-') includes: 'Tests'
]

{ #category : #private }
BFACollector >> methodsFromPackageName: aPackageName [

	self selectedSubsetName: aPackageName.
	^ (RPackageOrganizer default packages
		   select: [ :p |
			   (p name beginsWith: aPackageName) and: [
				   (self excludeTestFromPackage: p) not ] ]
		   thenCollect: [ :p | p methods ]) flattened
]

{ #category : #subsets }
BFACollector >> selectAllMethods [
	" Set the receiver to select all methods in this image "
	
	selectedMethods := CompiledMethod allInstances.
	
]

{ #category : #subsets }
BFACollector >> selectCollectionMethods [

	self selectedMethods: (self methodsFromPackageName: 'Collection')
]

{ #category : #subsets }
BFACollector >> selectFileSystemMethods [

	self selectedMethods: (self methodsFromPackageName: 'FileSystem')
]

{ #category : #subsets }
BFACollector >> selectKernelMethods [

	self selectedMethods: (self methodsFromPackageName: 'Kernel')
]

{ #category : #subsets }
BFACollector >> selectMathMethods [

	self selectedMethods: (self methodsFromPackageName: 'Math')
]

{ #category : #subsets }
BFACollector >> selectMicrodownMethods [

	self selectedMethods: (self methodsFromPackageName: 'Microdown')
]

{ #category : #subsets }
BFACollector >> selectMorphicMethods [

	self selectedMethods: (self methodsFromPackageName: 'Morphic')
]

{ #category : #subsets }
BFACollector >> selectNECompletionnMethods [

	self selectedMethods: (self methodsFromPackageName: 'NECompletion')
]

{ #category : #subsets }
BFACollector >> selectStonMethods [

	self selectedMethods: (self methodsFromPackageName: 'STON')
]

{ #category : #accessing }
BFACollector >> selectedMethods [
	" Answer a <Collection> with the selected method to analyze "
	
	^ selectedMethods
		ifNil: [ selectedMethods := OrderedCollection new ]
]

{ #category : #accessing }
BFACollector >> selectedMethods: anObject [

	selectedMethods := anObject
]

{ #category : #accessing }
BFACollector >> selectedSubsetName [

	^ selectedSubsetName
]

{ #category : #accessing }
BFACollector >> selectedSubsetName: anObject [

	selectedSubsetName := anObject
]