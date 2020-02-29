XIncludeFile "../lib/table/table.pbi"
DeclareModule MEMORY_TABLE
  Interface table
    ;{ GETTERS AND SETTERS
	  getTitle.s()
	  setTitle(title.s)
	  getBgColor()
	  setBgColor(color)
	  getFgColor()
	  setFgColor(color)
	  getPx()
	  setPx(x)
	  getPy()
	  setPy(y)
	  getWidth()
	  setWidth(width)
	  getHeight()
	  setHeight(height)
	  getTitleHeight()
	  setTitleHeight(height)
	  getTitleFont()
	  setTitleFont(font)
	  getColumnTitleHeight()
	  setColumnTitleHeight(height)
	  ;}
	  ;{ PUBLIC METHODS
	  addColumn(column)
	  draw()
	  ;}
  EndInterface
  Interface _column
    ;{ GETTERS AND SETTERS
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
  Interface stringColumn
    
  EndInterface
  
  Declare newTable(x,y,width,height,title.s = "")
  Declare newStringColumn(title.s,width.d)
EndDeclareModule
Module MEMORY_TABLE
  Procedure newTable(x,y,width,height,title.s = "")
    ProcedureReturn TABLE::new(x,y,width,height,title)
  EndProcedure
  Procedure newStringColumn(title.s,width.d)
    ProcedureReturn STRING_COLUMN::new(title,width)
  EndProcedure
EndModule

; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 31
; FirstLine = 18
; Folding = --
; EnableXP