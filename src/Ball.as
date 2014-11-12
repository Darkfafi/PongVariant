package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import utils.Vector2D;
	/**
	 * ...
	 * @author Ramses di Perna
	 */
	public class Ball extends Sprite
	{
		//zijn rotatie en directie word verandert na hitten. de directie meld de hit test. dus bal met dir 1 kan alleen speler 1 raken en anders speler 2
		public var ballArt : Sprite = new Sprite();
		private var effectArt : Sprite = new Sprite();
		
		public var dir : int = 0;
		public var speed : int = 17;  // des de groter de hoek des de groter de speed
		
		private var _location : Vector2D;
		private var _velocity : Vector2D = new Vector2D(0,0);
		
		public function Ball() 
		{
			drawBall();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.x = _location.x;
			this.y = _location.y;
		}
		
		private function drawBall():void 
		{
			
			ballArt.graphics.beginFill(0xFF0000, 1);
			ballArt.graphics.drawCircle(0, 0, 10);
			ballArt.graphics.endFill();
			
			effectArt.graphics.beginFill(0xFF00FF, 1);
			effectArt.graphics.drawCircle(-10, 0, 10);
			effectArt.graphics.endFill();
			
			addChild(effectArt);
			addChild(ballArt);
		}
		public function update() :void 
		{
			movement();
		}
		public function setVelocity(_speed : int) : void {
			_velocity = new Vector2D(_speed * dir, _velocity.y);
		}
		public function setRotation(_rotation : Number) : void {
			_velocity = new Vector2D(_velocity.x, _rotation);
			rotation = Math.atan2(_velocity.y, _velocity.x) * 180 / Math.PI;
		}
		public function rotateDirection() : void {
			dir *= -1;
			_velocity = new Vector2D(_velocity.x * -1, _velocity.y);
		}
		private function movement():void 
		{
			_location = _location.add(_velocity);
			
			this.x = _location.x;
			this.y = _location.y;
		}
		
		public function set location(value:Vector2D):void 
		{
			_location = value;
		}
		
		public function get velocity():Vector2D 
		{
			return _velocity;
		}
	}

}