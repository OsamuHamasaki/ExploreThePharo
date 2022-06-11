"
I am a Morph represent a gauge on a model.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #GaugeMorph,
	#superclass : #Morph,
	#category : #ExploreThePharo
}

{ #category : #'event handling' }
GaugeMorph >> handlesMouseDown: evt [
	
	^true
]

{ #category : #'event handling' }
GaugeMorph >> mouseDown: evt [
	
	('Mouse down', evt cursorPoint printString) crTrace.
]

{ #category : #'event handling' }
GaugeMorph >> mouseMove: evt [
	
	('Mouse move on ', evt cursorPoint printString) crTrace.
]

{ #category : #'event handling' }
GaugeMorph >> mouseUp: evt [
	
	('Mouse up', evt cursorPoint printString) crTrace.
]
