Class {
	#name : #SpirographPaper,
	#superclass : #Object,
	#instVars : [
		'form',
		'canvas',
		'penColor',
		'center',
		'previousPenPoint'
	],
	#category : #ExploreThePharo
}

{ #category : #accessing }
SpirographPaper >> clear [

	canvas fillColor: Color white.

]

{ #category : #accessing }
SpirographPaper >> drawFormOn: aCanvas at: aPoint [

	aCanvas drawImage: form at: aPoint

]

{ #category : #accessing }
SpirographPaper >> extent: aPoint [

	form := ColorForm extent: aPoint depth: 8.
	canvas := form getCanvas.
	center := aPoint / 2.
]

{ #category : #accessing }
SpirographPaper >> movePenAt: aPoint [
	
	| newPenPoint |
	newPenPoint := aPoint translateBy: center.
	canvas line: previousPenPoint to: newPenPoint color: penColor.
	previousPenPoint := newPenPoint.

]

{ #category : #accessing }
SpirographPaper >> penColor: aColor [

	penColor := aColor
]

{ #category : #accessing }
SpirographPaper >> setPenAt: aPoint [
	
	previousPenPoint := aPoint translateBy: center.
]

{ #category : #accessing }
SpirographPaper >> size: anInteger [

	form := ColorForm extent: anInteger @ anInteger.
	canvas := form getCanvas.
	center := form extent / 2.
]
