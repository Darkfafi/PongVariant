package screens 
{
	import events.StartGameEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Menu extends Screen
	{
		public static const START_GAME : String = "startGame"; 
		
		private var showWinTimeSet : TextField = new TextField();
		private var arrowUp : Sprite = new Sprite();
		private var arrowDown : Sprite = new Sprite();
		private var startButton : Sprite = new Sprite();
		
		private var winTimeSet : int = 1;
		
		public function Menu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			placeMenu();
			stage.addEventListener(MouseEvent.CLICK, clickEvent);
		}
		
		private function placeMenu():void 
		{
			//background placeholder
			graphics.beginFill(0x000000, 1);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			//draw placeholders buttons
			arrowUp.graphics.beginFill(0x00FF00, 1);
			arrowUp.graphics.drawRect(0, 0, 30, 30);
			arrowUp.graphics.endFill();
			
			arrowDown.graphics.beginFill(0xFF0000, 1);
			arrowDown.graphics.drawRect(0, 0, 30, 30);
			arrowDown.graphics.endFill();
			
			startButton.graphics.beginFill(0xFFFFFF, 1);
			startButton.graphics.drawRect(0, 0, 100, 30);
			startButton.graphics.endFill();
			//-------------------------------------------
			
			
			showWinTimeSet.x = stage.stageWidth / 2.2;
			showWinTimeSet.y = stage.stageHeight / 2;
			
			arrowDown.x = showWinTimeSet.x - 45;
			arrowDown.y = showWinTimeSet.y;
			
			arrowUp.x = showWinTimeSet.x + showWinTimeSet.width + 20;
			arrowUp.y = showWinTimeSet.y;
			
			startButton.x = showWinTimeSet.x;
			startButton.y = showWinTimeSet.y + 50;
			
			showWinTimeSet.defaultTextFormat = new TextFormat(null, 15,0xFFFFFF);
			
			showWinTimeSet.text = "Times To Win : " + winTimeSet.toString();
			showWinTimeSet.width = 200;
			showWinTimeSet.selectable = false;
			
			addChild(showWinTimeSet);
			addChild(arrowDown);
			addChild(arrowUp);
			addChild(startButton);
		}
		
		private function clickEvent(e:MouseEvent):void 
		{
			if (e.target == arrowDown) {
				if (winTimeSet > 1) {
					winTimeSet --;
				}
			}else if (e.target == arrowUp) {
				if (winTimeSet < 99) {
					winTimeSet ++;
				}
			}else if (e.target == startButton) {
				var event : Event = new StartGameEvent(START_GAME, winTimeSet, true);
				dispatchEvent(event);
			}
			showWinTimeSet.text = "Times To Win : " + winTimeSet.toString();
		}
		
	}

}