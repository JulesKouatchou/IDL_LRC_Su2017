pro xlct,type
;+
;       my personal color table producer. just 2. original tables
;        produced with Eroc Nash's xlct
;-

COMMON COLORS, R_orig, G_orig, B_orig, R_curr, G_curr, B_curr

if(n_elements(type) eq 0) then type = 'norm'
;print,type
case type of
 'norm': begin
  R_curr = [ 0,105,211,175,0,0,0,0,0,142,255,255,160,255,255,255 $
    ,0,50,100,70,110,170,140,190,210,200,220,240,230,245,253,250 ]
  G_curr = [ 0,0,0,0,0,192,255,105,255,142,255,175,0,0,156,255,0 $
    ,50,100,70,110,170,140,190,210,200,220,240,230,245,253,250 ]
  B_curr = [ 0,105,211,255,175,255,192,0,0,0,0,0,0,0,151,255,0,50 $
    ,100,70,110,170,140,190,210,200,220,240,230,245,253,250 ]
  tvlct,R_curr, G_curr, B_curr
  return
  end
 'print': begin
  R_curr = [ 0,85,128,0,0,0,0,0,85,170,255,255,255,255,255,255,0 $
   ,50,100,70,110,170,140,190,210,200,220,240,230,245,253,250 ]
  G_curr = [ 0,0,0,0,128,255,255,255,255,255,255,170,85,0,128,255 $
   ,0,50,100,70,110,170,140,190,210,200,220,240,230,245,253,250 ]
  B_curr = [ 0,85,255,255,255,255,128,0,0,0,0,0,0,0,128,255,0,50 $
   ,100,70,110,170,140,190,210,200,220,240,230,245,253,250 ]
  tvlct,R_curr, G_curr, B_curr
  return
  end
 else: begin
   print,'You only have 2 choices here'
   return
   end
 endcase
end
