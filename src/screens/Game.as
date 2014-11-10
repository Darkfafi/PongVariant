package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import utils.Vector2D;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Game extends Screen
	{
		private var gameRunning : Boolean = true;
		private var shootBallTimer : Number;
		private var ui : UI = new UI();
		
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
			
			addChild(ui);
		}
		
		private function startGame():void 
		{
			//background placeHolder
				var backGround : Sprite = new Sprite();
				backGround.graphics.beginFill(0x000000, 1);
				backGround.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
				backGround.graphics.lineStyle(2, 0x000000,1);
				backGround.graphics.endFill();
				backGround.graphics.beginFill(0xffffff, 1);
				backGround.graphics.drawRect(stage.stageWidth / 2, 0, 4, stage.stageHeight);
				backGround.graphics.endFill();
				addChild(backGround);
			//----------------------------------
			
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
			
			placeBall();
			
			addChild(playerOne);
			addChild(playerTwo);
			addChild(ball);
		}
		
		private function placeBall(pScred : int = 999):void 
		{
			ball.location = new Vector2D(stage.stageWidth / 2, stage.stageHeight / 2 - ball.height);
			ball.setVelocity(0);
			ball.setRotation(0);
			ball.dir = 0;
			
			//zet bal animatie op idle
			
			if(pScred == 999){
				shootBallTimer = setInterval(shootBall, 2000);
			}else {
				var choseDir = pScred == 1 ? 1 : -1;
				shootBallTimer = setInterval(shootBall, 2000,choseDir);
			}
		}
		
		private function shootBall(_dir : int = 999):void 
		{
			var rot : Number;
			
			clearInterval(shootBallTimer);
			if(_dir == 999){
				ball.dir = Math.floor(Math.random() * 2) == 1 ? 1 : -1;
			}else {
				ball.dir = _dir;
			}
			rot = ball.dir == 1 ? 0 : 180;
			ball.rotation = rot;
			ball.setVelocity(ball.speed);
			
			//zet bal animatie op moving
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
			
			if (ball.x <= 0) {
				//player 2 scored
				ui.addScore(2);
				placeBall(2);
			}else if (ball.x >= stage.stageWidth) {
				//player 1 scored
				ui.addScore(1);
				placeBall(1);
			}
		}
	}

}