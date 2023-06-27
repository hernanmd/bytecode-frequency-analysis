Extension { #name : #SymbolicBytecode }

{ #category : #'*BytecodeFrequencyAnalysis' }
SymbolicBytecode >> opCodeName [ 

	^ String streamContents: [ : stream | 
		stream 
			nextPut: $<;
			nextPutAll: (bytes first radix: 16);
			nextPut: $> ]

]
