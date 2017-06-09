; Set colors for plotting

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

!p.background=white
!p.color     =black
