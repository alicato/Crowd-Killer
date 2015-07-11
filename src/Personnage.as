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
		
		protected var			_alive:Boolean;
		protected var			_img:Sprite;
		
		public function Personnage(window:Sprite)
		{
			_img = new Sprite();
			var _posX:int = Math.random() * (GameEntity.WINDOWWIDTH - pw * 2) + pw;
			var _posY:int = Math.random() * (GameEntity.WINDOWHEIGHT - ph * 2) + ph;
			_alive = true;
			_img.graphics.beginFill(0);
			_img.graphics.drawRect(0 - (ph / 2), 0 - (ph / 2), pw, ph);
			_img.graphics.beginFill(0xFFFFFF);
			_img.graphics.drawRect(0 - (ph / 2) + pmhead, 0 - (ph / 2) + pmhead, pw - pmhead * 2, pw - pmhead * 2);
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
		
	}

}