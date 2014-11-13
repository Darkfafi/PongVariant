package screens 
{
	import events.StartGameEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import media.SoundManager;
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
		private var onePButton : Sprite = new Sprite();
		private var twoPButton : Sprite = new Sprite();
		
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
			var background : MovieClip = new MenuBG();
			addChild(background);
			SoundManager.playSound(SoundManager.MENU_BG_MUSIC);
			
			arrowUp = new ArrowButton();
			
			arrowDown = new ArrowButton();
			arrowDown.scaleY = -1;
			
			onePButton = new OnePlayerButton();

			twoPButton = new TwoPlayerButton();
			
			showWinTimeSet.x = stage.stageWidth / 2.4;
			showWinTimeSet.y = stage.stageHeight / 2;
			
			arrowDown.x = showWinTimeSet.x - 35;
			arrowDown.y = showWinTimeSet.y + arrowDown.height;
			
			arrowUp.x = showWinTimeSet.x + showWinTimeSet.width + 65;
			arrowUp.y = showWinTimeSet.y;
			
			onePButton.x = showWinTimeSet.x - 20;
			onePButton.y = showWinTimeSet.y + 75;
			
			twoPButton.x = onePButton.x;
			twoPButton.y = onePButton.y + 100;
			
			showWinTimeSet.defaultTextFormat = new TextFormat(null, 19,0xFFFFFF);
			
			showWinTimeSet.text = "Rounds To Win : " + winTimeSet.toString();
			showWinTimeSet.width = 200;
			showWinTimeSet.selectable = false;
			
			addChild(showWinTimeSet);
			addChild(arrowDown);
			addChild(arrowUp);
			addChild(onePButton);
			addChild(twoPButton);
		}
		
		private function clickEvent(e:MouseEvent):void 
		{
			var event : Event;
			if (e.target == arrowDown) {
				if (winTimeSet > 1) {
					winTimeSet --;
				}
			}else if (e.target == arrowUp) {
				if (winTimeSet < 99) {
					winTimeSet ++;
				}
			}else if (e.target == onePButton) {
				event = new StartGameEvent(START_GAME, winTimeSet,true, true);
				dispatchEvent(event);
			}
			else if (e.target == twoPButton) {
				event = new StartGameEvent(START_GAME, winTimeSet,false, true);
				dispatchEvent(event);
			}
			showWinTimeSet.text = "Rounds To Win : " + winTimeSet.toString();
		}
		
	}

}