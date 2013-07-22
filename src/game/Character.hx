package game;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import motion.Actuate;
import motion.easing.Quad;
import motion.MotionPath;
import space.Legs;
import space.Tronc;
import space.Shadow;

/**
 * ...
 * @author Thomas
 */
class Character extends Sprite {
	
	private var levelName:String ;
	private var legs:MovieClip;
	private var tronc:MovieClip;
	private var shadow:MovieClip;
	private var shadowW:Float;
	private var i:Float = 0.5;
	private var j:Float = 0.5;
	private var jumping:Bool = false;

	public function new(name:String) {
		super();
		levelName = name;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, controlsHand);
		
		//var swf:SWF = new SWF (Assets.getBytes ("assets/lib.swf"));
		//tronc = swf.createMovieClip ("space.Tronc");
		//tronc =Assets.getMovieClip("lib:" + levelName + ".Tronc");
		
		legs = new Legs();
		tronc = new Tronc();
		shadow = new Shadow();
		
		legs.x = Constants.WIDTH * 25 / 100;
		legs.y = Constants.HEIGHT * 80 / 100;
		
		tronc.x = legs.x +13;
		tronc.y = legs.y - 90;		
		
		shadow.x = legs.x + 10 ;
		shadow.y = legs.y;
		shadowW = shadow.width;
		
		tronc.stop();		
		tronc.addEventListener(Event.ENTER_FRAME, anim);
		
		addChild(shadow);
		addChild(legs);
		addChild(tronc);
	}
	
	private function controlsHand(e:KeyboardEvent):Void { 		// keyCode 32 = space // keyCode 86 = v
		if (e.keyCode == 32) wack();
		if (e.keyCode == 86) jump();
	}
	
	public function wack() {
		tronc.play();
	}
	
	public function jump() {		
		if (!jumping) {
			jumping = true;
			Actuate.tween (tronc, 0.4, { y: tronc.y - 100 }, false).ease (Quad.easeOut).repeat (1).reflect ();
			Actuate.tween (legs, 0.4, { y: legs.y - 100 }, false).ease (Quad.easeOut).repeat (1).reflect ();
			Actuate.tween (shadow, 0.45, { width: shadowW/2, height: shadow.height/2}, false).ease (Quad.easeOut).onComplete (jumpComplete).repeat (1).reflect ();
		}
	}
	
	function jumpComplete() {
		jumping = false;
		tronc.x = legs.x +13;
		tronc.y = legs.y - 90;	
	}
	
	private function anim(e:Event):Void {
		tronc.y += i ;
		i = i + j;
		if (i > 1) j = -0.5;
		else if (i < -1) j = 0.5;
		
		if (tronc.currentFrame == 12) tronc.gotoAndStop(1);		
	}
	
}