package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Player extends Sprite
	{
		public var speed : Number = 8;
		public var dir : int = 0;
		
		private var art : Sprite = new Sprite();
		
		public function Player() 
		{
			drawPlayer();
		}
		
		private function drawPlayer():void 
		{
			art.graphics.beginFill(0x0099FF, 1);
			art.graphics.drawRect(0, 0, 15, 60);
			art.graphics.endFill();
			
			addChild(art);
		}
		
		public function update() :void {
			movement();
		}
		
		private function movement():void {
			this.y += speed * dir;
		}
	}

}