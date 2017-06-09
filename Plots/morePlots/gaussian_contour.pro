;http://icc.dur.ac.uk/~tt/IDL/plots.pro

PRO gaussian_contour

   ; Did that work for you? If not, you may have to tell idl what screen
   ; you are using. I needed to say
   ; cat $(HOME)/.idl_startup
   if(!version.os_family eq 'unix') then device, true_color=24
   window, /free, /pixmap, colors=-10
   wdelete, !d.window
   device, retain=2, decomposed=0, set_character_size=[10,12]
   device, get_visual_depth=depth
   print, 'Display depth: ',depth
   print, 'Colour table size: ',!d.table_size
   loadct,39,/silent
   scale  = float(!d.table_size)/256.
   black  = fix(   0.*scale)
   blue   = fix( 70. *scale)
   cyan   = fix( 100.*scale)
   green  = fix( 140.*scale)
   yellow = fix( 190.*scale)
   orange = fix( 210.*scale)
   red    = fix( 250.*scale)
   white  = fix( 255.*scale)
   
   npts = 256 ; number of pts
   nsig = 4.  ; number of sigma
   x    = -nsig + findgen(npts)/float(npts)*2*nsig
   Gs   = fltarr(npts,npts)
   for j=0,npts-1 do begin $
     & for i=0,npts-1 do begin $
     & Gs[i,j] = exp(-(x[i]^2+x[j]^2)/2.) $
     & endfor $
  & endfor

   contour,Gs,x,x,nlev=255,/iso,/fill
   
   ; now try
   ;oadct,11
   ;ontour,Gs,x,x,nlev=255,/iso,/fill
   
   ; or 
   ;xloadct

END
