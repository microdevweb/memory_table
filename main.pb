XIncludeFile "include/memoryTable.pbi"

table.MEMORY_TABLE::table = MEMORY_TABLE::newTable(10,10,300,580,"List of person")
table\addColumn(MEMORY_TABLE::newStringColumn("name",0.6))

OpenWindow(0,0,0,800,600,"test",#PB_Window_ScreenCentered|#PB_Window_SystemMenu)
table\draw()

Repeat
  WaitWindowEvent()
Until Event() = #PB_Event_CloseWindow
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 2
; EnableXP