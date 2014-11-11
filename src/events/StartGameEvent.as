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
		
		public function StartGameEvent(strng : String,winTimes : int, bub : Boolean) 
		{
			super(strng, bub);
			timesToWin = winTimes;
		}
		
	}

}