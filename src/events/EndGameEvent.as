package events 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class EndGameEvent extends Event
	{
		public var playerWon : int;
		
		public function EndGameEvent(_string : String, _playerWon : int, _bub : Boolean) 
		{
			super(_string, _bub);
			playerWon = _playerWon;
		}
		
	}

}