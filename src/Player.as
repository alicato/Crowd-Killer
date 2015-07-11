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
		private var _left:Boolean;
		private var _right:Boolean;
		private var _up:Boolean;
		private var _down:Boolean;
		
		private var _leftBut:uint;
		private var _rightBut:uint;
		private var _upBut:uint;
		private var _downBut:uint;
		
		public function Player(window:Sprite, p1:Boolean=true) 
		{
			super(window);
			if (p1) {
				_leftBut = Keyboard.LEFT;
				_rightBut = Keyboard.RIGHT;
				_downBut = Keyboard.DOWN;
				_upBut = Keyboard.UP;
			} else {
				_leftBut = Keyboard.Q;
				_rightBut = Keyboard.D;
				_downBut = Keyboard.S;
				_upBut = Keyboard.Z;
			}
		}
		
		public function move():void
		{
			if (_up) _img.y -= 1;
			if (_down) _img.y += 1;
			if (_right) _img.x += 1;
			if (_left) _img.x -= 1;
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