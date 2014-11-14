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
		public static const BALL_PANNEL_COLLSION : int = 2;
		public static const UPGRADE_BALL_SOUND : int = 3;
		public static const GROW_PLAYER_SOUND : int = 4;
		public static const READY_BEGIN : int = 5;
		public static const READY_END : int = 6;
		
		private static var soundTransform : SoundTransform = new SoundTransform(0.7);
		private static var musicTransform : SoundTransform = new SoundTransform(0.5);
		
		private static var soundChannel : SoundChannel = new SoundChannel();
		private static var musicChannel : SoundChannel = new SoundChannel();
		
		private static var musicPausePos : int;
		private static var currentMusic : Sound;
		
		private static var constSound : Sound = null;
		
		private static var totalSoundsLoaded : int = 0;
		public static var allSoundsLoaded : Boolean = false;
		private static var allUrls : Array = [];
		private static var allSounds : Array = [];
		
		
		public static function loadSounds() : void {
			
			// music
			
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/Instrument.mp3")); // Menu Music
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/Instrument2.mp3")); // Game Music
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/crashInIce.mp3")); // Ice ball collision Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/vuurUpgrade.mp3")); // upgrade ball Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/spelerGroter.mp3")); // grow Player Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/readyEnd.mp3")); // Ready (go) 3Sound
			allUrls.push(new URLRequest("http://15826.hosts.ma-cloud.nl/Leerjaar2/Projecten/PongGame/sounds/readyBegin.mp3")); // Ready 1 and 2 (ready, set)Sound
			
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
					currentMusic = sound;
					musicChannel = currentMusic.play(0, 9999,musicTransform);	
				}else if (sound == allSounds[GROW_PLAYER_SOUND]) {
					
					if (constSound == null) {
						constSound = sound;
						soundChannel = constSound.play(1800,0,soundTransform);
						soundChannel.addEventListener(Event.SOUND_COMPLETE, setConstNull);
					}
				}
				else {
					soundChannel = sound.play(0, 0,soundTransform);
				}
			}
		}
		
		static private function setConstNull(e:Event):void 
		{
			soundChannel.removeEventListener(Event.COMPLETE, setConstNull);
			constSound = null;
		}
		
		public static function muteSound() :Boolean {
			if (soundTransform.volume == 0) {
				soundTransform.volume = 0.7;
				return true;
			}else {
				soundTransform.volume = 0;
				return false;
			}
		}
		public static function muteMusic() :Boolean {
			if (musicTransform.volume == 0) {
				musicTransform.volume = 0.5;
				musicChannel = currentMusic.play(musicPausePos, 999, musicTransform);
				return true;
			}else {
				musicPausePos = musicChannel.position;
				musicChannel.stop();
				musicTransform.volume = 0;
				return false;
			}
		}
		public static function stopSound() :void {
			soundChannel.stop();
			musicChannel.stop();
		}
	}

}