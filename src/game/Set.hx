package game ;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import game.Background;

/**
 * ...
 * @author Thomas
 */
class Set extends Sprite {
	
	var levelName:String;
	var set1:Bitmap;
	var set2:Bitmap;
	var set3:Bitmap;
	var speed:Int;
	var setBG:Background;

	public function new(name:String) {
		super();
		levelName = name;
		speed = Constants.SPEED;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		setBG = new Background("space-set.png", Constants.SETSPEED);
		addChild(setBG);
	}
	
}