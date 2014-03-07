EVAL Class addNewClass: ( Object subclass: 'ClassBrowser2' variables: 'window classPane methodPane textPane meta sidePane ' classVariables: '')
METHOD ClassBrowser2
addDefaultMenu
    | m r |
    
    m <- Menu new: 'Class'.
   	m on: 'New subclass of...' do: [ 
	    Class addNewClass: (Class classes at: classPane getIndex) subclass.
	    self resetClassPane ].
    m on: 'Rename...' do: [ 
	    r <- Window getString: 'New name for ' + (Class classes at: classPane getIndex) name.
	    (Class classes at: classPane getIndex) name: r.
	    self resetClassPane ].
    m on: 'Delete' do: [ 
	(Window question: 'Delete ' +  (Class classes at: classPane getIndex) name + '?')
        ifTrue: [ Class removeClass: (Class classes at: classPane getIndex) ].
    self resetClassPane ].
    window addMenu: m.

    m <- Menu new: 'Method'.
    m on: 'Delete' do: [ 
	    (Class classes at: classPane getIndex) removeMethod: 
		    ((Class classes at: classPane getIndex) methods at:
			    methodPane getIndex).
        self methodListFor: classPane getIndex meta: meta list: methodPane ].
    m on: 'Test' do: [ 
        Window notify: textPane getSelectedText ].
    window addMenu: m.

!
METHOD ClassBrowser2
compile: t intoClass: aClassIndex meta: aBoolean
    | c |

    aBoolean
        ifTrue: [ c <- (Class classes at: aClassIndex) class ]
        ifFalse: [ c <- (Class classes at: aClassIndex) ].

    (c compileMethod: t) ifTrue: [
	    Window notify: 'compilation successful' ]

!
METHOD ClassBrowser2
defaultClassPane
    ^ Pane list: Class classes asStringArray action: [ :i |
        meta
            ifTrue: [ methodPane setList: ((Class classes at: i) class methods collect: [ :x | x name ]) asArray ]
            ifFalse: [ methodPane setList: ((Class classes at: i) methods collect: [ :x | x name ]) asArray ].
    sidePane setText: (Documentation for: (Class classes at: i))
    ].

!
METHOD ClassBrowser2
defaultDocumentationPane
    | t |

    t := Pane textArea.
    t setText: ''.
    ^ t

!
METHOD ClassBrowser2
defaultMethodPane
    ^ Pane list: #() action: [:i | 
        meta
            ifTrue: [textPane setText: 
                ((Class classes at: classPane getIndex) class methods at: i) text]
            ifFalse: [textPane setText: 
                ((Class classes at: classPane getIndex) methods at: i) text]].

!
METHOD ClassBrowser2
defaultTextPane
    | t |

    t <- Pane textArea.
    t setText: '
















'.
    ^ t

!
METHOD ClassBrowser2
layout
    ^ '(COLUMN
            (ROW weight=0.45
                classes
                (COLUMN
                    (LEAF name=namespaces weight=0.9)
                    (ROW weight=0.10
                        instanceButton
                        metaButton))
                methods)
            (ROW weight=0.10
                b1 b2 b3 b4 b5 b6)
            (ROW weight=0.45
                (LEAF name=source weight=0.45)
                (LEAF name=sidePane weight=0.45)
                (COLUMN
                    docButton
                    instVarsButton
                    classVarsButton)))
        '.

!
METHOD ClassBrowser2
methodListFor: aClassIndex meta: aBoolean list: aPane
    aBoolean 
        ifTrue: [ 
            aPane setList: 
                ((Class classes at: aClassIndex) class methods collect: [:x | x name]) asArray ]
        ifFalse: [ 
            aPane setList: 
                ((Class classes at: aClassIndex) methods collect: [:x | x name]) asArray ].

!
METHOD ClassBrowser2
open
    | layout classes namespaces instanceButton metaButton methods source pane b1 b2 b3 b4 b5 b6 |

    meta := false.
    layout := self layout.
    pane := MultiSplitPane newWithLayout: layout.

    classPane := self defaultClassPane.
    pane add: classPane at: 'classes'.

    namespaces := self defaultMethodPane.
    pane add: namespaces at: 'namespaces'.

    instanceButton := Pane title: 'instance' action: [ 
        meta <- false.
        self methodListFor: (classPane getIndex) meta: meta list: methodPane.
        textPane setText: '' ].
    pane add: instanceButton at: 'instanceButton'.

    metaButton := Pane title: 'meta' action: [ 
        meta <- true.
        self methodListFor: (classPane getIndex) meta: meta list: methodPane.
        textPane setText: '' ].
    pane add: metaButton at: 'metaButton'.

    methodPane := self defaultMethodPane.
    pane add: methodPane at: 'methods'.

    b1 := Pane title: 'compile' action: [
        self compile: textPane getText intoClass: classPane getIndex meta: meta.
        self methodListFor: classPane getIndex meta: meta list: methodPane ].
    pane add: b1 at: 'b1'.

    b2 := Pane title: 'save doc' action: [
        Documentation for: (Class classes at: classPane getIndex) setTo: sidePane getText ].
    pane add: b2 at: 'b2'.

    textPane := self defaultTextPane.
    pane add: textPane at: 'source'.

    sidePane := self defaultDocumentationPane.
    pane add: sidePane at: 'sidePane'.

    window := Window new title: 'Gossip Class Browser'.
    window width: 400 height: 300.
    window setPane: pane javaObject.
    self addDefaultMenu.
    window show

!
METHOD ClassBrowser2
resetClassPane
    classPane setList: Class classes asStringArray 

!
META ClassBrowser2
open
    ^ self new open


!
