if( (!active && (bbox_left - 8 > CAM_X + CAM_W)) || bbox_right + 8 < CAM_X) return;

active = true;
if(xcollided != 0){
	xvel = -xcollided;
}
grounded = place_meeting(x, y + 1, obj_wall);

yvel += grav;

/* Handle sub-pixel movement */
cx += xvel;
cy += yvel;
vxNew = round(cx);
vyNew = round(cy);
cx -= vxNew;
cy -= vyNew;

/* Y axis collision code */
if(!place_meeting(x, y, obj_wall) && place_meeting(x, y + vyNew, obj_wall))
{
	ycollided = yvel;
	while(!place_meeting(x, y + sign(vyNew), obj_wall))
	{
		y += sign(vyNew);
	}
	yvel = 0;
	vyNew = 0;
}
y += vyNew;

/* X axis collision code */
if(!place_meeting(x, y, obj_wall) && place_meeting(x + vxNew, y, obj_wall))
{
	xcollided = xvel;
	while(!place_meeting(x + sign(vxNew), y, obj_wall))
	{
		x += sign(vxNew);
	}
	xvel = 0;
	vxNew = 0;
}
x += vxNew;

walk+=.1;
image_xscale = -1 + 2*(walk % 2 > 1);