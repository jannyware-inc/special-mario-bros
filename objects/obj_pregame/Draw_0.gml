draw_set_font(fnt_mario);
draw_text(CAM_X + 24, CAM_Y + 16, "MARIO");
draw_text(CAM_X + 24, CAM_Y + 24, "000000");

coin_image_index+=.1;
draw_sprite(spr_coinicon, coin_image_index, CAM_X + 24 + 64, CAM_Y + 24);
draw_text(CAM_X + 24 + 64 + 8, CAM_Y + 24, "x00");

draw_text(CAM_X + 128 + 16, CAM_Y + 16, "WORLD");
draw_text(CAM_X + 128 + 24, CAM_Y + 24, "1-1");

draw_text(CAM_X + 128 + 16 + 56, CAM_Y + 16, "TIME");

draw_text(CAM_X + 24 + 64, CAM_Y + 80, "WORLD 1-1");
draw_sprite(spr_mario_idle, 0, CAM_X + 24 + 64 + 8 + 8, CAM_Y + 128);
draw_text(CAM_X + 24 + 64 + 24 + 8, CAM_Y + 128 - 8, "x  " + string(global.lives));