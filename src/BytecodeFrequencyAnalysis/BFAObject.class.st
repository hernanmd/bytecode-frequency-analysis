"
Abstract class to which provides a `DataFrame` and data source collaborators to subclasses.
It also provides a default implementation of `buildDataFrame` method to create a DataFrame from the data source.

"
Class {
	#name : #BFAObject,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'dataFrame'
	],
	#category : #BytecodeFrequencyAnalysis
}

{ #category : #'public - plots' }
BFAObject >> buildDataFrame [

	dataFrame :=  DataFrame readFromCsvWithRowNames: self dataSource
]

{ #category : #'public - plots' }
BFAObject >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
BFAObject >> dataFrame: anObject [

	dataFrame := anObject
]

{ #category : #accessing }
BFAObject >> dataSource [

	^ dataSource
]

{ #category : #accessing }
BFAObject >> dataSource: anObject [

	dataSource := anObject
]
