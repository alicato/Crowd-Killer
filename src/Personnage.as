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
		
		protected var			_posX:int;
		protected var			_posY:int;
		protected var			_alive:Boolean;
		protected var			_img:Sprite;
		
		public function Personnage()
		{
			_img = new Sprite();
			_posX = Math.random() * (GameEntity.WINDOWWIDTH - pw) + pw / 2;
			_posY = Math.random() * (GameEntity.WINDOWHEIGHT - ph) + ph / 2;
			_alive = true;
			_img.graphics.beginFill(0);
			_img.graphics.drawRect(_posX - (ph / 2), _posY - (ph / 2), pw, ph);
			_img.graphics.beginFill(0xFFFFFF);
			_img.graphics.drawRect(_posX - (ph / 2) + pmhead, _posY - (ph / 2) + pmhead, pw - pmhead * 2, pw - pmhead * 2);
		}
		
		/* Accesseurs */
		
		public function get alive():Boolean 
		{
			return _alive;
		}
		
		public function get posY():int 
		{
			return _posY;
		}
		
		public function get posX():int 
		{
			return _posX;
		}
		/**************/
		
		public function displayPers(window:Sprite):void 
		{
			window.addChild(_img);
		}
		
	}

}