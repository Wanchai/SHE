package game;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import haxe.Timer;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Assets;

/**
 * ...
 * @author Thomas
 */

class Obstacle extends Sprite{
	var obs1:Bitmap;
	var obs2:Bitmap;
	var obs3:Bitmap;
	var tab:Array<Bitmap>;
	var tab2:Array<Int>;

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		tab = [obs1, obs2, obs3];
		tab2 = [1, 2, 3];
		
		setObs();
		
		var timer:Timer = new Timer(2500);
		timer.run = throwObs;
	}
	
	function setObs() {
		for (o in 0...tab.length) {
			tab[o] = new Bitmap(Assets.getBitmapData("img/space-obs" + tab2[o] + ".png"));
			addChild(tab[o]);
			tab[o].x = Constants.WIDTH + 10;
			tab[o].y = Constants.HEIGHT - 160 - Math.random() * 40;
		}	
	}
	
	function throwObs():Void {
		// speed = FPS * SETSPEED = px/s
		// Distance = WIDTH + 60*2
		// Duration =  distance/speed = 1080/480;
		
		//var bar:Int = Math.round(Math.random() * 2);
		
		var rd:Bitmap = tab[Math.round(Math.random() * 2)];
		var foo:Array<Dynamic> = [rd];
		
		Actuate.tween (rd, 2.25, { x: - 110 }, false).ease (Linear.easeNone).onComplete(resetObs, foo);
	}
	
	function resetObs(obs:Bitmap) {
		obs.x = Constants.WIDTH + 10;
		obs.y = Constants.HEIGHT - 150 - Math.random() * 40;
	}
}