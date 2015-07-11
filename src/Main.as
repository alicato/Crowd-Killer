package
{
	import flash.display.ActionScriptVersion;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display3D.textures.RectangleTexture;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
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
		public  var	rs:int = 2;
		private var _crowd:Vector.<DisplayObject>;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//stage.color = 0x808080;
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xFF0000, 0.5);
			border.graphics.drawRect(2, 0, stage.stageWidth-2, 2);
			border.graphics.drawRect(stage.stageWidth-2, 2, 2, stage.stageHeight-2);
			border.graphics.drawRect(0, stage.stageHeight-2, stage.stageWidth-2, 2);
			border.graphics.drawRect(0, 0, 2, stage.stageHeight-2);
			border.graphics.endFill();
			addChild(border);
			game();
		}
		
		private function game():void
		{
			for (var i:int = 0; i < 30; ++i)
			{
				var test:Personnage = new Personnage(this);
			}
			_p1 = new Player(this);
			_p2 = new Player(this, false);
			
			_crowd = new Vector.<DisplayObject>();
			for (i = 0; i < this.numChildren; i++)
				if (this.getChildAt(i) is DisplayObject)
					_crowd.push(this.getChildAt(i));
				
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
			_crowd.sort(sorty);
			
			if (_p1.img.rotation >= 9 || _p1.img.rotation <= -9)
				rs = -rs;
			
			_p1.img.rotation += rs;
			
			for (var i:int = 0; i < this.numChildren; i++ )
			{
				this.setChildIndex(_crowd[i], i);
			}
		}
		
		private function sorty(a:DisplayObject, b:DisplayObject):int
		{
			if (a.y > b.y) return 1;
			if (a.y < b.y) return -1;
			return 0;
		}
	}
	
}