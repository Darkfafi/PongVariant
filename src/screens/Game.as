package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import utils.Vector2D;
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
			
			ball.setVelocity(ball.speed);
			
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
				ball.update();
				collisionBall();
			}
		}
		
		private function placeObjects():void 
		{
			
			playerOne.x = 50;
			playerOne.y = stage.stageHeight / 2 - playerOne.height * 1.25;
			
			playerTwo.x = stage.stageWidth - 50 - playerTwo.width / 2;
			playerTwo.y = playerOne.y;
			
			ball.location = new Vector2D(stage.stageWidth / 2, stage.stageHeight / 2 - ball.height); 
			
			addChild(playerOne);
			addChild(playerTwo);
			addChild(ball);
		}
		
		private function collisionBall() :void {
			if (ball.ballArt.hitTestObject(playerOne) && ball.dir == -1) {
				
				ball.rotateDirection();
				var hit1 : Number = (playerOne.height - (ball.y - playerOne.y));
				hit1 = (hit1 * -2) / 10;
				
				playerOne.meltPlayer();
				ball.setRotation(hit1);
				
			}else if (ball.ballArt.hitTestObject(playerTwo) && ball.dir == 1) {
				
				ball.rotateDirection();
				
				var hit2 : Number = (playerTwo.height - (ball.y - playerTwo.y));
				hit2 = (hit2 * -2) / 10;
				
				playerTwo.meltPlayer();
				ball.setRotation(hit2);
			}
			
			if (ball.y >= stage.stageHeight || ball.y <= 0) {
				ball.setRotation(ball.velocity.y * -1);
			}
		}
	}

}