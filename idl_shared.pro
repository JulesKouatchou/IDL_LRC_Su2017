
; =========================================================================

pro colorbar,n_levels = n_levels, levels = levels, colors = colors, labels = labels,$
             position = position, vertical= vertical, horizontal = horizontal

  IF KEYWORD_SET(vertical) THEN BEGIN
  
     !P.position=[position(2) + 0.02, position(1) ,position(2) + 0.05, position(3)] 
     
     alpha=fltarr(2,n_levels)
     alpha(0,*)=levels
     alpha(1,*)=levels
     h=[-1,1]
     clev = levels
     clev (*) = 1
     k = 0
     
     levelsx = indgen (N_levels)

     contour,alpha,h,levelsx,levels=levels,c_colors=colors,/fill,/xstyle,/ystyle, $
             /noerase,xticks=1, xtickname=[' ',' '] ,yrange=[min(levelsx),max(levelsx)], $
             ytitle=' ', color=0, $
             C_charsize=1.0, charsize=0.5 ,xtickformat = "(A1)",ytickformat = "(A1)"
     contour,alpha,h,levelsx,levels=levels,color=0,/overplot,c_label=clev
     for k = 0,n_elements(levels) -1 do xyouts,1.1, levelsx[k],labels(k) ,color=0,charsize =1.2

  endif else begin

     ;!P.position=position
     !P.position=[position(0) +0.01, position(1)-0.06 ,position(2) - 0.1, position(1)-0.04] 
     ;!P.position=[0.15, 0.01, 0.85, 0.04]  

     alpha=fltarr(n_levels,2)
     alpha(*,0)=levels
     alpha(*,1)=levels
     h=[0,1]
     clev = levels
     clev (*) = 1
     k = 0
     
     levelsx = indgen (N_levels)

     contour,alpha,levelsx,h,levels=levels,c_colors=colors,/fill,/xstyle,/ystyle, $
             /noerase,yticks=1, ytickname=[' ',' '] ,xrange=[min(levelsx),max(levelsx)], $
             xtitle=' ', color=0, $
             C_charsize=1.0, charsize=0.5 ,xtickformat = "(A1)",ytickformat = "(A1)"
     contour,alpha,levelsx,h,levels=levels,color=0,/overplot,c_label=clev
     for k = 0,n_elements(levels) -1 do xyouts, levelsx[k],1.1,string(labels(k),'(f6.2)') ,color=0,charsize =0.7,orientation=90    
     ;for k = 0,n_elements(levels) -1 do xyouts, levelsx[k],1.1,string(labels(k),'(f6.2)') ,color=0,charsize =1.8,orientation=90    

  endelse

     !P.position=0

end


; ==================================================================================
;
pro load_colors

R = intarr (256)
G = intarr (256)
B = intarr (256)

R (*) = 255
G (*) = 255
B (*) = 255

r_drought = [0,   0,   0,   0,  47, 200, 255, 255, 255, 255, 249, 197]
g_drought = [0, 115, 159, 210, 255, 255, 255, 255, 219, 157,   0,   0]
b_drought = [0,   0,   0,   0,  67, 130, 255,   0,   0,   0,   0,   0]

colors = indgen (11) + 1
R (0:11) = r_drought
G (0:11) = g_drought
B (0:11) = b_drought

r_green = [200, 150,  47,  60,   0,   0,   0,   0]
g_green = [255, 255, 255, 230, 219, 187, 159, 131]
b_green = [200, 150,  67,  15,   0,   0,   0,   0]

r_blue  = [ 55,   0,   0,   0,   0,   0,   0,   0,   0,   0]
g_blue  = [255, 255, 227, 195, 167, 115,  83,   0,   0,   0]
b_blue  = [199, 255, 255, 255, 255, 255, 255, 255, 200, 130]

r_red   = [255, 240, 255, 255, 255, 255, 255, 233, 197]
g_red   = [255, 255, 219, 187, 159, 131,  51,  23,   0]
b_red   = [153,  15,   0,   0,   0,   0,   0,   0,   0]

r_grey  = [245, 225, 205, 185, 165, 145, 125, 105,  85]
g_grey  = [245, 225, 205, 185, 165, 145, 125, 105,  85]
b_grey  = [245, 225, 205, 185, 165, 145, 125, 105,  85]

r_type  = [255,106,202,251,  0, 29, 77,109,142,233,255,255,255,127,164,164,217,217,204,104,  0]
g_type  = [245, 91,178,154, 85,115,145,165,185, 23,131,131,191, 39, 53, 53, 72, 72,204,104, 70]
b_type  = [215,154,214,153,  0,  0,  0,  0, 13,  0,  0,200,  0,  4,  3,200,  1,200,204,200,200]

r_lct2  = [  0,   0,   0,   0,   0,   0,   0,   0,   0,  55, 120, 190, 240, 255, 255, 255, 255, 255, 233, 197, 158]
g_lct2  = [  0,   0,   0,  83, 115, 167, 195, 227, 255, 255, 255, 255, 255, 219, 187, 159, 131,  51,  23,   0,   0]
b_lct2  = [130, 200, 255, 255, 255, 255, 255, 255, 255, 199, 135,  67,  15,   0,   0,   0,   0 ,  0,   0,   0,   0]

r_veg  = [233,255,255,255,210,  0,  0,  0,204,170,255,220,205,  0,  0,170,  0, 40,120,140,190,150,255,255,  0,  0,  0,195,255,  0]
g_veg  = [ 23,131,191,255,255,255,155,  0,204,240,255,240,205,100,160,200, 60,100,130,160,150,100,180,235,120,150,220, 20,245, 70]
b_veg  = [  0,  0,  0,178,255,255,255,200,204,240,100,100,102,  0,  0,  0,  0,  0,  0,  0,  0,  0, 50,175, 90,120,130,  0,215,200]

r_grads_rb = [160, 110, 30,   0,   0,   0,   0, 160, 230, 230, 240, 250, 240]
g_grads_rb = [  0,  0,  60, 150, 200, 210, 220, 230, 220, 175, 130,  60,   0] 
b_grads_rb = [200, 220, 255, 255, 200, 140,  0,  50,  50,  45,  40,  60, 130] 

R (20:27) = r_green
G (20:27) = g_green
B (20:27) = b_green

R (30:39) = r_blue
G (30:39) = g_blue
B (30:39) = b_blue

R (40:48) = r_red
G (40:48) = g_red
B (40:48) = b_red

R (50:58) = r_grey
G (50:58) = g_grey
B (50:58) = b_grey

R (60:80) = r_type
G (60:80) = g_type
B (60:80) = b_type

R (90:119) = r_veg
G (90:119) = g_veg
B (90:119) = b_veg

R (120:132) = r_grads_rb
G (120:132) = g_grads_rb
B (120:132) = b_grads_rb

R (140:160) = r_lct2
G (140:160) = g_lct2
B (140:160) = b_lct2

TVLCT,R ,G ,B

end

