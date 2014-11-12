package  
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class AI 
	{
		private var ball : Ball;
		private var player : Player;
		private var stage : Stage;
		
		public function AI(_ball : Ball, _player : Player,_stage : Stage) 
		{
			ball = _ball;
			player = _player;
			stage = _stage;
		}
		public function movement():void 
		{
			if (ball.dir == 1 && player.scaleY > 0.5) {
				var chance : int =  2;
				if (ball.x > stage.stageWidth / chance) {
					if (ball.y - player.y < 5 && ball.y - player.y > -13) {
						player.dir = 0;
					}
					else if (ball.y > player.y) {
						player.dir = 1;
					}else if (ball.y < player.y) {
						player.dir = -1;
					}
				}
			}else if(player.scaleY <= 0.5){
				player.dir = 1;
			}else if (ball.dir < 1 && player.y >= stage.stageHeight) {
				if (ball.y - player.y < 3 && ball.y - player.y > -11) {
					player.dir = 0;
				}
				else if (stage.stageHeight / 2 > player.y + player.height) {
					player.dir = 1;
				}else if (stage.stageHeight / 2 < player.y + player.height) {
					player.dir = -1;
				}
			}
		}
		
	}

}