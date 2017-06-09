pro write_postscript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Example demonstrates the following:
;;   1. Create a two dimensional array with some data
;;   2. Create a postscript file
;;   3. Place an image of the data into the postscript file
;;   4. Plot contours over the image
;;   5. Add a scalebar.
;;   6. Clean up.
;;
;;   Usage: makepostscript
;;
;;   Original Version: 06/10/06 Craig Booth.
;;
;;   Modified:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Step 1: Create our dataset in an array called z
;   calling dist(x) returns an x by x array where the data values are
;   proportional to the frequency of that pixel in a fourier
;   transformed image.
z = dist(256)

; Step 2: Create a postscript file
;   start writing to a postscript instead of the screen
set_plot,'ps'

;   set the properties of the postscript. xsize and ysize are in cm;
;   /color allows the postscript to use colour; encapsulated=1 makes an
;   encapsulated postscript, which is better for including inside other
;   postscript files (e.g. as a figure in a paper).  bits_per_pixel can
;   be 1,2,4,8.  Larger numbers give nicer looking pictures (more
;   colours) at the expense of a large filesize
device,/color,xsize=20,ysize=21,encapsulated=1,filename='test.eps',bits_per_pixel=8

; Step 3: We will start by placing some blank axes in the postscript,
;   then drawing the image in the axes, before adding a contour plot to
;   the top

;   Signal to idl that we are going to have two plots on the same page:
!p.multi=[0,3,1]

;   Make the characters a bit larger:
!p.charsize=2.0

;   plot our data array.  tvscl plots any 2d array as an image.  It
;   scales so that the minimum and maximum values of the data are the
;   first and last entries in the colourmap.  The input arguments are
;   the array to plot (z), the lower left coordinates (optional, will
;   assume [0,0] if blank).
tvscl,z,2.0,3.0,xsize=17,ysize=17,/centimeters

; Step 4: Contour plot.
;   place a contour plot over the top of the image. nlev sets the
;   number of contours, noerase makes sure we plot the contours over
;   the existing image, position specifies where we place the axes, the
;   vector contains [xmin,ymin,xmax,ymax].  We are working in device
;   coordinates, which are cm*1000. /xs and /ys force that the scale we
;   specified fills the entire screen.  /follow places numbers on some
;   of the contours.
xx = (findgen(256)/255) * 255-128
contour,z,xx,xx,nlev=10,/noerase, $
        position=[2.0,3,19,20]*1000.0 $
        ,/device,/xs,/ys,xtitle='X',ytitle='Y',/follow


; Step 5: The scalebar.
;   in IDL scalebars are just contour plots that have been carefully
;   scaled.  Make an array to tvscl:
aa = [[findgen(255)],[findgen(255)]]

;   Now place it in a small plot at the bottom of the page.  Start by
;   drawing some empty axes.  ycharsize is the size of the y label.  We
;   wish to hide this but IDL will crash if ycharsize is set to
;   zero. 1d-10 is small enough to be invisible. /nodata makes idl draw
;   empty axes.
plot,[0],[0],/nodata,/noerase,position=[2.0,1.3,19.0,1.8]*1000.0,/device,ycharsize=1d-10,yticklen=1d-10,xticklen=1d-10,xtitle='This is a scalebar',xr=[min(z),max(z)],/xs

;   now put an image in the empty axes
tvscl,aa,2.0,1.3,xsize=17,ysize=0.5,/centimeters


; Step 6: Clean up.  Close the postscript
device,/close

;   set idl back to one plot per page
!p.multi=0

;   set idl to draw to the screen
set_plot,'x'

end
