package media 
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class MusicSoundButton extends SoundButton
	{
		public function MusicSoundButton() :void{
			muteArt = new MutedMusic();
			unMuteArt = new UnMutedMusic();
		}
		
		override protected function muteSound(e:MouseEvent):void 
		{			
			if (SoundManager.muteMusic()) {
				muteArt.visible = false;
				unMuteArt.visible = true;
			}else {
				muteArt.visible = true;
				unMuteArt.visible = false;
			}
		}
		
	}

}