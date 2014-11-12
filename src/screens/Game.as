package screens 
{
	import events.EndGameEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import utils.Vector2D;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Game extends Screen
	{
		public static const GOTO_MENU : String = "gotoMenu";
		
		private var aiPlaying : Boolean;
		private var gameRunning : Boolean = true;
		private var shootBallTimer : Number;
		private var timerCountDown : Timer = new Timer(1000,3);
		private var ui : UI;
		private var ai : AI;
		
		//Players
		private var playerOne : Player = new Player();
		private var playerTwo : Player = new Player();
		
		//Ball
		private var ball : Ball = new Ball();
		
		public function Game(timesToWin : int,singlePlayer : Boolean) 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			aiPlaying = singlePlayer;
			ui = new UI(timesToWin);
			addEventListener(UI.GAME_SET, endGame);
		}
		
		private function endGame(e:Event):void 
		{
			removeEventListener(UI.GAME_SET, endGame);
			var event : EndGameEvent = e as EndGameEvent;
			gameRunning = false;
			removeChild(ball);
			
			var endText : TextField = new TextField();
			endText.defaultTextFormat = new TextFormat(null, 30, 0xFF00FF);
			endText.text = "PLAYER " +  event.playerWon + " WON!";
			endText.width = 300;
			endText.x = stage.stageWidth / 3;
			endText.y = stage.stageHeight / 2;
			addChild(endText);
			setInterval(returnMenu, 3000);
		}
		
		private function returnMenu():void 
		{
			dispatchEvent(new Event(GOTO_MENU, true));
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var backGround : MovieClip = new GameBG();
			var cool1 : MovieClip = new CoolPlaceArt();
			var cool2 : MovieClip = new CoolPlaceArt();
			addChild(backGround);
			cool1.x = cool1.width / 2;
			cool1.y = stage.stageHeight;
			cool2.x = stage.stageWidth - cool2.width / 2; 
			cool2.y = cool1.y;
			addChild(cool1);
			addChild(cool2);
			
			startGame();
			
			addChild(ui);
		}
		
		private function startGame():void 
		{	
			timerCountDown.addEventListener(TimerEvent.TIMER, onTik);
			timerCountDown.start();
		}
		
		private function onTik(e:Event):void 
		{
			var t : Timer = e.target as Timer;
			
			switch(t.currentCount) {				
				case 1:
					trace("READY");
				break;
					
				case 2:
					trace("SET");
				break;
				case 3:
					timerCountDown.removeEventListener(TimerEvent.TIMER, onTik);
					trace("GO");
					placeObjects();
					addEventListener(Event.ENTER_FRAME, update);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
					stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
				break;
			}
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (gameRunning) {
				if(!aiPlaying){
					//playerTwo Movement
					if (e.keyCode == Keyboard.UP) {
						playerTwo.dir = -1;
					}else if (e.keyCode == Keyboard.DOWN) {
						playerTwo.dir = 1;
					}
				}
				//playerOne Movement
				if (e.keyCode == Keyboard.W){
					playerOne.dir = -1;
				}else if (e.keyCode == Keyboard.S) {
					playerOne.dir = 1;
				}
			}
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			if(!aiPlaying){
				//playerTwo Movement
				if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN) {
					playerTwo.dir = 0;
				}
			}
			//playerOne Movement
			if (e.keyCode == Keyboard.W || e.keyCode == Keyboard.S) {
				playerOne.dir = 0;
			}
		}
		
		private function update(e:Event):void 
		{
			if (gameRunning) {
				if(aiPlaying){
					ai.movement();
				}
				playerOne.update();
				playerTwo.update();
				ball.update();
				collisionBall();
			}
		}
		private function placeObjects():void 
		{
			
			playerOne.x = 50;
			playerOne.y = stage.stageHeight / 2;
			playerOne.rotation = 180;
			
			playerTwo.x = stage.stageWidth - 50 - playerTwo.width / 2;
			playerTwo.y = playerOne.y;
			
			placeBall();
			
			addChild(playerOne);
			addChild(playerTwo);
			addChild(ball);
			if(aiPlaying){
				ai = new AI(ball, playerTwo,stage);
			}
		}
		
		private function placeBall(pScred : int = 999):void 
		{
			ball.location = new Vector2D(stage.stageWidth / 2, stage.stageHeight / 2 - ball.height);
			ball.setVelocity(0);
			ball.setRotation(0);
			ball.dir = 0;
			
			//zet bal animatie op idle
			
			if(pScred == 999){
				shootBallTimer = setInterval(shootBall, 1000);
			}else {
				var choseDir : int = pScred == 1 ? 1 : -1;
				shootBallTimer = setInterval(shootBall, 1500,choseDir);
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
				
				var hit1 : Number = (playerOne.y - ball.y);
				hit1 = (hit1 * -2) / 10;
				
				playerOne.meltPlayer();
				ball.setRotation(hit1);
				
			}else if (ball.ballArt.hitTestObject(playerTwo) && ball.dir == 1) {
				
				ball.rotateDirection();
				
				var hit2 : Number = (playerTwo.y - ball.y);
				hit2 = (hit2 * -2) / 10;
				
				playerTwo.meltPlayer();
				ball.setRotation(hit2);
			}
			
			if (ball.y >= stage.stageHeight || ball.y <= 0) {
				ball.setRotation(ball.velocity.y * -1);
			}
			
			if (ball.x + ball.width <= 0) {
				//player 2 scored
				placeBall(2);
				ui.addScore(2);
			}else if (ball.x - ball.width >= stage.stageWidth) {
				//player 1 scored
				placeBall(1);
				ui.addScore(1);
			}
		}
		
		override public function destroy():void 
		{
			clearInterval(shootBallTimer);
			removeEventListener(Event.ENTER_FRAME, update);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			super.destroy();
		}
	}

}