/* Player controller inputs */
ctrl_left_check = keyboard_check(ord("A")) || keyboard_check(vk_left);
ctrl_right_check = keyboard_check(ord("D")) || keyboard_check(vk_right);

ctrl_left_pressed = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left);
ctrl_right_pressed = keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right);

ctrl_jump_check = keyboard_check(vk_space) || keyboard_check(ord("Z"));
ctrl_jump_press = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("Z"));

ctrl_xaxis_check = ctrl_right_check - ctrl_left_check;
ctrl_xaxis_pressed = ctrl_right_pressed - ctrl_left_pressed;

grounded = place_meeting(x, y + 1, obj_wall);
if(state != mariostates.dead && (place_meeting(x, y, obj_goomba) || obj_game.time <= 0)){
	state = mariostates.dead;
	state_timeup = 0;
}

switch(state){
	case mariostates.normal:
		flags.collision = true;
		//Time since last wheeled
		state_var_1 = max(0, state_var_1 - 1);
		if(ctrl_xaxis_pressed != 0 && grounded){
			if(wheelchair_timer == 0){
				state = mariostates.wheeling_startup;
				state_var_0 = sign(ctrl_xaxis_check);
				state_timeup = 0;
			}
		}
		if(ctrl_xaxis_check == 0){
			xvel = xvel * .90;
		} else {
			xvel = xvel * .97;
		}
		if(ctrl_jump_press){
			state = mariostates.jumping_startup;
			state_timeup = 0;
		}
		break;
	case mariostates.wheeling_startup:
		if(!grounded){
			state = mariostates.normal;
			state_timeup = 0;
			state_var_1 = 0;
		} else if(state_timeup < 30){
			state_timeup++;
			if(abs(xvel) < abs(state_var_0)){
				xvel = sign(state_var_0) * min(abs(xvel) + .01, abs(state_var_0));
			}
		} else {
			state = mariostates.normal;
			xvel = state_var_0 * 2;
			state_timeup = 0;
			state_var_1 = 20;
		}
		break;
	case mariostates.jumping_startup:
		if(state_timeup < 20){
			state_timeup++;
		} else {
			state_timeup = 0;
			state = mariostates.normal;
			yvel = -1.5;
			play_sfx(snd_jump_small);
		}
		break;
	case mariostates.dead:
		flags.collision = false;
		
		if(state_timeup == 0){
			audio_stop_sound(snd_overworld);
			play_sfx(snd_die);
			xvel = 0;	
		}
		
		if(state_timeup < 20){
			state_timeup++;
			flags.grav = false;
			yvel = 0;
			xvel = 0;
		} else if (state_timeup == 20){
			state_timeup++;
			flags.grav = true;
			yvel = -6;
			with(instance_create_depth(x, y, depth+1, obj_wheelchair)){
				yvel = -5;
				xvel = -sign(other.image_xscale) * .35;
			}
		} else if(state_timeup < 180){
			state_timeup++;
		} else {
			global.lives--;
			if(global.lives > 0){
				room_goto(Room3);
			} else {
				room_goto(Room4);
			}
		}
		break;
}

if(flags.grav){
	yvel += grav;
}
yvel = min(5, yvel);

/* Handle sub-pixel movement */
cx += xvel;
cy += yvel;
vxNew = round(cx);
vyNew = round(cy);
cx -= vxNew;
cy -= vyNew;

/* Y axis collision code */
if(flags.collision && !place_meeting(x, y, obj_wall) && place_meeting(x, y + vyNew, obj_wall))
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
if(flags.collision && !place_meeting(x, y, obj_wall) && place_meeting(x + vxNew, y, obj_wall))
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

/* Confine mario to right of camera */
x = max(x, CAM_X);

if(vxNew != 0){
	image_xscale = sign(vxNew);
}
image_index += abs(vxNew);

switch(state){
	case mariostates.normal:
		if(ctrl_xaxis_check != 0){
			sprite_index = spr_mario_roll_2;
		} else {
			sprite_index = spr_mario_idle;
		}
		break;
	case mariostates.wheeling_startup:
		sprite_index = spr_mario_roll_1;
		break;
	case mariostates.jumping_startup:
		sprite_index = spr_mario_jump_1;
		break;
	case mariostates.dead:
		sprite_index = spr_mario_dead;
		break;
}

/* Edge camera forwards */
if(x > CAM_X + CAM_W/4 && vxNew > 0){
	camera_set_view_pos(view_camera[0], CAM_X + vxNew / 2, CAM_Y);
}

if(x > CAM_X + CAM_W/2){
	camera_set_view_pos(view_camera[0], x - CAM_W/2, CAM_Y);
}