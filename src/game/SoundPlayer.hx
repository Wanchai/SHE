package game;

import flash.events.Event;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;
import openfl.Assets;

/**
 * ...
 * @author Thomas
 */

class SoundPlayer {
	var sc:SoundChannel;
	var sound:Sound;

	public function new(fileName:String) {		
		sound = Assets.getSound(fileName);
		
		sc = sound.play();
		sc.stop();
	}
	
	public function stop() {
		sc.stop();
	}
	
	public function loop() {
		sc = sound.play();
		sc.addEventListener(Event.SOUND_COMPLETE, completeHandler);
	}
	
	public function play() {
		sound.play();
	}
	
	function completeHandler(event:Event):Void {
		sc = sound.play();
		sc.addEventListener(Event.SOUND_COMPLETE, completeHandler);
	}
	
}