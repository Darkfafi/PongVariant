package media
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class SoundManager
	{
		public static const MENU_BG_MUSIC : int = 0;
		public static const GAME_BG_MUSIC : int = 1;
		
		private static var buttonTransform : SoundTransform = new SoundTransform(0.5);
		private static var musicTransform : SoundTransform = new SoundTransform(0.5);
		
		private static var soundChannel : SoundChannel = new SoundChannel();
		private static var musicChannel : SoundChannel = new SoundChannel();
		
		private static var totalSoundsLoaded : int = 0;
		public static var allSoundsLoaded : Boolean = false;
		private static var allUrls : Array = [];
		private static var allSounds : Array = [];
		
		
		public static function loadSounds() : void {
			
			// music
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/Instrument.mp3")); // Menu Music
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/Instrument2.mp3")); // Game Music
			
			//sounds/effects
			for (var i : int = 0; i < allUrls.length; i++) {
				
				var sound : Sound = new Sound();
				sound.addEventListener(Event.COMPLETE, soundLoaded);
				sound.load(allUrls[i]);
				allSounds.push(sound);
				
			}
			if (allUrls.length == 0) {
				allSoundsLoaded = true;
			}
		}
		
		static private function soundLoaded(e:Event):void 
		{
			e.target.removeEventListener(Event.COMPLETE, soundLoaded);
			allSoundsLoaded += 1;
			if (allSoundsLoaded == allUrls.length && allSoundsLoaded == allSounds.length) {
				allSoundsLoaded = true;
			}
		}
		
		public static function playSound(soundInt : int) :void {
			var sound : Sound = new Sound();
			
			sound = allSounds[soundInt];
			if(sound != null){
				if (sound == allSounds[MENU_BG_MUSIC] || sound == allSounds[GAME_BG_MUSIC]) {
					musicChannel.stop();
					trace(sound);
					musicChannel = sound.play(0, 9999);	
				}
				else {
					soundChannel = sound.play(0, 0);
				}
			}
		}
	}

}