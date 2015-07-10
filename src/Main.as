package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 42Ferra
	 */
	[SWF(width=512, height=384, frameRate=60)]
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			for (var i:int = 0; i < 100; ++i)
			{
				var test:Personnage = new Personnage();
				trace(test.posX + " " + test.posY);
				test.displayPers(this);
			}
		}

	}
	
}