if(keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || keyboard_check(ord("Z"))){
	global.lives = 3;
	room_goto(Room3);
}