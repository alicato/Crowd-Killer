package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 42Ferra
	 */
	public class Personnage extends GameEntity
	{
		protected var	_posX:int;
		protected var	_posY:int;
		protected var	_alive:Boolean;
		protected var	_img:Sprite;
		
		public function Personnage()
		{
			_posX = Math.random() * (GameEntity.WINDOWWIDTH - 8) + 4;
			_posY = Math.random() * (GameEntity.WINDOWHEIGHT - 20) + 10;
			_alive = true;
			_img = new Sprite();
			_img.graphics.beginFill(0);
			_img.graphics.drawRect(posX - 4, posY - 10, 8, 20);
		}
		
		/* Accesseurs */
		public function get posX():int 
		{
			return _posX;
		}
		
		public function get posY():int 
		{
			return _posY;
		}
		
		public function get alive():Boolean 
		{
			return _alive;
		}
		/**************/
		
		public function displayPers(window:Sprite):void 
		{
			window.addChild(_img);
		}
		
	}

}