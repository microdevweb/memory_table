;{-------------------------------------------
; AUTHOR    : MicrodevWeb
; DATE      : 2020-02-27
; CLASS     : string_column EXTENDS OF column
; VERSION   : 
; PROCESS   : 
;}-------------------------------------------
DeclareModule STRING_COLUMN 
	Structure _members Extends  COLUMN::_members
	
	EndStructure
	Declare _super(*this._members,*s_daughter,*E_daughter)
	Macro super()
		STRING_COLUMN::_super(*this,?S_MET,?E_MET)
	EndMacro
	Declare new(title.s,width.d)
EndDeclareModule

Module STRING_COLUMN
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
	; PARAMETER     : title.s,width.d
	;}-------------------------------------------
	Procedure new(title.s,width.d)
		Protected *this._members = AllocateStructure(_members)
		With *this
			COLUMN::super(title,width)
			ProcedureReturn *this
		EndWith
	EndProcedure
	
	
	DataSection
	  S_MET:
    E_MET:
	EndDataSection
EndModule
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 34
; FirstLine = 1
; Folding = W-
; EnableXP