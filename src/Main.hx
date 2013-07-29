package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.Font;
import game.Constants;
import game.Level;
import game.SoundPlayer;
import openfl.Assets;

/**
 * ...
 * @author Thomas
 */

 @:font("assets/Alpha Taurus.ttf") class DefaultFont extends Font {}

class Main extends Sprite {
	var inited:Bool;	
	var music:SoundPlayer;
	var lvl:Level;

	/* ENTRY POINT */
	
	function resize(e) {
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() {
		if (inited) return;
		inited = true;

		/** Code **/
		music = new SoundPlayer("audio/music.mp3");
		music.loop();
		
		var splash = Assets.getMovieClip ("lib:Splash");
		addChild(splash);
		
		var btn = Assets.getMovieClip ("lib:StartBtn");
		btn.x = stage.stageWidth / 2;
		btn.y = stage.stageHeight / 2;
		btn.buttonMode = true;
		btn.stop();
		addChild (btn);
		
		btn.addEventListener(MouseEvent.CLICK, start);		
		btn.addEventListener(MouseEvent.MOUSE_OVER, overHand);		
		btn.addEventListener(MouseEvent.MOUSE_OUT, outHand);
		
		var cred = Assets.getMovieClip ("lib:Credits");
		cred.x = Constants.WIDTH - 60;
		cred.y = Constants.HEIGHT - 20;
		cred.buttonMode = true;
		cred.stop();
		addChild(cred);
		cred.addEventListener(MouseEvent.MOUSE_OVER, overHand);		
		cred.addEventListener(MouseEvent.MOUSE_OUT, outHand);
	}
	
	function outHand(e:MouseEvent):Void {
		e.target.gotoAndStop(1);
	}
	
	function overHand(e:MouseEvent):Void {
		e.target.gotoAndStop(2);
	}
	
	function start(e:MouseEvent):Void {
		lvl = new Level("space");
		addChild(lvl);
		lvl.addEventListener("endLevel", endLevelHand);
		
		this.scaleX = this.scaleY = Constants.RATIO;
	}
	
	private function endLevelHand(e:Event):Void {
		removeChild(lvl);
		lvl.removeEventListener("endLevel", endLevelHand);
		lvl.clearMe();
		lvl = null;
		var end = Assets.getMovieClip ("lib:End");
		addChild(end);
	}

	/* SETUP */
	public function new() {
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) {
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() {
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		//Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
