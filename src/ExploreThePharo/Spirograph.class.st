Class {
	#name : #Spirograph,
	#superclass : #Morph,
	#instVars : [
		'size',
		'outerRadius',
		'radius',
		'penOffset',
		'penColor',
		'centerOfBounds',
		'centerAtStart',
		'penPointStart',
		'previousPenPoint',
		'angle',
		'center',
		'penPoint',
		'form',
		'formCanvas',
		'isStopped',
		'cycle',
		'showCircles'
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

	| rect centerOfTool penPointOfTool |
	
	aCanvas fillOval: self bounds color: Color transparent borderWidth: 1 borderColor: Color black.
	
	centerOfTool := center + self bounds origin.
	penPointOfTool := penPoint + self bounds origin.
	rect := (centerOfTool - radius) corner: (centerOfTool + radius).
	aCanvas fillOval: rect color: Color transparent borderWidth: 1 borderColor: Color black.
	
	aCanvas line: centerOfTool to: penPointOfTool color: Color green.

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
	self radius: 35 penOffset: 10 penColor: Color red.


]

{ #category : #accessing }
Spirograph >> radius: anInteger1 penOffset: anInteger2 penColor: aColor [
	
	radius := anInteger1.
	penOffset := anInteger2.
	centerAtStart := centerOfBounds translateBy: (0@(outerRadius - radius) negated ).
	penPointStart := centerAtStart - (0@(radius - penOffset)).
	previousPenPoint := penPointStart.
	penColor := aColor.
	isStopped := false.
	self reset.


]

{ #category : #initialization }
Spirograph >> reset [
	
	angle := 0.
	cycle := 0.
	previousPenPoint := penPointStart.
	self changed.
]

{ #category : #initialization }
Spirograph >> showCircles [
	
	showCircles := true.
	self changed.


]

{ #category : #accessing }
Spirograph >> size: anInteger [
	
	size := anInteger.
	self extent: size @ size.
	centerOfBounds := self extent / 2.
	outerRadius := size / 2.
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

	(cycle ~= 0 and: [penPointStart =~ penPoint]) ifTrue: [ self stop. ^self ].
	angle := angle + 1.
	cycle := cycle + 1.
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

	| r |
	r := (-2 * Float pi) * (angle / 360).
	center := centerAtStart rotateBy: r about: centerOfBounds.
	penPoint := center - (0@(radius - penOffset)).
	r := (r * outerRadius) / radius.
	penPoint := penPoint rotateBy: r negated about: center.
	formCanvas line: previousPenPoint to: penPoint color: penColor.
	previousPenPoint := penPoint.

]
