// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_sfx(snd){
	audio_stop_sound(snd);
	audio_play_sound(snd, 100, false);
}