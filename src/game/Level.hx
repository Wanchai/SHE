package game ;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import game.Character;
import game.Set;
import game.SoundPlayer;
import haxe.Timer;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Assets;
import space.Ball;

/**
 * ...
 * @author Thomas
 */

class Level extends Sprite {
	
	public var charac:Character;
	public var timer:Timer;
	var ball:Ball;
	var levelName:String;
	var speed:Float = 0.5;
	var score:Score;
	var movingObs:Obstacle;
	var obsTab:Array<Obstacle>;
	var clapSound:SoundPlayer;
	var lolSound:SoundPlayer;

	public function new(name) {
		super();
		levelName = name;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		clapSound = new SoundPlayer("audio/clap.mp3");
		lolSound = new SoundPlayer("audio/lol.mp3");
		
		var starBG:Background = new Background("space-back.png", Constants.BACKSPEED);
		addChild(starBG);
		
		var set:Set = new Set(levelName);
		addChild(set);
		
		score = new Score();
		addChild(score);
		score.x = Constants.WIDTH -200;
		score.y = 80;
		
		setObstacles();
		
		charac = new Character(levelName);
		charac.addEventListener(Event.ENTER_FRAME, hitTest);
		addChild(charac);
		charac.x = Constants.WIDTH * 25 / 100;
		charac.y = Constants.HEIGHT * 80 / 100;
		
		ball = new Ball();
		addChild(ball);	
		ball.x = Constants.WIDTH + 40;
		ball.y = 40;
		
		timer = new Timer(1400);
		timer.run = throwBalls;
	}
	
	function hitTest(e:Event):Void {		
		/* --- BALL --- */	
		if (charac.tronc.currentFrame != 1 && charac.tronc.sabre.hitTestObject(ball)) {
			resetBall();
			score.plus();
			if (score.scoreNum >= 150) dispatchEvent(new Event("endLevel"));
			clapSound.play();
		}else if (charac.tronc.currentFrame == 1 && charac.tronc.hitTestObject(ball) && charac.legs.hitTestObject(ball)) {
			resetBall();
			inYourFace();
		}		
		/* --- OBSTACLE --- */
		if (charac.body.hitTestPoint(movingObs.x * Constants.RATIO, movingObs.y * Constants.RATIO, true)){
			if (!charac.isHit) inYourFace();
			charac.isHit = true;
		}
	}
	
	function inYourFace() {
		Actuate.tween (charac, 0.1, { alpha: 0.4 } ).ease (Linear.easeNone).repeat (9).reflect ().onComplete(resetTween);
		score.minus();
		lolSound.play();
	}
	
	function resetTween() {
		charac.isHit = false;
		charac.alpha = 1;
	}
	
	function setObstacles() {
		obsTab = [];
		var i = 1;
		while (i < 4) {
			var obs = new Obstacle(i);
			addChild(obs);
			obs.x = Constants.WIDTH + 70;
			obs.y = Constants.HEIGHT - 120 - Math.random() * 40;
			obsTab.push(obs);
			i++;	
		}		
		movingObs = obsTab[1];
		var timer:Timer = new Timer(2500);
		timer.run = throwObs;
	}
	
	function throwObs():Void {
		// speed = FPS * SETSPEED = px/s
		// Distance = WIDTH + 60*2
		// Duration =  distance/speed = 1080/480;
		
		movingObs = obsTab[Math.round(Math.random() * 2)];		
		Actuate.tween (movingObs, 2.25, { x: - 50 }, false).ease (Linear.easeNone).onComplete(resetObs);
	}
	
	function resetObs() {
		movingObs.x = Constants.WIDTH + 70;
		movingObs.y = Constants.HEIGHT - 150 - Math.random() * 40;
	}	
	
	function throwBalls():Void {
		if (Math.round(Math.random() * 2) == 1) {					
			Actuate.tween (ball, 1.3, { x: -40 , y:Math.random() * 400 + 250, rotation: 340 }, true).ease (Linear.easeNone).onComplete(resetBall);
		}
	}
	
	function resetBall() {
		Actuate.stop (ball);
		ball.x = Constants.WIDTH + 40;
		ball.y = 40;
		ball.rotation = 0;
	}
	
	public function clearMe() {
		Actuate.pauseAll ();
		charac.clearMe();
		removeChildren();
	}
}