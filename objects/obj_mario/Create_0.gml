xvel = 0;
yvel = 0;

wheelspd = 1.5;

grav = .22;

/* Controller inputs */
ctrl_left_check = 0;
ctrl_right_check = 0;

ctrl_jump_check = 0;
ctrl_jump_press = 0;

ctrl_up_check = 0;
ctrl_down_check = 0;

ctrl_xaxis_check = 0;
ctrl_yaxis_check = 0;

ctrl_xaxis_pressed = 0;

enum mariostates {
	normal,
	wheeling_startup,
	jumping_startup,
	dead,
}

flags = {
	collision: true,
	grav: true,
}
state = mariostates.normal;
wheelchair_timer = 0;
wheelchair_timer_max = 60;

state_timeup = 0;
state_var_0 = 0;
state_var_1 = 0;

cx = 0;
cy = 0;

xcollided = 0;
ycollided = 0;