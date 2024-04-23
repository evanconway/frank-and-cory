// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function play_sfx(snd_asset, gain=1, pitch=1) {
	audio_stop_sound(snd_asset);
	return audio_play_sound(snd_asset, 0, false, gain, 0, pitch);
}
