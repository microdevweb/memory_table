;{-------------------------------------------
; AUTHOR    : MicrodevWeb
; DATE      : 2020-02-28
; PACKAGE   : Properties
; VERSION   : 1.0
; PROCESS   : 
;}-------------------------------------------
XIncludeFile "../lib/properties/property.pbi"
DeclareModule PROPERTIES
  Interface _property
    getData()
    setData(*data)
    addBind(callback)
  EndInterface
  Interface stringProperty Extends _property
    getValue.s()
		setValue(value.s)
	EndInterface
	Interface longProperty Extends _property
	  getValue()
    setValue(value)
  EndInterface
  Interface doubleProperty Extends _property
    getValue.d()
	  setValue(value.d)
  EndInterface
	Declare newStringProperty()
	Declare newLongProperty()
	Declare newDoubleProperty()
EndDeclareModule
Module PROPERTIES
  Procedure newStringProperty()
    ProcedureReturn STRING_PROPERTY::new()
  EndProcedure
  Procedure newLongProperty()
    ProcedureReturn LONG_PROPERTY::new()
  EndProcedure
  Procedure newDoubleProperty()
    ProcedureReturn DOUBLE_PROPERTY::new()
  EndProcedure
EndModule

; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 7
; Folding = --
; EnableXP