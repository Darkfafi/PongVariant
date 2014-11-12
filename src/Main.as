package 
{
	import events.StartGameEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import screens.Game;
	import screens.Menu;
	import media.SoundManager;
	
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Main extends Sprite 
	{
		public static const GAME_SCREEN : String = "gameScreen";
		public static const MENU_SCREEN : String = "menuScreen";
		public static const END_SCREEN : String = "endScreen";
		
		private var menu : Menu = new Menu();
		
		private var timesToWin : int;
		private var singlePlayer : Boolean;
		
		private var game : Game = new Game(0,true);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			SoundManager.loadSounds();
			addEventListener(Event.ENTER_FRAME, checkSoundLoaded);
		}
		
		private function checkSoundLoaded(e:Event):void 
		{
			if (SoundManager.allSoundsLoaded) {
				removeEventListener(Event.ENTER_FRAME, checkSoundLoaded);
				switchScreen(MENU_SCREEN);
			}
		}
		
		private function switchScreen(screen : String) :void {
			switch(screen) {
				case GAME_SCREEN:
					if (contains(menu)) {
						removeEventListener(Menu.START_GAME, startGame);
						menu.destroy();
						removeChild(menu);
						menu = null;
					}
					addEventListener(Game.GOTO_MENU, gameEnd);
					game = new Game(timesToWin,singlePlayer);
					addChild(game);
				break
				case MENU_SCREEN:
					if (contains(game)) {
						removeEventListener(Game.GOTO_MENU, gameEnd);
						game.destroy();
						removeChild(game);
						game = null;
					}
					menu = new Menu();
					addChild(menu);
					addEventListener(Menu.START_GAME, startGame);
				break
				
			}
		}
		
		private function startGame(e:Event):void 
		{
			var event : StartGameEvent = e as StartGameEvent;
			timesToWin = event.timesToWin;
			singlePlayer = event.aiPlaying;
			switchScreen(GAME_SCREEN);
		}
		
		private function gameEnd(e:Event):void 
		{
			switchScreen(MENU_SCREEN);
		}
		
	}
	
}