EVAL Class addNewClass: ( Object subclass: 'ClassBrowser' variables: 'window classPane methodPane textPane meta ' classVariables: '')
METHOD ClassBrowser
addDefaultMenu
  | m r |

   m <- Menu new: 'Class'.
   m on: 'New subclass of...' do: [
	Class addNewClass: (Class classes at: classPane getIndex) subclass.
	self resetClassPane].
   m on: 'Rename...' do: [
	r <- Window getString: 'New name for ' + (Class classes at: classPane getIndex) name.
	(Class classes at: classPane getIndex) name: r.
	self resetClassPane].
   m on: 'Delete' do: [
	(Window question: 'Delete ' +  (Class classes at: classPane getIndex) name + '?')
		ifTrue: [Class removeClass: (Class classes at: classPane getIndex)].
	self resetClassPane].
   window addMenu: m.

   m <- Menu new: 'Method'.
   m on: 'Delete' do: [
	(Class classes at: classPane getIndex) removeMethod: 
		((Class classes at: classPane getIndex) methods at:
			methodPane getIndex).
	self methodListFor: classPane getIndex meta: meta list: methodPane].
   m on: 'Test' do: [
	Window notify: textPane getSelectedText].
   window addMenu: m.


!
METHOD ClassBrowser
compile: t intoClass: aClassIndex meta: aBoolean
| c |

aBoolean
	ifTrue: [c <- (Class classes at: aClassIndex) class]
	ifFalse: [c <- (Class classes at: aClassIndex)].

(c compileMethod: t) ifTrue: [
	Window notify: 'compiliation successful']

!
METHOD ClassBrowser
defaultClassPane

^  Pane list: Class classes asStringArray action: [:i |
	meta ifTrue: [ methodPane setList: ((Class classes at: i) class methods collect: [:x | x name]) asArray]
	ifFalse: [methodPane setList: ((Class classes at: i) methods collect: [:x | x name]) asArray]].

!
METHOD ClassBrowser
defaultMethodPane

  ^ Pane list: #() action: [:i | 
	meta ifTrue: [textPane setText: ((Class classes at: classPane getIndex) class methods at: i) text]
	ifFalse: [textPane setText: ((Class classes at: classPane getIndex) methods at: i) text]].

!
METHOD ClassBrowser
defaultTextpane | t |
   t <- Pane textArea.
  t setText: '
















'.

  ^ t

!
METHOD ClassBrowser
methodListFor: aClassIndex meta: aBoolean list: aPane

aBoolean ifTrue: [ aPane setList: ((Class classes at: aClassIndex) class methods collect: [:x | x name]) asArray]
	ifFalse: [aPane setList: ((Class classes at: aClassIndex) methods collect: [:x | x name]) asArray]].



!
METHOD ClassBrowser
open |  m m2 m3 m4 m5 m6|

   meta <- false.
   textPane <- self defaultTextpane.
   classPane <- self defaultClassPane.
   methodPane <- self defaultMethodPane.

   "Buttons"
   m2 <- (Pane title: 'class' action: [meta <- true. self methodListFor: (classPane getIndex) meta: meta list: methodPane. textPane setText: '']).
   m3 <- (Pane title: 'instance' action: [meta <- false. self methodListFor: (classPane getIndex) meta: meta list: methodPane.  textPane setText: '']).
   m4 <- Pane west: m3 east: m2.
   m <-  Pane north: methodPane center: m4 south: nil.

   "Botton Buttons"
   m5 <- Pane title: 'compile' action: [
	self compile: textPane getText intoClass: classPane getIndex meta: meta.
	self methodListFor: classPane getIndex meta: meta list: methodPane].
   m6 <- Pane north: nil center: textPane south: m5.

   window <- Window new title: 'Browser'. 
   window width: 600 height: 530.
   window setPane: (Pane north: nil south: m6 east: nil west: classPane center: m).
   self addDefaultMenu.
   window show.

!
METHOD ClassBrowser
resetClassPane

classPane setList: Class classes asStringArray 

!
META ClassBrowser
open

^ self new open

!