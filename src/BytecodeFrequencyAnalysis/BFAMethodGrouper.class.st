Class {
	#name : #BFAMethodGrouper,
	#superclass : #BFAObject,
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #examples }
BFAMethodGrouper class >> example [

	BFAMethodGrouper newFrom: 'final/STON-compiled-methods.csv' asFileReference.
]

{ #category : #examples }
BFAMethodGrouper class >> newFrom: aFileReference [

	self new
		initializeWithDataSource: aFileReference;
		yourself
]

{ #category : #private }
BFAMethodGrouper >> groupByClass [
	"Group the receiver's methods by the class they're found"
	
	self dataFrame sortBy: 'Methods'.
	self dataFrame inspect.
]

{ #category : #private }
BFAMethodGrouper >> initializeWithDataSource: aFileReference [
	"Private - Set names to columns"
	
	| firstColumn |
	super initialize.
	self dataSource: aFileReference.
	self buildDataFrame.
	firstColumn := self dataFrame columns first.
	firstColumn name: 'Methods'
]
