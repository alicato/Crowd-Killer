package
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 42Ferra
	 */
	public class PNJ extends Personnage 
	{
		private var				_mr:int;
		private var				_mToDefine:Boolean;
		private static const	MAXM:int = 250;
		private static const	MPROB:int = 200;
		
		public function PNJ(window:Sprite) 
		{
			super(window);
			_mr = 0;
			_mToDefine = false;
		}
		
		public function chooseRandomMove():void
		{
			var r:int = (Math.random() * 1000) % 8;
			
			switch (r)
			{
				case 0:
					_up = true;
					break;
				case 1:
					_up = true;
					_right = true;
					break;
				case 2:
					_right = true;
					break;
				case 3:
					_right = true;
					_down = true;
					break;
				case 4:
					_down = true;
					break;
				case 5:
					_down = true;
					_left = true;
					break;
				case 6:
					_left = true;
					break;
				case 7:
					_left = true;
					_up = true;
					break;
			}
		}
		
		override public function move():void
		{
			var	r:int = (Math.random() * 1000) % MPROB;
			
			if (_mr <= 0 && r == 42)
			{
				_mr = (Math.random() * 1000) % MAXM + 1;
				_mToDefine = true;
			}
			if (_mr > 0)
			{
				if (_mToDefine)
				{
					chooseRandomMove();
					_mToDefine = false;
				}
				--_mr;
			}
			
			super.move();
			
			if (_mr == 0 && isMoving())
				resetMoves();
		}
	}

}