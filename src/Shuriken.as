package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 42Ferra
	 */
	public class Shuriken extends Sprite 
	{
		public static const	RIGHTDIR:int = 1;
		public static const	LEFTDIR:int = 2;
		public static const	SPEED:int = 2;
		public static const	WIDTH:int = 2;
		public static const	BASEMR:int = 15;
		
		private var			_dir:int;
		private var			_mr:int;
		private var			_owner:Personnage;

		public function Shuriken(dir:int, owner:Personnage) 
		{
			super();
			_dir = dir;
			_owner = owner;
			_mr = Shuriken.BASEMR;
			
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, Shuriken.WIDTH);
			
			switch (owner.lastDir)
			{
				case (Shuriken.RIGHTDIR):
					this.x = _owner.img.x + Personnage.PWIDTH / 2 + Shuriken.WIDTH;
					this.y = _owner.img.y, Shuriken.WIDTH;
					break;
				case (Shuriken.LEFTDIR):
					this.x = _owner.img.x - Personnage.PWIDTH / 2 - Shuriken.WIDTH;
					this.y = _owner.img.y, Shuriken.WIDTH;
					break;
			}
		}
		
		public function move():Boolean
		{
			switch (dir)
			{
				case (Shuriken.RIGHTDIR):
					this.x += Shuriken.SPEED;
					break ;
				case (Shuriken.LEFTDIR):
					this.x -= Shuriken.SPEED;
					break ;
			}
			--_mr;
			if (_mr <= 0 ||
				this.x - Shuriken.WIDTH / 2 < 0 ||
				this.x + Shuriken.WIDTH / 2 > GameEntity.WINDOWWIDTH)
				return false;
			return true;
		}
		
		public function get dir():int 
		{
			return _dir;
		}
		
		public function get owner():Personnage 
		{
			return _owner;
		}
		
	}

}