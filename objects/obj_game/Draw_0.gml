draw_set_font(fnt_mario);
draw_text(CAM_X + 24, CAM_Y + 16, "MARIO");
draw_text(CAM_X + 24, CAM_Y + 24, "000000");

coin_image_index+=.1;
draw_sprite(spr_coinicon, coin_image_index, CAM_X + 24 + 64, CAM_Y + 24);
draw_text(CAM_X + 24 + 64 + 8, CAM_Y + 24, "x00");

draw_text(CAM_X + 128 + 16, CAM_Y + 16, "WORLD");
draw_text(CAM_X + 128 + 24, CAM_Y + 24, "1-1");

draw_text(CAM_X + 128 + 16 + 56, CAM_Y + 16, "TIME");
draw_set_halign(fa_right);
draw_text(CAM_X + 128 + 24 + 56 + 24, CAM_Y + 24, string(round(time)));

if(round(time) < 10){
	draw_text(CAM_X + 128 + 24 + 56 + 24, CAM_Y + 24, string("00 "));
} else if(round(time) < 100){
	draw_text(CAM_X + 128 + 24 + 56 + 24, CAM_Y + 24, string("0  "));
}
draw_set_halign(fa_left);