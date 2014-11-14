package media
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import media.SoundManager;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SoundButton extends Sprite
	{
		private var hitbox : Sprite = new Sprite();
		protected var muteArt : Sprite = new Sprite(); 
		protected var unMuteArt : Sprite = new Sprite(); 
		
		public function SoundButton() 
		{
			addEventListener(MouseEvent.CLICK, muteSound);
			addEventListener(Event.ADDED_TO_STAGE,init)
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			hitbox.graphics.beginFill(0x000000, 0);
			hitbox.graphics.drawRect(0, 0, 35, 40);
			hitbox.graphics.endFill();
			
			addChild(hitbox);
			drawButton();
		}
		
		private function drawButton():void 
		{
			addChild(muteArt);
			addChild(unMuteArt);
			muteArt.visible = false;
		}
		
		protected function muteSound(e:MouseEvent):void 
		{
			//function what to mute
		}
		
	}

}