Class {
	#name : #BaselineOfBytecodeFrequencyAnalysis,
	#superclass : #BaselineOf,
	#category : #BaselineOfBytecodeFrequencyAnalysis
}

{ #category : #baselines }
BaselineOfBytecodeFrequencyAnalysis >> baseline: spec [
  <baseline>
	spec
		for: #(common)
		do: [ 
			spec 
				package: 'BytecodeFrequencyAnalysis';
				package: 'BytecodeFrequencyAnalysis-Tests'	with: [ spec requires: #(BytecodeFrequencyAnalysis) ].
					
			spec
			spec
				baseline: 'DataFrame'
				with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ];
				baseline: 'Roassal3Exporters'
				with: [ spec  repository: 'github://ObjectProfile/Roassal3Exporters' ];
				baseline: 'NgramModel'
				with: [ spec repository: 'github://pharo-ai/NgramModel/src' ].

			spec 
				group: 'Core' 						with: #('BytecodeFrequencyAnalysis' 'NgramModel' 'Roassal3Exporters' 'DataFrame');
				group: 'Tests' 						with: #('BytecodeFrequencyAnalysis' 'BytecodeFrequencyAnalysis-Tests');
				group: 'default' 					with: #('Core' 'Tests') ]
]
