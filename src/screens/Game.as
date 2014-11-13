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
	import media.SoundManager;
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
			
			var endText : MovieClip;
			
			if (event.playerWon == 1) {
				endText = new PlayerOneWins();
			}else {
				endText = new PlayerTwoWins();
			}
			endText.x = stage.stageWidth / 2 - endText.width / 2.5;
			endText.y = stage.stageWidth / 3;
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
			
			var background : Sprite = new Background();
			addChild(background);
			startGame();
			
			addChild(ui);
		}
		
		private function startGame():void 
		{	
			timerCountDown.addEventListener(TimerEvent.TIMER, onTik);
			timerCountDown.start();
			SoundManager.playSound(SoundManager.GAME_BG_MUSIC);
		}
		
		private function onTik(e:Event):void 
		{
			var t : Timer = e.target as Timer;
			
			switch(t.currentCount) {				
				case 1:
					trace("READY");
					SoundManager.playSound(SoundManager.READY_BEGIN);
				break;
					
				case 2:
					trace("SET");
					SoundManager.playSound(SoundManager.READY_BEGIN);
				break;
				case 3:
					timerCountDown.removeEventListener(TimerEvent.TIMER, onTik);
					trace("GO");
					SoundManager.playSound(SoundManager.READY_END);
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
			
			playerOne.x = 75;
			playerOne.y = stage.stageHeight / 2;
			playerOne.scaleX = -1;
			
			playerTwo.x = stage.stageWidth - 75;
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
			ball.speed = 17;
			ball.rotation = 270;
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
			ball.rotation = 0;
			ball.rotation = rot;
			ball.setVelocity(ball.speed);
		}
		
		private function collisionBall() :void {
			if (ball.ballArt.hitTestObject(playerOne) && ball.dir == -1) {
				SoundManager.playSound(SoundManager.BALL_PANNEL_COLLSION);
				ball.rotateDirection();
				
				var hit1 : Number = (playerOne.y - ball.y);
				hit1 = (hit1 * -2) / 10;
				
				playerOne.meltPlayer();
				ball.setRotation(hit1);
				
			}else if (ball.ballArt.hitTestObject(playerTwo) && ball.dir == 1) {
				SoundManager.playSound(SoundManager.BALL_PANNEL_COLLSION);
				ball.rotateDirection();
				
				var hit2 : Number = (playerTwo.y - ball.y);
				hit2 = (hit2 * -2) / 10;
				
				playerTwo.meltPlayer();
				ball.setRotation(hit2);
			}
			
			if (ball.y >= stage.stageHeight || ball.y <= 0) {
				ball.setRotation(ball.velocity.y * -1);
				if (ball.y >= stage.stageHeight) {
					if (ball.speed < 17 + 5) {
						SoundManager.playSound(SoundManager.UPGRADE_BALL_SOUND);
						ball.speed += 1;
						ball.setVelocity(ball.speed);
					}
				}
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