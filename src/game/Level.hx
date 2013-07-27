package game ;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import game.Character;
import game.Set;
import haxe.Timer;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Assets;

/**
 * ...
 * @author Thomas
 */

class Level extends Sprite {
	
	public var set:Set;
	public var charac:Character;
	public var timer:Timer;
	var ball:Bitmap;
	var levelName:String;
	var speed:Float = 0.5;
	var score:Score;
	var obs:Obstacle;

	public function new(name) {
		super();
		levelName = name;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		/*var starBG:Background = new Background("space-back.png", Constants.BACKSPEED);
		addChild(starBG);
		
		set = new Set(levelName);
		addChild(set);*/
		
		score = new Score();
		addChild(score);
		score.x = Constants.WIDTH / 2 + 100;
		score.y = 80;
		
		charac = new Character(levelName);
		charac.addEventListener(Event.ENTER_FRAME, hitTest);
		addChild(charac);
		
		ball = new Bitmap(Assets.getBitmapData("img/" + levelName + "-ball.png"));
		addChild(ball);	
		ball.x = Constants.WIDTH + 40;
		ball.y = 40;
		
		obs = new Obstacle();
		addChild(obs);
		
		timer = new Timer(1400);
		timer.run = throwBalls;
	}
	

	function hitTest(e:Event):Void {		
		/* --- BALL --- */	
		if (charac.tronc.currentFrame == 1 && charac.hitTestObject(ball)) {
			removeBall();
			inYourFace();
			score.minus();
		}else if (charac.tronc.currentFrame != 1 && charac.tronc.sabre.hitTestObject(ball)) {
			removeBall();
			score.plus();
		}		
		/* --- OBSTACLE --- */
		if (charac.hitTestObject(obs) && !charac.shadow.hitTestObject(obs)) {
			inYourFace();
			score.minus();
		}
	}
	function inYourFace() {
		if (!charac.isHit) {
			Actuate.tween (charac, 0.1, { alpha: 0.4 } ).ease (Linear.easeNone).repeat (9).reflect ().onComplete(resetTween);
		}
		charac.isHit = true;
	}
	
	function resetTween() {
		charac.isHit = false;
	}
	
	function throwBalls():Void {
		if (Math.round(Math.random() * 2) == 1) {					
			Actuate.tween (ball, 1.3, { x: -40 , y:Math.random() * 400 + 250 }, false).ease (Linear.easeNone).onComplete(removeBall);
		}
	}
	
	function removeBall() {	
		Actuate.stop (ball);
		ball.x = Constants.WIDTH + 40;
		ball.y = 40;
	}

}