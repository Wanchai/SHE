package game ;

import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import game.Character;
import game.Set;
import openfl.Assets;

/**
 * ...
 * @author Thomas
 */

class Level extends Sprite {
	
	public var set:Set;
	public var charac:Character;
	private var bg1:Bitmap;
	private var bg2:Bitmap;
	private var bg3:Bitmap;
	private var levelName:String;
	private var speed:Float = 0.5;

	public function new(name) {
		super();
		levelName = name;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		bg1 = new Bitmap(Assets.getBitmapData("img/" + levelName + "-back.png"));
		bg2 = new Bitmap(Assets.getBitmapData("img/" + levelName + "-back.png"));
		bg3 = new Bitmap(Assets.getBitmapData("img/" + levelName + "-back.png"));
		
		bg1.x = 0;
		bg2.x = bg1.width;
		bg3.x = bg1.width*2;
		
		bg1.name = 'bg1';
		bg2.name = 'bg2';
		bg3.name = 'bg3';
		
		addChild(bg1);
		addChild(bg2);
		addChild(bg3);
		
		bg1.addEventListener(Event.ENTER_FRAME, setMove);
		bg2.addEventListener(Event.ENTER_FRAME, setMove);
		bg3.addEventListener(Event.ENTER_FRAME, setMove);
		
		set = new Set(levelName);
		addChild(set);
		
		charac = new Character(levelName);
		addChild(charac);
	}
	
	private function setMove(e:Event):Void {
		//trace(set1.width);
				
		if (e.target.x < -e.target.width ) {
			
			if (e.target.name == 'bg1') {
				e.target.x =  bg3.x + bg3.width - speed;
			}else if (e.target.name == 'bg2') {
				e.target.x = bg1.x + bg3.width;
			}else {
				e.target.x = bg2.x + bg3.width;
			}
			
		}else {
			e.target.x -= speed;
		}
	}
	
}