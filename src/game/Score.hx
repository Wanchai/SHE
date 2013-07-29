package game;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

/**
 * ...
 * @author Thomas
 */
class Score extends Sprite {
	
	var scoreTF:TextField;
	public var scoreNum:Int = 0;

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		var frame = new Sprite();
		frame.graphics.beginFill (0xcccccc);
		frame.graphics.drawRect(0,0, 100, 35);
		frame.alpha = 0.5;
		addChild(frame);
		
		scoreTF = new TextField();
		scoreTF.width = 100;
		scoreTF.height= 35;	
		
		var format:TextFormat = new TextFormat();
		format.font = "Alpha Taurus";
		format.color = 0xFFFFFF;
		format.size = 30;
		format.align = TextFormatAlign.RIGHT;
		
		scoreTF.defaultTextFormat = format;
		addChild(scoreTF);
		scoreTF.text = "0";
	}
	
	public function minus() {
		if (scoreNum != 0) {
			scoreNum -= 5;
			scoreTF.text = "" + scoreNum;
		}
	}
	
	public function plus() {
		scoreNum += 10;
		scoreTF.text = "" + scoreNum;
	}
	
}