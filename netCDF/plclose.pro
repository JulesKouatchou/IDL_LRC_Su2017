
pro  plclose,dum

;+
; NAME:
;   plclose
; PURPOSE:
;   Closes the currently opened graphics file.
; CATEGORY:
;   graphics
; CALLING SEQUENCE:
;   plclose
; FUNCTION RETURN VALUE:
; INPUT PARAMETERS:
; INPUT/OUTPUT PARAMETERS:
; OPTIONAL INPUT/OUTPUT PARAMETERS:
; OUTPUT PARAMETERS:
; OPTIONAL OUTPUT PARAMETERS:
; INPUT KEYWORDS:
; INPUT/OUTPUT KEYWORDS:
; OUTPUT KEYWORDS:
; COMMON BLOCKS:
;   (PLOPCL) for versions < 5.3
;   old_device = device value before executing plopen
; REQUIRED ROUTINES:
; @ FILES:
; RESTRICTIONS:
; SIDE EFFECTS:
; DIAGNOSTIC INFORMATION:
; PROCEDURE:
; EXAMPLES:
; REFERENCE:
; FURTHER INFORMATION:
; RELATED FUNCTIONS AND PROCEDURES:
;   plopen
; MODIFICATION HISTORY:
;   2001-03-08:nash:added system variable
;-

; *****close files
  if  (not execute('device,/close'))  then  begin

;   *****write out message that user is in X session
    message,/cont,'You are in the X window: there is no file to close.'
    return
  endif

; *****get old device so that it can be restored
  if  (!version.release lt '5.3')  then  common  plopcl,old_device $
  else  begin
    defsysv,'!old_device',exists=e
    if  (e)  then  old_device = !old_device $
    else  old_device = !d.name
  endelse

; *****if no old device specified, exit
  if  (n_elements(old_device) eq 0)  then  return

; *****reset old device
  set_plot,old_device

  return
end
