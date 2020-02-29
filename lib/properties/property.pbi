;{-------------------------------------------
; AUTHOR    : microdev
; DATE      : 2020-02-28
; CLASS     : property (abstract)
; VERSION   : 1.0
; PROCESS   : 
;}-------------------------------------------
XIncludeFile "../../fifo/includes/fifo.pbi"
DeclareModule PROPERTY
  Structure _members
    *methods
    List *callback()
    mutex.l
    *pdata
  EndStructure
  Declare _super(*this._members,*s_daughter,*E_daughter)
  Macro super()
    PROPERTY::_super(*this,?S_MET,?E_MET)
  EndMacro
  Global callbackFifo.FIFO::object = FIFO::new(10)
  Structure _do
    *callback
    *propety
  EndStructure
EndDeclareModule

Module PROPERTY
  Global idThread
  Prototype call(*this)
  ; super constructor
  Procedure _super(*this._members,*s_daughter,*E_daughter)
    With *this
      ; allocate memory
      Protected motherLen = ?E_MET - ?S_MET,
                daughterLen = *E_daughter - *s_daughter
      \methods = AllocateMemory(motherLen + daughterLen)
      ; empilate methods address
      MoveMemory(?S_MET,\methods,motherLen)
      MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
      \mutex = CreateMutex()
    EndWith
  EndProcedure
  
  ;{ TREADS METHODS
  Procedure TRH_call_callback(*para)
    Protected *do._do,func.call
    Repeat
      *do = callbackFifo\pop()
      func = *do\callback
      func(*do\propety)
      FreeStructure(*do)
    ForEver 
  EndProcedure
  ;}
  
  ;{ PUBLIC METHODS
  ;{-------------------------------------------
  ; METHOD     : addBind
  ; PARAMETERS : *callback -> pointer of your function
  ;              ex : myFonction(*proterty.PROPERTIES::stringProperty)
  ; RETURN     : void
  ; PROCESS    : bind a proterty with a function
  ;}-------------------------------------------
  Procedure addBind(*this._members,*callback)
    With *this
      AddElement(\callback())
      \callback() = *callback
      ; listen all events for all properties
      If Not IsThread(idThread)
        idThread = CreateThread(@TRH_call_callback(),0)
      EndIf
    EndWith
  EndProcedure
  ;}
  
  ;{ GETTERS AND SETTERS
  Procedure. getPdata(*this._members)
    With *this
      ProcedureReturn \pdata
    EndWith
  EndProcedure
  
  Procedure setPdata(*this._members,pdata)
    With *this
      \pdata = pdata
    EndWith
  EndProcedure
  ;}
  
  
  
  DataSection
    S_MET:
    ;{ GETTERS AND SETTERS
    Data.i @getPdata()
    Data.i @setPdata()
    ;}
    Data.i @addBind()
    E_MET:
  EndDataSection
EndModule
XIncludeFile "string_property.pbi"
XIncludeFile "long_property.pbi"
XIncludeFile "double_property.pbi"
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 82
; FirstLine = 58
; Folding = ---
; EnableXP