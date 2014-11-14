package media 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EffectsSoundButton extends SoundButton
	{
		public function EffectsSoundButton() :void{
			muteArt = new MutedSound();
			unMuteArt = new UnMutedSound();
		}
		override protected function muteSound(e:MouseEvent):void 
		{
			if (SoundManager.muteSound()) {
				muteArt.visible = false;
				unMuteArt.visible = true;
			}else {
				muteArt.visible = true;
				unMuteArt.visible = false;
			}
		}
		
	}

}