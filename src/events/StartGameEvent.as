package events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class StartGameEvent extends Event
	{
		public var timesToWin : int;
		public var aiPlaying : Boolean;
		public function StartGameEvent(strng : String,winTimes : int,singlePlayer : Boolean, bub : Boolean) 
		{
			super(strng, bub);
			timesToWin = winTimes;
			aiPlaying = singlePlayer;
		}
		
	}

}