pro latexify_example


;rpsopen, 'latexify.eps',  xs=9, ys=6, /inches, /encap
x=mkarr(-5, 5, .1)
plot, x, x^3, xtitle='xt', ytitle='yt', title='t',charsize=3, font=0
rpsclose
latexify, 'latexify.eps', ['xt', 't', 'yt'], ['$\log \frac{M}{M_\odot}$',$
      '$\int_0^{\infty} \left(\frac{x^5 exp{\left(x^2/\sigma \right)^{4.5}}}'+$
      '{\sin \theta}\right)dx \ [M_\odot]$', '$R_\odot M_\oplus^3 $'], /full
		;the /full keyword should only be set if latexify is
		;outputting to a full page

end

