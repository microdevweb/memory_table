; -----------------------------------------------------------------------------
; MODULE      : fifo
; PROCESS     : manage a fifo list
; VERSION     : 1.0
; -----------------------------------------------------------------------------
Module FIFO
  EnableExplicit
  Structure _FIFO
    *methods
    Array  *buffer(0) ; you can change this buffer with any variable type
    buffer_length.i
    input.i
    output.i
    items.i
    spaces.i
    mutex.i
  EndStructure
  ; ---------------------------------------------------------------------------
  ; CONSTRUCTOR : new
  ; ARGUMENTS   : buffer_length.i -> length of buffer minimum 1
  ; RETURN      : instance of fifo
  ; ---------------------------------------------------------------------------
  Procedure new(buffer_length.i)
    Protected *this._FIFO = AllocateStructure(_FIFO)
    With *this
      \methods = ?S_MTH
      \input = 0
      \output = 0
      \buffer_length = buffer_length
      ; initiation of semaphores and mutex
      \items = CreateSemaphore(0)
      \spaces = CreateSemaphore(buffer_length)
      \mutex = CreateMutex()
      ReDim \buffer(buffer_length)
      ProcedureReturn *this
    EndWith
  EndProcedure
  ; ---------------------------------------------------------------------------
  ; PUBLIC METHOD : push
  ; PROCESS       : push a data into the fifo list
  ; ARGUMENTS     : *item -> adresse to item
  ; RETURN        : VOID
  ; ---------------------------------------------------------------------------
  Procedure push(*this._FIFO,item)
    With *this
      WaitSemaphore(\spaces)      ; wait for space into the buffer
      LockMutex(\mutex)           ; mutual exclusion
      \buffer(\input) = item      ; push into the list
      \input +1                   ; next list position
                                  ; manage circular list
      If \input >= \buffer_length ; uper to buufer length
        \input = 0 
      EndIf
      UnlockMutex(\mutex)         ; end of mutual exclusion
      SignalSemaphore(\items)     ; tel data available
    EndWith
  EndProcedure
  ; ---------------------------------------------------------------------------
  ; PUBLIC METHOD : pop
  ; PROCESS       : pop a data from the fifo list
  ; ARGUMENTS     : VOID
  ; RETURN        : pointer of data adresse
  ; ---------------------------------------------------------------------------
  Procedure pop(*this._FIFO)
    With *this
      Protected returned_value = 0
      WaitSemaphore(\items)               ; wait for data available
      LockMutex(\mutex)                   ; mutual exclusion
      returned_value = \buffer(\output)   ; load from the List
      \output +1                          ; next list position
                                          ; manage circular list
      If \output >= \buffer_length        ; uper to bufer length
        \output = 0 
      EndIf
      UnlockMutex(\mutex)                 ; End of mutual exclusion
      SignalSemaphore(\spaces)            ; tel space available
      ProcedureReturn  returned_value
    EndWith
  EndProcedure
  ; ---------------------------------------------------------------------------
  ; PUBLIC METHOD : free
  ; PROCESS       : free fifo list
  ; ARGUMENTS     : VOID
  ; RETURN        : VOID
  ; ---------------------------------------------------------------------------
  Procedure free(*this._FIFO)
    With *this
      FreeSemaphore(\spaces)
      FreeSemaphore(\items)
      FreeMutex(\mutex)
      FreeStructure(*this)
    EndWith
  EndProcedure
  DataSection
    S_MTH:
    Data.i @push()
    Data.i @pop()
    Data.i @free()
    E_MTH:
  EndDataSection
EndModule
; IDE Options = PureBasic 5.72 LTS Beta 1 (Windows - x64)
; CursorPosition = 9
; Folding = --
; EnableXP