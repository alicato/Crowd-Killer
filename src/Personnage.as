package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 42Ferra
	 */
	public class Personnage extends GameEntity
	{
		private static const	pw:int = 10;
		private static const	ph:int = 24;
		private static const	pmhead:int = 2;
		private static const	phead:int = 5;
		
		protected var			_alive:Boolean;
		protected var			_img:Sprite;
		
		protected var			_left:Boolean;
		protected var			_right:Boolean;
		protected var			_up:Boolean;
		protected var			_down:Boolean;
		
		public function Personnage(window:Sprite)
		{
			_img = new Sprite();
			var _posX:int = Math.random() * (GameEntity.WINDOWWIDTH - pw * 2) + pw;
			var _posY:int = Math.random() * (GameEntity.WINDOWHEIGHT - ph * 2) + ph;
			_alive = true;
			/*_img.graphics.lineStyle(2, 0); // katana
			_img.graphics.moveTo( -(pw / 2) - 1, 3);
			_img.graphics.lineTo((pw / 2), -ph / 2);
			_img.graphics.lineStyle();*/
			
			_img.graphics.beginFill(0); // ninja base
			_img.graphics.drawEllipse( -(pw / 2), -(ph / 2), pw, pw);
			_img.graphics.beginFill(0);
			_img.graphics.drawRect( -(pw / 2), -(ph / 2) + pw / 2, pw, ph - pw);
			
			_img.graphics.beginFill(0xFFCD94);// ninja head
			_img.graphics.drawEllipse( -(pw / 2) + pmhead, -(ph / 2) + pmhead, pw - pmhead * 2, pw - pmhead * 2);
			_img.graphics.beginFill(0);
			_img.graphics.drawRect( -(pw / 2), -(ph / 2) + pmhead * 3, pw, ph - pw + pmhead);
			
			_img.graphics.beginFill(0);// ninja clothes
			_img.graphics.drawEllipse( -(pw / 2) + pmhead * 3 - 1, -(ph / 2) + pw / 2 - 1, 1, 1);
			_img.graphics.drawEllipse((pw / 2) - pmhead * 3 - 1, -(ph / 2) + pw / 2 - 1, 1, 1);
			
			_img.graphics.lineStyle(2, 0xCFCFCF); // knife
			_img.graphics.moveTo(pw / 2 - 2, 3);
			_img.graphics.lineTo(pw / 2 - 1, 6);
			_img.graphics.lineStyle();
			
			_img.graphics.beginFill(0x606060);// belts
			_img.graphics.drawRect( -(pw / 2), -4, pw, 2);
			_img.graphics.drawRect( -(pw / 2), 4, pw, 2);
	/*		_img.graphics.beginFill(0);
			_img.graphics.drawRect(- (pw / 2), 0 - (ph / 2), pw, ph);
			_img.graphics.beginFill(0xFFFFFF);
			_img.graphics.drawRect(- (pw / 2) + pmhead, 0 - (ph / 2) + pmhead, pw - pmhead * 2, pw - pmhead * 2);*/
			window.addChild(_img);
			_img.x = _posX;
			_img.y = _posY;
		}
		
		/* Accesseurs */
		
		public function get alive():Boolean 
		{
			return _alive;
		}
		
		public function get img():Sprite 
		{
			return _img;
		}
		
		/**************/
		
		public function	isMoving():Boolean
		{
			if (_left || _up || _down || _right)
				return true;
			return false;
		}
		
		public function resetMoves():void
		{
			_up = false;
			_left = false;
			_down = false;
			_right = false;
		}
		
		public function countMoves():int
		{
			var count:int = 0;
			
			if ((_up && !_down) || (_down && !_up)) ++count;
			if ((_right && !_left) || (_left && !_right)) ++count;
			return (count);
		}
		
		public function move():void
		{
			var count:int = countMoves();
			if (count == 0)
				return ;
			
			if (_up) _img.y -= 1 / count;
			if (_down) _img.y += 1 / count;
			if (_right) _img.x += 1 / count;
			if (_left) _img.x -= 1 / count;
			
			if (_img.x < GameEntity.BORDERSIZE + pw / 2)
			{
				_img.x = GameEntity.BORDERSIZE + pw / 2;
				if (this is PNJ)
				{
					_left = false;
					_right = true;
				}
			}
			else if (_img.x > GameEntity.WINDOWWIDTH - pw / 2 - GameEntity.BORDERSIZE)
			{
				_img.x = GameEntity.WINDOWWIDTH - pw / 2 - GameEntity.BORDERSIZE;
				if (this is PNJ)
				{
					_left = true;
					_right = false;
				}
			}
			if (_img.y < GameEntity.BORDERSIZE + ph / 2)
			{
				_img.y = GameEntity.BORDERSIZE + ph / 2;
				if (this is PNJ)
				{
					_up = false;
					_down = true;
				}
			}
			else if (_img.y > GameEntity.WINDOWHEIGHT - ph / 2 - GameEntity.BORDERSIZE)
			{
				_img.y = GameEntity.WINDOWHEIGHT - ph / 2 - GameEntity.BORDERSIZE;
				if (this is PNJ)
				{
					_up = true;
					_down = false;
				}
			}
		}
		
	}

}