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
			var fireWall : MovieClip = new FlameWall();
			
			var cool1 : MovieClip = new CoolPlaceArt();
			var cool2 : MovieClip = new CoolPlaceArt();
			
			var coolEffect1 : MovieClip = new SnowEffect();
			var coolEffect2 : MovieClip = new SnowEffect();
			
			addChild(backGround);
			
			cool1.x = cool1.width / 2;
			cool1.y = stage.stageHeight;
			
			coolEffect1.x = cool1.x - 15;
			coolEffect1.y = cool1.y + 40;
			
			cool2.x = stage.stageWidth - cool2.width / 2; 
			cool2.y = cool1.y;
			
			coolEffect2.x = cool2.x + 15;
			coolEffect2.y = cool2.y + 40;
			
			fireWall.x = stage.stageWidth / 2.05;
			fireWall.y = stage.stageHeight + 25;
			fireWall.scaleX = 0.67;
			
			addChild(fireWall);
			addChild(coolEffect1);
			addChild(cool1);
			addChild(coolEffect2);
			addChild(cool2);
			
		}
		
	}

}