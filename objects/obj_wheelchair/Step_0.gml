image_xscale = sign(xvel);

yvel += grav;

/* Handle sub-pixel movement */
cx += xvel;
cy += yvel;
vxNew = round(cx);
vyNew = round(cy);
cx -= vxNew;
cy -= vyNew;

y += vyNew;
x += vxNew;