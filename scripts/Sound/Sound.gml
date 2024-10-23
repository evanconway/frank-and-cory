function play_sfx(snd_asset, gain=1, pitch=1, loop=false) {
	audio_stop_sound(snd_asset);
	return audio_play_sound(snd_asset, 0, loop, gain, 0, pitch);
}
