;{-------------------------------------------
; AUTHOR    : microdev
; DATE      : 2020-02-29
; CLASS     : long_property
; VERSION   : 
; PROCESS   : 
;}-------------------------------------------
DeclareModule LONG_PROPERTY
  Structure _members Extends PROPERTY::_members
    value.l
  EndStructure
  Declare _super(*this._members,*s_daughter,*E_daughter)
  Macro super()
    LONG_PROPERTY::_super(*this,?S_MET,?E_MET)
  EndMacro
  Declare new()
EndDeclareModule

Module LONG_PROPERTY
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
    EndWith
  EndProcedure
  
  ;{-------------------------------------------
  ; CONSTRUCTOR   : new
  ; PARAMETER     : 
  ;}-------------------------------------------
  Procedure new()
    Protected *this._members = AllocateStructure(_members)
    With *this
      PROPERTY::super()
      ProcedureReturn *this
    EndWith
  EndProcedure
  
  ;{ GETTERS AND SETTERS
  Procedure.l getValue(*this._members)
    With *this
      Protected vRet
      LockMutex(\mutex)
      vRet = \value
      UnlockMutex(\mutex)
      ProcedureReturn vRet
    EndWith
  EndProcedure
  
  Procedure setValue(*this._members,value.l)
    With *this
      Protected *do.PROPERTY::_do
      LockMutex(\mutex)
      \value = value
      ForEach \callback()
	      *do = AllocateStructure(PROPERTY::_do)
	      *do\callback = \callback()
	      *do\propety = *this
	      PROPERTY::callbackFifo\push(*do)
	    Next
      UnlockMutex(\mutex)
    EndWith
  EndProcedure
  
  
  ;}
  
  DataSection
    S_MET:
    ;{ GETTERS AND SETTERS
    Data.i @getValue()
    Data.i @setValue()
    ;}
    E_MET:
  EndDataSection
EndModule
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 57
; FirstLine = 53
; Folding = ---
; EnableXP