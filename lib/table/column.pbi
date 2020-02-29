;{-------------------------------------------
; AUTHOR    : MicrodevWeb
; DATE      : 2020-02-27
; CLASS     : column (ABSTRACT)
; VERSION   : 
; PROCESS   : 
;}-------------------------------------------
DeclareModule COLUMN
  Prototype p_draw(*this,x,y,h,w)
  Structure _members
	  *methods
	  title.s
	  fgColor.l
	  bgColor.l
	  width.d
	  ; abstract methods
	  _drawTitle.p_draw
	EndStructure
	Declare _super(*this._members,*s_daughter,*E_daughter,title.s,width.d)
	Macro super(title,width)
		COLUMN::_super(*this,?S_MET,?E_MET,title,width)
	EndMacro
EndDeclareModule

Module COLUMN
  EnableExplicit
  Declare _drawTitle(*this._members,x,y,h)
  ; super constructor
	Procedure _super(*this._members,*s_daughter,*E_daughter,title.s,width.d)
		With *this
			; allocate memory
			Protected motherLen = ?E_MET - ?S_MET,
				daughterLen = *E_daughter - *s_daughter
			\methods = AllocateMemory(motherLen + daughterLen)
			; empilate methods address
			MoveMemory(?S_MET,\methods,motherLen)
			MoveMemory(*s_daughter,\methods + motherLen,daughterLen)
			; set value
			\title = title
			\width = width
			; set abstract methods
			\_drawTitle = @_drawTitle()
		EndWith
	EndProcedure
	;{ GETTERS AND SETTES
	Procedure.s getTitle(*this._members)
	  With *this
	    ProcedureReturn \title
	  EndWith
	EndProcedure
	
	Procedure setTitle(*this._members,title.s)
	  With *this
	    \title = title
	  EndWith
	EndProcedure
	
	Procedure.l getFgColor(*this._members)
	  With *this
	    ProcedureReturn \fgColor
	  EndWith
	EndProcedure
	
	Procedure setFgColor(*this._members,fgColor.l)
	  With *this
	    \fgColor = fgColor
	  EndWith
	EndProcedure
	
	Procedure.l getBgColor(*this._members)
	  With *this
	    ProcedureReturn \bgColor
	  EndWith
	EndProcedure
	
	Procedure setBgColor(*this._members,bgColor.l)
	  With *this
	    \bgColor = bgColor
	  EndWith
	EndProcedure

	Procedure.d getWidth(*this._members)
	  With *this
	    ProcedureReturn \width
	  EndWith
	EndProcedure
	
	Procedure setWidth(*this._members,width.d)
	  With *this
	    \width = width
	  EndWith
	EndProcedure



	;}
	
	;{ ABSTRACT METHODS
  ;{-------------------------------------------
  ; METHOD     : _drawTitle
  ; PARAMETERS : x,y
  ; RETURN     : void
  ; PROCESS    : draw title of column
  ;}-------------------------------------------
	Procedure _drawTitle(*this._members,x,y,h)
	  With *this
	    
	  EndWith
	EndProcedure


	;}
	
	
	DataSection
	  S_MET:
	  ;{ GETTERS AND SETTES
	  Data.i @getTitle()
	  Data.i @setTitle()
	  Data.i @getFgColor()
	  Data.i @setFgColor()
	  Data.i @getBgColor()
	  Data.i @setBgColor()
	  Data.i @getWidth()
	  Data.i @setWidth()
    ;}
    E_MET:
	  
	EndDataSection
EndModule
XIncludeFile "stringColumn.pbi" ; extends from column
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 8
; Folding = eAo-
; EnableXP