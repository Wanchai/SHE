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
	var scoreNum:Int = 0;

	public function new() {
		super();
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):Void {
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		graphics.beginFill (0xcccccc);
		graphics.drawRect(0,0, 200, 50);
		alpha = 0.5;
		
		scoreTF = new TextField();
		scoreTF.width = 200;	
		scoreTF.height= 50;	
		
		var format:TextFormat = new TextFormat();
		format.font = "Verdana";
		format.color = 0xFFFFFF;
		format.size = 36;
		format.bold = true;
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