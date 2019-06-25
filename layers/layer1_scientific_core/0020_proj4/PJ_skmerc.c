#Fixme : PJ_skewrc.c in version 4.8 to port in 6.1 under projections/skewrc.cpp
#define PROJ_PARMS__ \
	double	sinrot, cosrot;
#define PJ_LIB__
#include	<projects.h>
PROJ_HEAD(skmerc, "Skew Mercator") "\n\tCyl, Sph&Ell\n\tlat_ts= gamma=";
#define EPS10 1.e-10
FORWARD(e_forward); /* ellipsoid */
	double u, v;
	if (fabs(fabs(lp.phi) - HALFPI) <= EPS10) F_ERROR;
	u = P->k0 * lp.lam;
	v = - P->k0 * log(pj_tsfn(lp.phi, sin(lp.phi), P->e));
	xy.x = u * P->cosrot - v * P->sinrot;
	xy.y = v * P->cosrot + u * P->sinrot;
	return (xy);
}
FORWARD(s_forward); /* spheroid */
	double u, v;
	if (fabs(fabs(lp.phi) - HALFPI) <= EPS10) F_ERROR;
	u = P->k0 * lp.lam;
	v = P->k0 * log(tan(FORTPI + .5 * lp.phi));
	xy.x = u * P->cosrot - v * P->sinrot;
	xy.y = v * P->cosrot + u * P->sinrot;
	return (xy);
}
INVERSE(e_inverse); /* ellipsoid */
	double u, v;
	u = xy.x * P->cosrot + xy.y * P->sinrot;
	v = xy.y * P->cosrot - xy.x * P->sinrot;
	if ((lp.phi = pj_phi2(P->ctx, exp(- v / P->k0), P->e)) == HUGE_VAL) I_ERROR;
	lp.lam = u / P->k0;
	return (lp);
}
INVERSE(s_inverse); /* spheroid */
	double u, v;
	u = xy.x * P->cosrot + xy.y * P->sinrot;
	v = xy.y * P->cosrot - xy.x * P->sinrot;
	lp.phi = HALFPI - 2. * atan(exp(-v / P->k0));
	lp.lam = u / P->k0;
	return (lp);
}
FREEUP; if (P) pj_dalloc(P); }
ENTRY0(skmerc)
	double phits=0.0, gamma=0.0;
	int is_phits, gam;

	if( (is_phits = pj_param(P->ctx, P->params, "tlat_ts").i) ) {
		phits = fabs(pj_param(P->ctx, P->params, "rlat_ts").f);
		if (phits >= HALFPI) E_ERROR(-24);
	}
	if ((gam = pj_param(P->ctx, P->params, "tgamma").i) != 0)
		gamma = pj_param(P->ctx, P->params, "rgamma").f;

	P->sinrot = sin(gamma);
	P->cosrot = cos(gamma);

	if (P->es) { /* ellipsoid */
		if (is_phits)
			P->k0 = pj_msfn(sin(phits), cos(phits), P->es);
		P->inv = e_inverse;
		P->fwd = e_forward;
	} else { /* sphere */
		if (is_phits)
			P->k0 = cos(phits);
		P->inv = s_inverse;
		P->fwd = s_forward;
	}
ENDENTRY(P)
