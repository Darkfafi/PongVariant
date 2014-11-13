package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Background extends Sprite
	{
		
		public function Background() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
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
			
			for (var i : uint = 0; i < 1; i++) {
				var fireWall : MovieClip = new FlameWall();
				switch(i) {
					case 0:
						fireWall.x = stage.stageWidth / 2.05;
						fireWall.y = stage.stageHeight + 25;
						fireWall.scaleX = 0.67;
					break;
					case 1:
						fireWall.x = -15;
						fireWall.y = stage.stageHeight / 2;
						fireWall.rotation = 90;
					break;
					case 2:
						fireWall.x = stage.stageWidth + 15;
						fireWall.y = stage.stageHeight / 2;
						fireWall.rotation = 270;
					break;
					case 3:
						fireWall.x = stage.stageWidth / 2;
						fireWall.y = - 15;
						fireWall.rotation = 180;
					break;
				}
				addChild(fireWall);
			}
			
			addChild(cool1);
			addChild(cool2);
			
		}
		
	}

}