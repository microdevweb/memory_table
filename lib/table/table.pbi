;{-------------------------------------------
; AUTHOR    : MicrodevWeb
; DATE      : 2020-02-27
; CLASS     : table
; VERSION   : 1.0
; PROCESS   : memry table
;}-------------------------------------------
XIncludeFile "column.pbi"
DeclareModule TABLE
  Interface _column
    ;{ GETTERS AND SETTES
	  getTitle.s()
	  setTitle(title.s)
	  getFgColor()
	  setFgColor(color)
	  getBgColor()
	  setBgColor(color)
	  getWidth()
	  setWidth(width.d)
	  ;} 
  EndInterface
  Structure _members
	  *methods
	  title.s
	  bgColor.l
	  fgColor.l
	  px.l
	  py.l
	  width.l
	  height.l
	  List myColumns._column()
	  idCanvas.l
	  idScrollV.l
	  idScrollH.l
	  scrollSize.l
	  titleHeight.l
	  titleFont.l
	  columnTitleHeight.l
	EndStructure
	Declare _super(*this._members,*s_daughter,*E_daughter)
	Macro super()
		TABLE::_super(*this,?S_MET,?E_MET)
	EndMacro
	Declare new(x,y,width,height,title.s = "")
EndDeclareModule

Module TABLE
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
	Procedure new(x,y,width,height,title.s = "")
		Protected *this._members = AllocateStructure(_members)
		With *this
			\methods = ?S_MET 
			\title = title
			\bgColor = $FE616161
			\fgColor = $FEFFFFFF
			\px = x
			\py = y
			\width = width
			\height = height
			\scrollSize = 12
			\titleHeight = 30
			\titleFont = LoadFont(#PB_Any,"arial",11,#PB_Font_HighQuality|#PB_Font_Bold)
			ProcedureReturn *this
		EndWith
	EndProcedure
	;{ GETTERS AND SETTERS
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
	
	Procedure.l getPx(*this._members)
	  With *this
	    ProcedureReturn \px
	  EndWith
	EndProcedure
	
	Procedure setPx(*this._members,px.l)
	  With *this
	    \px = px
	  EndWith
	EndProcedure
	
	Procedure.l getPy(*this._members)
	  With *this
	    ProcedureReturn \py
	  EndWith
	EndProcedure
	
	Procedure setPy(*this._members,py.l)
	  With *this
	    \py = py
	  EndWith
	EndProcedure

	Procedure.l getWidth(*this._members)
	  With *this
	    ProcedureReturn \width
	  EndWith
	EndProcedure
	
	Procedure setWidth(*this._members,width.l)
	  With *this
	    \width = width
	  EndWith
	EndProcedure
	
	Procedure.l getHeight(*this._members)
	  With *this
	    ProcedureReturn \height
	  EndWith
	EndProcedure
	
	Procedure setHeight(*this._members,height.l)
	  With *this
	    \height = height
	  EndWith
	EndProcedure
	
	Procedure.l getTitleHeight(*this._members)
	  With *this
	    ProcedureReturn \titleHeight
	  EndWith
	EndProcedure
	
	Procedure setTitleHeight(*this._members,titleHeight.l)
	  With *this
	    \titleHeight = titleHeight
	  EndWith
	EndProcedure

	Procedure.l getTitleFont(*this._members)
	  With *this
	    ProcedureReturn \titleFont
	  EndWith
	EndProcedure
	
	Procedure setTitleFont(*this._members,titleFont.l)
	  With *this
	    \titleFont = titleFont
	  EndWith
	EndProcedure

	Procedure.l getColumnTitleHeight(*this._members)
	  With *this
	    ProcedureReturn \columnTitleHeight
	  EndWith
	EndProcedure
	
	Procedure setColumnTitleHeight(*this._members,columnTitleHeight.l)
	  With *this
	    \columnTitleHeight = columnTitleHeight
	  EndWith
	EndProcedure


	;}
	
	;{ PRIVATE METHODS
  ;{-------------------------------------------
  ; METHOD     : _concatene
  ; PARAMETERS : text.s   -> text to concatene
	;              maxWidth -> maximum width of text
  ; RETURN     : new text
  ; PROCESS    : concatene text if it's is greater to
	;              meximum width
  ;}-------------------------------------------
	Procedure.s _concatene(*this._members,text.s,maxWidth)
	  With *this
	    Protected vRet.s = text
	    Protected w = VectorTextWidth(vRet)
	    While VectorTextWidth(vRet) > maxWidth
	      vRet = Left(vRet,Len(vRet) - 4) +"..."
	      If Len(vRet) <= 4
	        ProcedureReturn vRet
	      EndIf
	    Wend
	    ProcedureReturn  vRet
	  EndWith
	EndProcedure


  ;{-------------------------------------------
  ; METHOD     : _drawTitle
  ; PARAMETERS : void
  ; RETURN     : void
  ; PROCESS    : drawtable title if it declared
  ;}-------------------------------------------
	Procedure _drawTitle(*this._members)
	  With *this
	    If Len(\title)
	      VectorFont(FontID(\titleFont))
	      Protected title.s = _concatene(*this,\title,\width-30),
	                yc = (\titleHeight / 2) - (VectorParagraphHeight(title,\width-20,\titleHeight) / 2)
	      VectorSourceColor(\fgColor)
	      MovePathCursor(10,yc)
	      DrawVectorParagraph(title,\width-30,\titleHeight,#PB_VectorParagraph_Center)
	    EndIf
	  EndWith
	EndProcedure
	
	Procedure _drawColumn(*this._members)
	  With *this
	    Protected w.d,x,y 
	    If Len(\title)
	      y = \titleHeight
	    EndIf
	    ForEach \myColumns()
	      Define *c.COLUMN::_members = \myColumns()
	      w = *c\_drawTitle(\myColumns(),x,y,\columnTitleHeight,\width)
	      x + w
	    Next
	  EndWith
	EndProcedure
	
	;{-------------------------------------------
  ; METHOD     : _draw
  ; PARAMETERS : void
  ; RETURN     : void
  ; PROCESS    : 
  ;}-------------------------------------------
	Procedure _draw(*this._members)
		With *this
		  StartVectorDrawing(CanvasVectorOutput(\idCanvas))
		  VectorSourceColor(\bgColor)
		  FillVectorOutput()
		  _drawTitle(*this)
		  StopVectorDrawing()
		EndWith
	EndProcedure

	;}
	
	;{ PUBLIC METHODS
  ;{-------------------------------------------
  ; METHOD     : addColumn
  ; PARAMETERS : *column
  ; RETURN     : *column
  ; PROCESS    : 
  ;}-------------------------------------------
	Procedure addColumn(*this._members,*column)
	  With *this
	    AddElement(\myColumns())
	    \myColumns() = *column
	    ProcedureReturn \myColumns()
	  EndWith
	EndProcedure
	
	;{-------------------------------------------
	; METHOD     : draw
	; PARAMETERS : 
	; RETURN     : 
	; PROCESS    : 
	;}-------------------------------------------
	Procedure draw(*this._members)
		With *this
		  If Not IsGadget(\idCanvas)
		    \idCanvas = CanvasGadget(#PB_Any,\px,\py,\width,\height,#PB_Canvas_Keyboard|#PB_Canvas_Container)
		    \idScrollV = ScrollBarGadget(#PB_Any,GadgetWidth(\idCanvas) - \scrollSize,0,\scrollSize,
		                                 GadgetHeight(\idCanvas) - \scrollSize,
		                                 0,0,10,#PB_ScrollBar_Vertical)
		    \idScrollV = ScrollBarGadget(#PB_Any,0,GadgetHeight(\idCanvas) - \scrollSize,
		                                 GadgetWidth(\idCanvas) - \scrollSize,\scrollSize,
		                                 0,0,10)
		    CloseGadgetList()
		    _draw(*this)
		  EndIf
		EndWith
	EndProcedure

  
	;}
	
	DataSection
	  S_MET:
	  ;{ GETTERS AND SETTERS
	  Data.i @getTitle()
	  Data.i @setTitle()
	  Data.i @getBgColor()
	  Data.i @setBgColor()
	  Data.i @getFgColor()
	  Data.i @setFgColor()
	  Data.i @getPx()
	  Data.i @setPx()
	  Data.i @getPy()
	  Data.i @setPy()
	  Data.i @getWidth()
	  Data.i @setWidth()
	  Data.i @getHeight()
	  Data.i @setHeight()
	  Data.i @getTitleHeight()
	  Data.i @setTitleHeight()
	  Data.i @getTitleFont()
	  Data.i @setTitleFont()
	  Data.i @getColumnTitleHeight()
	  Data.i @setColumnTitleHeight()

	  ;}
	  ;{ PUBLIC METHODS
	  Data.i @addColumn()
	  Data.i @draw()
	  ;}
	  E_MET:
	EndDataSection
EndModule
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 256
; Folding = gAAAAhAw
; EnableXP