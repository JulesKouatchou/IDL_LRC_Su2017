FUNCTION PLANCK, V, T
@fundamental_constants.inc
     vs = 1.0D2 * v
     return, vs^3 * ((rad_cl * 1.0D5) / $
             (exp(rad_c2 * (vs / t)) - 1.0DO))
END
