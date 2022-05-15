"
I am a ImageMorph for displaying image around current mouse pointer.

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
	#name : #ImageAtCursorMorph,
	#superclass : #ImageMorph,
	#category : #ExploreThePharo
}

{ #category : #'instance creation' }
ImageAtCursorMorph class >> openInPresenter [

	"self openInPresenter"
	
	| aMorph aPresenter aForm |
	aForm := self currentWorld imageFormForRectangle: Rectangle fromUser.
	aMorph := self withForm: aForm.
	aMorph startStepping.
	aPresenter := SpMorphPresenter new.
	aPresenter morph: aMorph.
	aPresenter asWindow extent: aMorph extent.
	aPresenter open.
]

{ #category : #'stepping and presenter' }
ImageAtCursorMorph >> step [
	
	| cursorPoint aForm |
	cursorPoint := self currentWorld activeHand cursorPoint.
	aForm := self currentWorld imageFormForRectangle: (cursorPoint extent: self extent).
	self form: aForm.
]

{ #category : #'stepping and presenter' }
ImageAtCursorMorph >> stepTime [
	
	^10
]
