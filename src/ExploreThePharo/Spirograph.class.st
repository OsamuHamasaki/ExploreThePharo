Class {
	#name : #Spirograph,
	#superclass : #Morph,
	#instVars : [
		'penColor',
		'penPointStart',
		'previousPenPoint',
		'form',
		'formCanvas',
		'isStopped',
		'cycle',
		'showCircles',
		'roter'
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
	
	form := ColorForm extent: self extent depth: 8.
	formCanvas := form getCanvas.
	formCanvas fillColor: Color white.
	self changed



]

{ #category : #drawing }
Spirograph >> drawCirclesOn: aCanvas [

	| rect centerOfRoter penPointOfRoter |
	
	rect := roter encompassingRectangleForOuterCircle translateBy: self bounds center.
	aCanvas fillOval: self bounds color: Color transparent borderWidth: 1 borderColor: Color black.
	
	rect := roter encompassingRectangle translateBy: self bounds center.
	aCanvas fillOval: rect color: Color transparent borderWidth: 1 borderColor: Color black.
	
	centerOfRoter := roter center translateBy: self bounds center.
	penPointOfRoter := roter penPoint translateBy: self bounds center.
	aCanvas line: centerOfRoter  to: penPointOfRoter color: Color green.

]

{ #category : #drawing }
Spirograph >> drawOn: aCanvas [
	
	self updateForm.
	aCanvas drawImage: form at: self bounds origin.
	showCircles ifTrue: [ self drawCirclesOn: aCanvas ].

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
	roter := SpirographRoter new.
	self radius: 35 penOffset: 25 penColor: Color red.
	penPointStart := roter penPoint.
	previousPenPoint := penPointStart translateBy: form center.



]

{ #category : #accessing }
Spirograph >> radius: anInteger1 penOffset: anInteger2 penColor: aColor [
	
	roter raius: anInteger1 offset: self extent x / 2 - anInteger1 penOffset: anInteger2 revolutionAngle: 1.
	penColor := aColor.
	isStopped := false.
	self reset.


]

{ #category : #initialization }
Spirograph >> reset [
	
	cycle := 0.
	roter reset.
	penPointStart := roter penPoint.
	previousPenPoint := penPointStart translateBy: form center.
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
	self clear



]

{ #category : #stepping }
Spirograph >> start [

	super start.
	isStopped := false.
	self changed.
]

{ #category : #stepping }
Spirograph >> step [

	(cycle ~= 0 and: [penPointStart =~ roter penPoint]) ifTrue: [ self stop. ^self ].
	cycle := cycle + 1.
	roter revolve.
	self changed.
]

{ #category : #stepping }
Spirograph >> stepTime [

	^10

]

{ #category : #stepping }
Spirograph >> stop [

	super stop.
	isStopped := true.
	self changed.
]

{ #category : #stepping }
Spirograph >> updateForm [

	| penPoint |
	penPoint := roter penPoint translateBy: form center.
	formCanvas line: previousPenPoint to: penPoint color: penColor.
	previousPenPoint := penPoint.

]
