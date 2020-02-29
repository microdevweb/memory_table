; -----------------------------------------------------------------------------
; MODULE      : fifo
; PROCESS     : manage a fifo list
; VERSION     : 1.0
; -----------------------------------------------------------------------------
DeclareModule FIFO
  Interface object
    ; ---------------------------------------------------------------------------
    ; PUBLIC METHOD : push
    ; PROCESS       : push a data into the fifo list
    ; ARGUMENTS     : *item -> adresse to item
    ; RETURN        : VOID
    ; ---------------------------------------------------------------------------
    push(item)
    ; ---------------------------------------------------------------------------
    ; PUBLIC METHOD : pop
    ; PROCESS       : pop a data from the fifo list
    ; ARGUMENTS     : VOID
    ; RETURN        : pointer of data adresse
    ; ---------------------------------------------------------------------------
    pop()
    ; ---------------------------------------------------------------------------
    ; PUBLIC METHOD : free
    ; PROCESS       : free fifo list
    ; ARGUMENTS     : VOID
    ; RETURN        : VOID
    ; ---------------------------------------------------------------------------
    free()
  EndInterface
  ; ---------------------------------------------------------------------------
  ; CONSTRUCTOR : new
  ; ARGUMENTS   : buffer_length.i -> length of buffer minimum 1
  ; RETURN      : instance of fifo
  ; ---------------------------------------------------------------------------
  Declare new(buffer_length.i)
EndDeclareModule

XIncludeFile "../lib/fifo/_fifo.pbi"
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 37
; Folding = +
; EnableXP