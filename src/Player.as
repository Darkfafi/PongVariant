package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player extends Sprite
	{
		public var speed : Number = 15;
		public var dir : int = 0;
		
		private var coolingDown : Boolean = false;
		
		private var meltSpeed : Number = 0.05;
		private var growSpeed : Number = 0.01;
		
		private var art : Sprite = new Sprite();
		
		public function Player() 
		{
			drawPlayer();
		}
		
		private function drawPlayer():void 
		{
			art = new PlayerArt();
			addChild(art);
		}
		
		public function update() :void 
		{
			movement();
			collisionColdPlace();
		}
		
		private function collisionColdPlace():void 
		{
			if (this.y >= stage.stageHeight - this.height && !coolingDown) {
				
				coolingDown = true;
				
			}else if (coolingDown) {
				
				coolingDown = false;
			}
			if (coolingDown) {
				growPallet();
			}
		}
		
		private function growPallet():void 
		{
			if (this.scaleY < 1) {
				this.scaleY += growSpeed;
				y -= 1 - growSpeed;
			}
		}
		
		private function movement():void 
		{
			if (this.y >= stage.stageHeight - this.height / 2 && dir == 1 || this.y <= 0 + (this.height / 2) && dir == -1) {
				dir = 0;
			}else {
				
				this.y += speed * dir;
			}
		}
		
		public function meltPlayer() :void {
			if (scaleY >= 0.25) {
				scaleY -= meltSpeed;
				//Laat druppel zien
			}
		}
	}

}