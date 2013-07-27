package game;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import motion.Actuate;
import motion.easing.Quad;
import space.Legs;
import space.Shadow;
import space.Tronc;

/**
 * ...
 * @author Thomas
 */
class Character extends Sprite {
	
	var levelName:String ;
	var shadowW:Float;
	var i:Float = 0.5;
	var j:Float = 0.5;
	var jumping:Bool = false;
	public var isHit:Bool = false;
	public var legs:MovieClip;
	public var tronc:MovieClip;
	public var body:MovieClip;
	public var shadow:MovieClip;

	public function new(name:String) {
		super();
		levelName = name;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, controlsHand);
		
		legs = new Legs();
		tronc = new Tronc();
		shadow = new Shadow();
		
		body.x = Constants.WIDTH * 25 / 100;
		body.y = Constants.HEIGHT * 80 / 100;
		
		tronc.x = legs.x +13;
		tronc.y = legs.y - 90;
		
		shadow.x = legs.x + 10 ;
		shadow.y = legs.y;
		shadowW = shadow.width;
		
		tronc.stop();		
		tronc.addEventListener(Event.ENTER_FRAME, anim);
		
		addChild(shadow);
		body.addChild(legs);
		body.addChild(tronc);
		addChild(body);
	}
	
	private function controlsHand(e:KeyboardEvent):Void { 		// keyCode 32 = space // keyCode 86 = v
		if (e.keyCode == 86) wack();
		if (e.keyCode == 32) jump();
	}
	
	public function wack() {
		tronc.gotoAndPlay(1);
	}
	
	public function jump() {
		if (!jumping) {
			jumping = true;
			Actuate.tween (body, 0.3, { y: tronc.y - 200 }, false).ease (Quad.easeOut).repeat (1).reflect ();
			//Actuate.tween (legs, 0.3, { y: legs.y - 200 }, false).ease (Quad.easeOut).repeat (1).reflect ();
			Actuate.tween (shadow, 0.32, { width: shadowW/2, height: shadow.height/2}, false).ease (Quad.easeOut).onComplete (jumpComplete).repeat (1).reflect ();
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