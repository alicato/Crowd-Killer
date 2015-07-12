package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 42Ferra
	 */
	public class Personnage extends GameEntity
	{
		public static const		PWIDTH:int = 10;
		public static const		PHEIGHT:int = 24;
		public static const		PHEADMARGIN:int = 2;
		public static const		PHEADSIZE:int = 5;
		
		protected var			_alive:Boolean;
		protected var			_img:Sprite;
		
		protected var			_left:Boolean;
		protected var			_right:Boolean;
		protected var			_up:Boolean;
		protected var			_down:Boolean;
		
		protected var			_lastDir:int;
		
		protected var			_shuriken:Shuriken;
		
		public function Personnage(window:Sprite)
		{
			super();
			_img = new Sprite();
			var _posX:int = Math.random() * (GameEntity.WINDOWWIDTH - PWIDTH * 2) + PWIDTH;
			var _posY:int = Math.random() * (GameEntity.WINDOWHEIGHT - PHEIGHT * 2) + PHEIGHT;
			_alive = true;
			_lastDir = Shuriken.RIGHTDIR;
			
			/*_img.graphics.lineStyle(2, 0); // katana
			_img.graphics.moveTo( -(pw / 2) - 1, 3);
			_img.graphics.lineTo((pw / 2), -ph / 2);
			_img.graphics.lineStyle();*/
			
			_img.graphics.beginFill(0); // ninja base
			_img.graphics.drawEllipse( -(PWIDTH / 2), -(PHEIGHT / 2), PWIDTH, PWIDTH);
			_img.graphics.beginFill(0);
			_img.graphics.drawRect( -(PWIDTH / 2), -(PHEIGHT / 2) + PWIDTH / 2, PWIDTH, PHEIGHT - PWIDTH);
			
			_img.graphics.beginFill(0xFFCD94);// ninja head
			_img.graphics.drawEllipse( -(PWIDTH / 2) + PHEADMARGIN, -(PHEIGHT / 2) + PHEADMARGIN, PWIDTH - PHEADMARGIN * 2, PWIDTH - PHEADMARGIN * 2);
			_img.graphics.beginFill(0);
			_img.graphics.drawRect( -(PWIDTH / 2), -(PHEIGHT / 2) + PHEADMARGIN * 3, PWIDTH, PHEIGHT - PWIDTH + PHEADMARGIN);
			
			_img.graphics.beginFill(0);// ninja clothes
			_img.graphics.drawEllipse( -(PWIDTH / 2) + PHEADMARGIN * 3 - 1, -(PHEIGHT / 2) + PWIDTH / 2 - 1, 1, 1);
			_img.graphics.drawEllipse((PWIDTH / 2) - PHEADMARGIN * 3 - 1, -(PHEIGHT / 2) + PWIDTH / 2 - 1, 1, 1);
			
			_img.graphics.lineStyle(2, 0xCFCFCF); // knife
			_img.graphics.moveTo(PWIDTH / 2 - 2, 3);
			_img.graphics.lineTo(PWIDTH / 2 - 1, 6);
			_img.graphics.lineStyle();
			
			_img.graphics.beginFill(0x606060);// belts
			_img.graphics.drawRect( -(PWIDTH / 2), -4, PWIDTH, 2);
			_img.graphics.drawRect( -(PWIDTH / 2), 4, PWIDTH, 2);
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
		
		public function get lastDir():int 
		{
			return _lastDir;
		}
		
		public function set lastDir(value:int):void 
		{
			_lastDir = value;
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
		
		public function	attack():void
		{
			if (_shuriken)
				return ;
			_shuriken = new Shuriken(lastDir, this);
			_img.parent.addChild(_shuriken);
		}
		
		public function moveShuriken():void
		{
			if (!_shuriken)
				return ;
			if (!_shuriken.move())
			{
				_img.parent.removeChild(_shuriken);
				_shuriken = null;
			}
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
			
			if (_img.x < GameEntity.BORDERSIZE + PWIDTH / 2)
			{
				_img.x = GameEntity.BORDERSIZE + PWIDTH / 2;
				if (this is PNJ)
				{
					_left = false;
					_right = true;
				}
			}
			else if (_img.x > GameEntity.WINDOWWIDTH - PWIDTH / 2 - GameEntity.BORDERSIZE)
			{
				_img.x = GameEntity.WINDOWWIDTH - PWIDTH / 2 - GameEntity.BORDERSIZE;
				if (this is PNJ)
				{
					_left = true;
					_right = false;
				}
			}
			if (_img.y < GameEntity.BORDERSIZE + PHEIGHT / 2)
			{
				_img.y = GameEntity.BORDERSIZE + PHEIGHT / 2;
				if (this is PNJ)
				{
					_up = false;
					_down = true;
				}
			}
			else if (_img.y > GameEntity.WINDOWHEIGHT - PHEIGHT / 2 - GameEntity.BORDERSIZE)
			{
				_img.y = GameEntity.WINDOWHEIGHT - PHEIGHT / 2 - GameEntity.BORDERSIZE;
				if (this is PNJ)
				{
					_up = true;
					_down = false;
				}
			}
		}
		
		public function die():void
		{
			this._alive = false;
			if (Math.random() > 0.5)
				this._img.rotation = 90;
			else
				this._img.rotation = -90;
		}
	}

}