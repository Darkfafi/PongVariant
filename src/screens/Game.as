package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Game extends Screen
	{
		private var gameRunning : Boolean = true;
		
		//Players
		private var playerOne : Player = new Player();
		private var playerTwo : Player = new Player();
		
		//Ball
		private var ball : Ball = new Ball();
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			startGame();
		}
		
		private function startGame():void 
		{
			placeObjects();
			
			addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if(gameRunning){
				//playerOne Movement
				if (e.keyCode == Keyboard.UP) {
					playerTwo.dir = -1;
				}else if (e.keyCode == Keyboard.DOWN) {
					playerTwo.dir = 1;
				}
				//playerTwo Movement
				if (e.keyCode == Keyboard.W){
					playerOne.dir = -1;
				}else if (e.keyCode == Keyboard.S) {
					playerOne.dir = 1;
				}
			}
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			//playerOne Movement
			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN) {
				playerTwo.dir = 0;
			}
			//playerTwo Movement
			if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.S) {
				playerOne.dir = 0;
			}
		}
		
		private function update(e:Event):void 
		{
			if (gameRunning) {
				playerOne.update();
				playerTwo.update();
			}
		}
		
		private function placeObjects():void 
		{
			
			playerOne.x = 50;
			playerOne.y = stage.stageHeight / 2 - playerOne.height;
			
			playerTwo.x = stage.stageWidth - 50 - playerTwo.width;
			playerTwo.y = playerOne.y;
			
			ball.x = stage.stageWidth / 2;
			ball.y = stage.stageHeight / 2 - ball.height; 
			
			addChild(playerOne);
			addChild(playerTwo);
			addChild(ball);
		}
		
	}

}