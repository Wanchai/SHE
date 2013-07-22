package game ;

import flash.display.Sprite;
import flash.events.Event;
import flash.display.Bitmap;
import openfl.Assets;

/**
 * ...
 * @author Thomas
 */
class Set extends Sprite {
	
	private var levelName:String;
	private var set1:Bitmap;
	private var set2:Bitmap;
	private var set3:Bitmap;
	private var speed:Int = 8;

	public function new(name:String) {
		super();
		levelName = name;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		set1 = new Bitmap(Assets.getBitmapData("img/" + levelName + "-set.png"));
		set2 = new Bitmap(Assets.getBitmapData("img/" + levelName + "-set.png"));
		set3 = new Bitmap(Assets.getBitmapData("img/" + levelName + "-set.png"));
		
		set1.x = 0;
		set2.x = set1.width;
		set3.x = set1.width*2;
		
		set1.name = 'set1';
		set2.name = 'set2';
		set3.name = 'set3';
		
		addChild(set1);
		addChild(set2);
		addChild(set3);
		
		set1.addEventListener(Event.ENTER_FRAME, setMove);
		set2.addEventListener(Event.ENTER_FRAME, setMove);
		set3.addEventListener(Event.ENTER_FRAME, setMove);
	}
	
	private function setMove(e:Event):Void {				
		if (e.target.x < -e.target.width ) {
			
			if (e.target.name == 'set1') {
				e.target.x =  set3.x + set3.width - speed;
			}else if (e.target.name == 'set2') {
				e.target.x = set1.x + set1.width;
			}else {
				e.target.x = set2.x + set2.width;
			}
			
		}else {
			e.target.x -= speed;
		}
	}
	
}