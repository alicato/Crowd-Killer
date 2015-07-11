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
		private	var	_rs:Number = 1.5;
		private var _crowdDisplay:Vector.<DisplayObject>;
		private var _crowdObject:Vector.<Personnage>;
		private var title:GameMenu;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			title = new GameMenu(this);
			
			title.startButton.addEventListener(MouseEvent.CLICK, game);
		}
		
		private function game(e:MouseEvent):void
		{
			this.removeChildren();
			
			var background:Shape = new Shape();
			
			background.graphics.beginFill(0xd68947, 1);
			background.graphics.drawRect(0, 0, 512, 384);
			background.graphics.endFill();
			this.addChild(background);
			
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0x404040, 1);
			border.graphics.drawRect(GameEntity.BORDERSIZE, 0, stage.stageWidth - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE);
			border.graphics.drawRect(stage.stageWidth - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE, GameEntity.BORDERSIZE, stage.stageHeight - GameEntity.BORDERSIZE);
			border.graphics.drawRect(0, stage.stageHeight - GameEntity.BORDERSIZE, stage.stageWidth - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE);
			border.graphics.drawRect(0, 0, GameEntity.BORDERSIZE, stage.stageHeight - GameEntity.BORDERSIZE);
			border.graphics.endFill();
			addChild(border);
			
			_crowdObject = new Vector.<Personnage>();
			for (var i:int = 0; i < 30; ++i)
			{
				var tmp:PNJ = new PNJ(this);
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
			_crowdDisplay.sort(sorty);
			
			if (_p1.img.rotation >= 8 || _p1.img.rotation <= -8)
				_rs = -_rs;
			for (var i:int = 2; i < this.numChildren; i++)
			{ //USELESS FOR NOW
				this.setChildIndex(_crowdDisplay[i], i);
			}
			for (var n:int = 0; n < _crowdObject.length; ++n)
			{
				_crowdObject[n].move();
				_crowdObject[n].img.rotation += _rs;
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