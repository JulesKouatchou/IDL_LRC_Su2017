pro  plopen,type,fn=fn,color=color,portrait=portrait,landscape=landscape, $
       xoffset=xoffset,xsize=xsize,yoffset=yoffset,ysize=ysize

;+
; NAME:
;   plopen
; PURPOSE:
;   Opens a tek, postscript, or encapsulated postscript file for graphics
;   output.
; CATEGORY:
;   graphics
; CALLING SEQUENCE:
;   plopen
; FUNCTION RETURN VALUE:
; INPUT PARAMETERS:
;   type = (string) file type. Must be one of (upper or lower case):
;            'TEK', 'PS', 'EPS', or 'CPS'.
;             Defaults to 'PS'.
; INPUT/OUTPUT PARAMETERS:
; OPTIONAL INPUT/OUTPUT PARAMETERS:
; OUTPUT PARAMETERS:
; OPTIONAL OUTPUT PARAMETERS:
; INPUT KEYWORDS:
;   color     = (integer) color number to use. See the xlct routine for this
;                 value
;   fn        = (string) file name. Will be appended with '.tek', ',ps',
;                 '.eps', or '.cps'
;   portrait  = (flag) set this to do portrait orientation
;   landscape = (flag) set this to do landscape orientation (default)
;   xoffset   = (float) number of inches to offset in the x direction.
;                 Defaults to 0.75
;   xsize     = (float) size of plotting area in the x direction in inches.
;                 Defaults to 7.0 for portrait and 9.5 for landscape
;   yoffset   = (float) number of inches to offset in the y direction.
;                 Defaults to 0.75 for portrait and 10.25 for landscape
;   ysize     = (float) size of plotting area in the y direction in inches.
;                 Defaults to 9.5 for portrait and 7.0 for landscape
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
;   plclose
; MODIFICATION HISTORY:
;   2001-03-08:nash:added system variable
;-

; *****save old device so that it can be restored in PLCLOSE
  if  (!version.release ge '5.3')  then  defsysv,'!old_device',!d.name $
  else  begin
    common  plopcl,old_device
    old_device = !d.name
  endelse

; *****set default for TYPE and FN
  if  (n_elements(type) eq 0)  then  type = 'PS'
  if  (n_elements(fn) eq 0)  then  fn = 'idl'
  port = ((not keyword_set(landscape)) and (keyword_set(portrait)))
  land = 1-port
  if  (port)  then  begin
    if  (n_elements(xsize) eq 0)  then  xsize = 7
    if  (n_elements(xoffset) eq 0)  then  xoffset = .75
    if  (n_elements(ysize) eq 0)  then  ysize = 9.5
    if  (n_elements(yoffset) eq 0)  then  yoffset = .75
  endif  else  begin
    if  (n_elements(xsize) eq 0)  then  xsize = 9.5
    if  (n_elements(xoffset) eq 0)  then  xoffset = .75
    if  (n_elements(ysize) eq 0)  then  ysize = 7.
    if  (n_elements(yoffset) eq 0)  then  yoffset = 10.25
  endelse
;    device,/portrait,xsize=7,xoffset=.75,ysize=9.5,yoffset=1.5,/inches

if  (!version.release ge '7.1.1')  then  begin

  ; *****set plot to device type wanted
    case  strupcase(type)  of
      'CPS' : begin
        set_plot,'PS'
        device,file=fn+'.cps',/color,encap=0,land=land,port=port, $
          /inch,xsize=xsize,ysize=ysize,xoffset=xoffset,yoffset=yoffset, $
          decomposed=((n_elements(color) eq 0) || (color lt 0))
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      'EPS' : begin
        set_plot,'PS'
        device,file=fn+'.eps',color=color,encap=1,land=land,port=port, $
          /inch,xsize=xsize,ysize=ysize,xoffset=xoffset,yoffset=yoffset, $
          decomposed=((n_elements(color) eq 0) || (color lt 0))
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      'PS'  : begin
        set_plot,'PS'
        device,file=fn+'.ps',color=color,encap=0,land=land,port=port, $
          /inch,xsize=xsize,ysize=ysize,xoffset=xoffset,yoffset=yoffset, $
          decomposed=((n_elements(color) eq 0) || (color lt 0))
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      'TEK' : begin
        set_plot,'TEK'
        device,/tek4100,file=fn+'.tek',/tty
      end
      'X' : begin
        set_plot,'X'
        device,decomposed=((n_elements(color) eq 0) || (color lt 0))
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end

      'Z' : begin
        set_plot,'Z'
        device,set_resolution=[xsize,ysize], $
          decomposed=((n_elements(color) eq 0) || (color lt 0))
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      else  : begin
        message,/cont,'Type must be TEK, PS, EPS, or CPS - Respecify'
        return
      end
    endcase
  endif  else  begin

   ; *****set plot to device type wanted
    case  strupcase(type)  of
      'CPS' : begin
        set_plot,'PS'
        device,file=fn+'.cps',/color,encap=0,land=land,port=port, $
          /inch,xsize=xsize,ysize=ysize,xoffset=xoffset,yoffset=yoffset
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      'EPS' : begin
        set_plot,'PS'
        device,file=fn+'.eps',color=color,encap=1,land=land,port=port, $
          /inch,xsize=xsize,ysize=ysize,xoffset=xoffset,yoffset=yoffset
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      'PS'  : begin
        set_plot,'PS'
        device,file=fn+'.ps',color=color,encap=0,land=land,port=port, $
          /inch,xsize=xsize,ysize=ysize,xoffset=xoffset,yoffset=yoffset
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      'TEK' : begin
        set_plot,'TEK'
        device,/tek4100,file=fn+'.tek',/tty
      end
      'X' : begin
        set_plot,'X'
        device,decomposed=((n_elements(color) eq 0) || (color lt 0))
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      'Z' : begin
        set_plot,'Z'
        device,set_resolution=[xsize,ysize], $
          decomposed=((n_elements(color) eq 0) || (color lt 0))
        if  ((n_elements(color) gt 0) && (color ge 0)) then  xlct,color
      end
      else  : begin
        message,/cont,'Type must be TEK, PS, EPS, or CPS - Respecify'
        return
      end
    endcase
  endelse
  return
end
