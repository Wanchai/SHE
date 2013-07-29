package game;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author Thomas
 */

class Obstacle extends Sprite{
	var i:Int;

	public function new(num:Int) {
		super();
		i = num;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		var inst:DisplayObject = Type.createInstance(Type.resolveClass('space.Obstacle' + i), []);
		addChild(inst);	
	}
}