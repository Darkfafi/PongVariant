package  
{
	import events.EndGameEvent;
	import flash.display.DisplayObject;
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
		public static const GAME_SET : String = "gameSet";
		
		private var timesToWin : int;
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
		
		
		public function UI(_timesToWin : int) 
		{
			timesToWin = _timesToWin;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			placeTextUI();
			
		}
		
		private function placeTextUI():void 
		{
			var hudScoreP1 : GameScoreHudArt = new GameScoreHudArt();
			var hudScoreP2 : GameScoreHudArt = new GameScoreHudArt();
			
			var format : TextFormat = new TextFormat(null, 20, 0xFFFFFF);
			
			p1WinText.defaultTextFormat = format;
			p1ScoreText.defaultTextFormat = format;
			p2WinText.defaultTextFormat = format;
			p2ScoreText.defaultTextFormat = format;
			
			p1ScoreText.width = 200;
			p1WinText.width = 200;
			p2ScoreText.width = 200;
			p2WinText.width = 200;
			
			p1WinText.text = "P1 Rounds Won : 0";
			p2WinText.text = "P2 Rounds Won : 0";
			
			p1ScoreText.text = "SCORE : 0";
			p2ScoreText.text = "SCORE : 0";
			
			p1WinText.x = 110;
			p2WinText.x = stage.stageWidth - 280;
			
			p1WinText.y = 50;
			p2WinText.y = 50;
			
			p1ScoreText.x = p1WinText.x;
			p2ScoreText.x = p2WinText.x;
			
			p1ScoreText.y = p1WinText.y + 25;
			p2ScoreText.y = p2WinText.y + 25;
			
			hudScoreP1.x = p1WinText.x - 10;
			hudScoreP1.y = p1WinText.y - 10;
			
			hudScoreP2.scaleX = -1;
			hudScoreP2.x = p2WinText.x + hudScoreP2.width / 1.3;
			hudScoreP2.y = p2WinText.y - 10;
			
			hudScoreP1.alpha = 0.87;
			hudScoreP2.alpha = 0.87;
			
			addChild(hudScoreP1);
			addChild(hudScoreP2);
			
			addChild(p1WinText);
			addChild(p1ScoreText);
			addChild(p2WinText);
			addChild(p2ScoreText);
			
			var l : int = this.numChildren;
			var child : TextField;
			for (var i : int = 0; i < l; i++) {
				if (getChildAt(i) is TextField) {
					child = getChildAt(i) as TextField;
					child.selectable = false;
				}
			}
		}
		
		public function addScore(player : int) :void{
			if (player == 1) {
				p1Score += 1;
				if (p1Score >= 5) {
					p1Wins += 1;
					p1Score = 0;
				}
				p1ScoreText.text = "SCORE : " + p1Score;
				p1WinText.text = "P1 Rounds Won : " + p1Wins;
			}
			else if (player == 2) {
				p2Score += 1;
				if (p2Score >= 5) {
					p2Wins += 1;
					p2Score = 0;
				}
				p2ScoreText.text = "SCORE : " + p2Score;
				p2WinText.text = "P2 Rounds Won : " + p2Wins;
			}else {
				Error("Score given to non valid player!");
			}
			if (p1Wins >= timesToWin || p2Wins >= timesToWin) {
				var e : EndGameEvent;
				if (p1Wins >= timesToWin) {
					 e = new EndGameEvent(GAME_SET, 1, true);
				}else {
					e = new EndGameEvent(GAME_SET, 2, true);
				}
				dispatchEvent(e);
			}
		}
	}

}