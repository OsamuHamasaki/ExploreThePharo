Class {
	#name : #Spirograph,
	#superclass : #Morph,
	#instVars : [
		'paper',
		'showCircles',
		'roter',
		'fillColor',
		'borderColor'
	],
	#category : #ExploreThePharo
}

{ #category : #'instance creation' }
Spirograph class >> open [
	"Spirograph open"
	| aMorph |
	aMorph := self new
		openInWindow;
		stop;
		yourself.
	^aMorph
	
]

{ #category : #initialization }
Spirograph >> clear [
	
	paper clear.
	self changed



]

{ #category : #drawing }
Spirograph >> drawCirclesOn: aCanvas [

	| rects centerOfRoter penPointOfRoter center |
	center := self bounds center.
	
	rects := {
		roter encompassingRectangleForOuterCircle translateBy: center . 
		roter encompassingRectangle translateBy: center }.
		
	rects do: [ :rect |
		aCanvas fillOval: rect color: fillColor borderWidth: 1 borderColor: borderColor.].
		
	centerOfRoter := roter center translateBy: center.
	penPointOfRoter := roter penLocation translateBy: center.
	aCanvas line: centerOfRoter  to: penPointOfRoter color: Color green.

]

{ #category : #drawing }
Spirograph >> drawOn: aCanvas [
	
	self drawPaperOn: aCanvas.
	showCircles ifTrue: [ self drawCirclesOn: aCanvas ].

]

{ #category : #drawing }
Spirograph >> drawPaperOn: aCanvas [
	
	paper drawFormOn: aCanvas at: self bounds origin.

]

{ #category : #initialization }
Spirograph >> hideCircles [
	
	showCircles := false.
	self changed.


]

{ #category : #initialization }
Spirograph >> initialize [
	
	super initialize.
	self stopStepping.
	self showCircles.
	self size: 600.
	roter := SpirographRoter new
		stopBlock: [ self stop ];
		yourself.
	self radius: 35 offset: (300 - 35) penOffset: 25.
	self penColor: Color red.
	fillColor := Color transparent.
	borderColor := Color black.

]

{ #category : #accessing }
Spirograph >> penColor: aColor [
	
	paper penColor: aColor.

]

{ #category : #accessing }
Spirograph >> radius: anInteger1 offset: anInteger2 penOffset: anInteger3 [
	
	roter raius: anInteger1 offset: anInteger2 penOffset: anInteger3 revolutionAngle: 1.
	self reset.


]

{ #category : #initialization }
Spirograph >> reset [
	
	roter reset.
	paper setPenAt: roter penLocation.
	self changed.
]

{ #category : #initialization }
Spirograph >> showCircles [
	
	showCircles := true.
	self changed.


]

{ #category : #accessing }
Spirograph >> size: anInteger [
	
	self extent: anInteger @ anInteger.
	paper := SpirographPaper extent: self extent.
	self clear



]

{ #category : #stepping }
Spirograph >> start [

	super start.
	self changed.
]

{ #category : #stepping }
Spirograph >> step [

	roter revolve.
	paper movePenAt: roter penLocation.
	self changed.
]

{ #category : #stepping }
Spirograph >> stepTime [

	^10

]

{ #category : #stepping }
Spirograph >> stop [

	super stop.
	self changed.
]
