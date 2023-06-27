Extension { #name : #AINgram }

{ #category : #'*BytecodeFrequencyAnalysis' }
AINgram >> opCodeNames [

	^ self asArray collect: #opCodeName
]
