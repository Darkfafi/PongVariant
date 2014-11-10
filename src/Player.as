package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player extends Sprite
	{
		public var speed : Number = 10;
		public var dir : int = 0;
		
		private var meltSpeed : Number = 0.05;
		
		private var art : Sprite = new Sprite();
		
		public function Player() 
		{
			drawPlayer();
		}
		
		private function drawPlayer():void 
		{
			art.graphics.beginFill(0x0099FF, 1);
			art.graphics.drawRect(0, 40, 15, 80);
			art.graphics.endFill();
			
			addChild(art);
		}
		
		public function update() :void 
		{
			movement();
		}
		
		private function movement():void 
		{
			if (this.y >= stage.stageHeight - (this.height * 1.5) && dir == 1 || this.y <= 0 - (this.height / 2) && dir == -1) {
				dir = 0;
			}else {
				this.y += speed * dir;
			}
		}
		
		public function meltPlayer() :void {
			if (scaleY >= 0.3) {
				scaleY -= meltSpeed;
			}
		}
	}

}