package ;

import flash.display.Sprite;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.Lib;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import game.Constants;
import game.Level;
import openfl.Assets;
import openfl.display.FPS;

/**
 * ...
 * @author Thomas
 */

 @:font("assets/Alpha Taurus.ttf") class DefaultFont extends Font {}

class Main extends Sprite {
	var inited:Bool;
	

	/* ENTRY POINT */
	
	function resize(e) {
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() {
		if (inited) return;
		inited = true;

		/** Code **/
		
		/*var format:TextFormat = new TextFormat("Alpha Taurus", 70, 0xFFFFFF);
		var textField:TextField = new TextField ();
		
		textField.defaultTextFormat = format;
		textField.embedFonts = true;
		textField.selectable = false;
		
		textField.x = 220;
		textField.y = 200;
		textField.width = 500;
		
		textField.text = "WELCOME TO SHE";	
		addChild (textField);*/
		
		var btn = Assets.getMovieClip ("lib:StartBtn");
		btn.x = stage.stageWidth / 2;
		btn.y = stage.stageHeight / 2;
		btn.buttonMode = true;
		addChild (btn);
		
		btn.addEventListener(MouseEvent.CLICK, start);		
	}
	
	private function start(e:MouseEvent):Void {	
		removeChild(btn);
		var lvl:Level = new Level("space");
		addChild(lvl);
		
		this.scaleX = this.scaleY = Constants.RATIO;
		
		addChild(new FPS());
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
