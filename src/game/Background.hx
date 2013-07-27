package game;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import openfl.Assets;

/**
 * ...
 * @author Thomas
 */
class Background extends Sprite {
	
	private var bg1:Bitmap;
	private var bg2:Bitmap;
	private var bg3:Bitmap;
	private var img:String;
	private var speed:Float;

	public function new(image:String, sp:Float) {
		super();
		img = image;
		speed = sp;
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		bg1 = new Bitmap(Assets.getBitmapData("img/" + img));
		bg2 = new Bitmap(Assets.getBitmapData("img/" + img));
		bg3 = new Bitmap(Assets.getBitmapData("img/" + img));
		
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
		
	}
		
	function setMove(e:Event):Void {
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