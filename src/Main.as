package
{
	import flash.display.ActionScriptVersion;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;
	import Player;
	
	/**
	 * ...
	 * @author Jito
	 */
	[SWF(width="512", height="384", frameRate='60')]
	public class Main extends Sprite 
	{
		private var _p1:Player;
		private var _p2:Player;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.color = 0x808080; //background color
			for (var i:int = 0; i < 30; ++i)
			{
				var test:Personnage = new Personnage();
				test.displayPers(this);
			}
			_p1 = new Player();
			_p1.displayPers(this);
			_p2 = new Player(false);
			_p2.displayPers(this);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyboardUp);
			stage.addEventListener(Event.ENTER_FRAME, evtStageEnterFrame);
		}
		
		private function onKeyboardDown(event:KeyboardEvent):void
		{
			switch(event) {
				default:
				_p1.updateMoveDown(event);
				_p2.updateMoveDown(event);
			}
		}
		
		private function onKeyboardUp(event:KeyboardEvent):void
		{
			_p1.updateMoveUp(event);
			_p2.updateMoveUp(event);
		}
		
		private function evtStageEnterFrame(ev:Event):void
		{
			_p1.move();
			_p2.move();
		}
	}
	
}