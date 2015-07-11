package 
{
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Jito
	 */
	public class Player extends Personnage
	{
		public static var P1UP:uint = Keyboard.UP;
		public static var P1DOWN:uint = Keyboard.DOWN;
		public static var P1LEFT:uint = Keyboard.LEFT;
		public static var P1RIGHT:uint = Keyboard.RIGHT;
		public static var P1ATK:uint = Keyboard.SPACE;
		
		public static var P2UP:uint = Keyboard.Z;
		public static var P2DOWN:uint = Keyboard.S;
		public static var P2LEFT:uint = Keyboard.Q;
		public static var P2RIGHT:uint = Keyboard.D;
		public static var P2ATK:uint = Keyboard.SPACE;
		
		private var _leftBut:uint;
		private var _rightBut:uint;
		private var _upBut:uint;
		private var _downBut:uint;
		private var _atkBut:uint;
		
		public function Player(window:Sprite, p1:Boolean=true) 
		{
			super(window);
			if (p1) { 	// PLAYER 1
				_leftBut = P1LEFT;
				_rightBut = P1RIGHT;
				_downBut = P1DOWN;
				_upBut = P1UP;
				_atkBut = P1ATK;
			}
			else { 		// PLAYER 2
				_leftBut = P2LEFT;
				_rightBut = P2RIGHT;
				_downBut = P2DOWN;
				_upBut = P2UP;
				_atkBut = P2ATK;
			}
		}
		
		public function updateMoveDown(event:KeyboardEvent):void
		{
			if (event.keyCode == this._rightBut)
				this.right = true;
			if (event.keyCode == this._leftBut)
				this.left = true;
			if (event.keyCode == this.downBut)
				this.down = true;
			if (event.keyCode == this.upBut)
				this.up = true;
		}
		
		public function updateMoveUp(event:KeyboardEvent):void
		{
			if (event.keyCode == this.rightBut)
				this.right = false;
			if (event.keyCode == this.leftBut)
				this.left = false;
			if (event.keyCode == this.downBut)
				this.down = false;
			if (event.keyCode == this.upBut)
				this.up = false;
		}
		
		public function set left(value:Boolean):void 
		{
			_left = value;
		}
		
		public function set right(value:Boolean):void 
		{
			_right = value;
		}
		
		public function set up(value:Boolean):void 
		{
			_up = value;
		}
		
		public function set down(value:Boolean):void 
		{
			_down = value;
		}
		
		public function get leftBut():uint 
		{
			return _leftBut;
		}
		
		public function set leftBut(value:uint):void 
		{
			_leftBut = value;
		}
		
		public function get rightBut():uint 
		{
			return _rightBut;
		}
		
		public function set rightBut(value:uint):void 
		{
			_rightBut = value;
		}
		
		public function get upBut():uint 
		{
			return _upBut;
		}
		
		public function set upBut(value:uint):void 
		{
			_upBut = value;
		}
		
		public function get downBut():uint 
		{
			return _downBut;
		}
		
		public function set downBut(value:uint):void 
		{
			_downBut = value;
		}
		
	}
	
}