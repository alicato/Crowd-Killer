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
	import flash.events.MouseEvent;
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
		private	var	_rs:int = 1;
		private var _crowdDisplay:Vector.<DisplayObject>;
		private var _crowdObject:Vector.<Personnage>;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
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
			_crowdObject = new Vector.<DisplayObject>();
			for (var i:int = 0; i < 30; ++i)
			{
				var tmp:Personnage = new Personnage(this);
				_crowdObject.push(tmp);
			}
			_p1 = new Player(this);
			_p2 = new Player(this, false);
			_crowdObject.push(_p1);
			_crowdObject.push(_p2);
			
			_crowdDisplay = new Vector.<DisplayObject>();
			for (i = 0; i < this.numChildren; i++)
				if (this.getChildAt(i) is DisplayObject)
					_crowdDisplay.push(this.getChildAt(i));
				
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
			_crowdDisplay.sort(sorty);
			
			if (_p1.img.rotation >= 8 || _p1.img.rotation <= -8)
					_rs = -_rs;
			for (var i:int = 1; i < this.numChildren; i++ )
			{
				this.setChildIndex(_crowdDisplay[i], i);
				_crowdDisplay[i].rotation += _rs;
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