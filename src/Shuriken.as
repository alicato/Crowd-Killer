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
		public static const	SPEED:int = 2;			// Si SPEED > Personnage.PWIDTH, il peut y avoir des problèmes de collision. 
		public static const	WIDTH:int = 2;
		public static const	BASEMR:int = 15;
		static private const ROTATESPEED:int = 12;
		
		private var			_dir:int;
		private var			_mr:int;
		private var			_owner:Personnage;

		public function Shuriken(dir:int, owner:Personnage) 
		{
			super();
			_dir = dir;
			_owner = owner;
			_mr = Shuriken.BASEMR;
			
			graphics.beginFill(0x404040);
			var step : Number, halfStep : Number, start : Number, n : Number, dx : Number, dy : Number;
			step = (Math.PI * 2) / 4;
			halfStep = step / 2;
			start = (45 / 180) * Math.PI;
			graphics.moveTo((Math.cos( start ) * 2), -(Math.sin( start ) * 2));
			for (n = 1; n <= 4; ++n) {
				dx = Math.cos( start + (step * n) - halfStep ) * 4;
				dy = -Math.sin( start + (step * n) - halfStep ) * 4;
				graphics.lineTo( dx, dy );
				dx = Math.cos( start + (step * n) ) * 2;
				dy = -Math.sin( start + (step * n) ) * 2;
				graphics.lineTo( dx, dy );
			}
			graphics.drawCircle(0, 0, 1);
			
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
					this.rotation += ROTATESPEED;
					break ;
				case (Shuriken.LEFTDIR):
					this.x -= Shuriken.SPEED;
					this.rotation -= ROTATESPEED;
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