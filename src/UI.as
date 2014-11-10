package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class UI extends Sprite
	{	
		//player 1
		private var p1Wins : int = 0;
		private var p1Score : int = 0;
		private var p1WinText : TextField = new TextField();
		private var p1ScoreText : TextField = new TextField();
		
		
		//player 2
		private var p2Wins : int = 0;
		private var p2Score : int = 0;
		private var p2WinText : TextField = new TextField();
		private var p2ScoreText : TextField = new TextField();
		
		
		public function UI() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			placeTextUI();
			
		}
		
		private function placeTextUI():void 
		{
			var format : TextFormat = new TextFormat(null, 20, 0xFFFFFF);
			
			p1WinText.defaultTextFormat = format;
			p1ScoreText.defaultTextFormat = format;
			p2WinText.defaultTextFormat = format;
			p2ScoreText.defaultTextFormat = format;
			
			p1ScoreText.width = 200;
			p1WinText.width = 200;
			p2ScoreText.width = 200;
			p2WinText.width = 200;
			
			p1WinText.text = "P1 WINS : 00";
			p2WinText.text = "P2 WINS : 00";
			
			p1ScoreText.text = "SCORE : 00";
			p2ScoreText.text = "SCORE : 00";
			
			p1WinText.x = stage.stageWidth / 3;
			p2WinText.x = stage.stageWidth / 1.9;
			
			p1ScoreText.x = p1WinText.x;
			p2ScoreText.x = p2WinText.x;
			
			p1ScoreText.y = 25;
			p2ScoreText.y = 25;
			
			addChild(p1WinText);
			addChild(p1ScoreText);
			addChild(p2WinText);
			addChild(p2ScoreText);
		}
		
	}

}