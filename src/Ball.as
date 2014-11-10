package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Ball extends Sprite
	{
		//zijn rotatie en directie word verandert na hitten. de directie meld de hit test. dus bal met dir 1 kan alleen speler 1 raken en anders speler 2
		private var art : Sprite = new Sprite();
		
		private var speed : Number;  // des de groter de hoek des de groter de speed
		
		public function Ball() 
		{
			drawBall();
		}
		
		private function drawBall():void 
		{
			art.graphics.beginFill(0xFF0000, 1);
			art.graphics.drawCircle(0, 0, 10);
			art.graphics.endFill();
			
			addChild(art);
		}
		
	}

}