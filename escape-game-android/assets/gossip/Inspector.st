EVAL Class addNewClass: (Object subclass: 'Inspector' variables: 'pane target varsPane valuePane sourcePane window' classVariables: '')
META Inspector
new: anObject
	^ self new inspect: anObject
!

METHOD Inspector
addDefaultMenu
   | m |

   m := Menu new: 'information'. 
   m on: 'printString' do: [ Inspector new open: target printString ].
   m on: 'class' do: [ Inspector new open: target class ].
   
   window addMenu: m.
!
METHOD Inspector
layout
    ^ '(COLUMN
            (ROW weight=0.45
                variables
                value)
             source)
        '.
!
METHOD Inspector
defaultVarsPane
    ^ ListPane list: target class instanceVariables action: [ :i |
            valuePane setText: 
                (Object in: target at: i) printString ]
!
METHOD Inspector
defaultValuePane
    | t |
    
    t := TextArea textArea.
    t keystroke: 'control D' action: [ self doIt ].
    
    ^ t
!
METHOD Inspector
defaultSourcePane
	| t |
	
	t := TextArea textArea.
    t keystroke: 'control D' action: [ self doIt ].
    t keystroke: 'control P' action: [ self printIt ].
    t keystroke: 'control I' action: [ self inspectIt ].
    
    ^ t    
!
METHOD Inspector
open: anObject
    | layout |

    target := anObject.

    layout := self layout.
    pane := MultiSplitPane newWithLayout: layout.

    varsPane := self defaultVarsPane.
    pane add: varsPane at: 'variables'.

    valuePane := self defaultValuePane.
    pane add: valuePane at: 'value'.

    sourcePane := self defaultSourcePane.
    pane add: sourcePane at: 'source'.

    window := Window new title: 'Inspector - ' , anObject printString.
    window width: 400 height: 400.
    window setPane: pane javaObject.
    
    self addDefaultMenu.
    window show
!
