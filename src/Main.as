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
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import Player;
	
	/**
	 * ...
	 * @author Jito
	 */
	[SWF(width="512", height="384", frameRate='60')]
	public class Main extends Sprite 
	{
		static private const COLORMODIF:Number = 0.8;
		private var _p1:Player;
		private var _p2:Player;
		private	var	_rs:Number = 1.5;
		private var _crowdDisplay:Vector.<DisplayObject>;
		private var _crowdObject:Vector.<Personnage>;
		private var title:GameMenu;
		[Embed(source="/../bin/Impact.ttf", fontName = "ImpactFont", mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")]
		private var impactFont:Class;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.removeChildren();
			title = new GameMenu(this);
			
			title.startButton.addEventListener(MouseEvent.CLICK, game);
			title.configButton.addEventListener(MouseEvent.CLICK, config);
		}
		
		private function game(e:MouseEvent):void
		{
			this.removeChildren();
			
			var p2configground:Shape = new Shape();
			
			p2configground.graphics.beginFill(0xd68947, 1);
			p2configground.graphics.drawRect(0, 0, 512, 384);
			p2configground.graphics.endFill();
			this.addChild(p2configground);
			
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0x404040, 1);
			border.graphics.drawRect(GameEntity.BORDERSIZE, 0, GameEntity.WINDOWWIDTH - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE);
			border.graphics.drawRect(GameEntity.WINDOWWIDTH - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE, GameEntity.BORDERSIZE, GameEntity.WINDOWHEIGHT - GameEntity.BORDERSIZE);
			border.graphics.drawRect(0, GameEntity.WINDOWHEIGHT - GameEntity.BORDERSIZE, GameEntity.WINDOWWIDTH - GameEntity.BORDERSIZE, GameEntity.BORDERSIZE);
			border.graphics.drawRect(0, 0, GameEntity.BORDERSIZE, GameEntity.WINDOWHEIGHT - GameEntity.BORDERSIZE);
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
		
		private function config(e:MouseEvent):void
		{
			this.removeChildren();
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xd68947, 1);
			border.graphics.drawRect(0, 0, 512, 384);
			border.graphics.endFill();
			this.addChild(border);
			
			var config:TextField = new TextField();
			config.defaultTextFormat = new TextFormat("ImpactFont",44,0x890000, true);
			config.text = "Configuration";
			config.selectable = false;
			config.autoSize = "left";
			config.embedFonts = true;
			config.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			config.x = stage.width / 2 - config.textWidth / 2;
			this.addChild(config);
			
			var back:TextField = new TextField();
			back.defaultTextFormat = new TextFormat('Verdana', 20, 0x202020, true);
			back.text = "Back to menu";
			back.selectable = false;
			back.autoSize = "left";
			back.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			back.x = stage.width / 2 - back.textWidth / 2;
			back.y = stage.height - back.textHeight - 5;
			this.addChild(back);
			this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.CLICK, init);
			this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, brighten);
			
			var p1config:TextField = new TextField();
			p1config.defaultTextFormat = new TextFormat('ImpactFont',30,0xc52d2d, true);
			p1config.text = "Player 1";
			p1config.selectable = false;
			p1config.autoSize = "left";
			p1config.embedFonts = true;
			p1config.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			p1config.x = stage.width / 2 - p1config.textWidth / 2;
			p1config.y = stage.height / 2 - p1config.textHeight - 50;
			this.addChild(p1config);
			//this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.CLICK, configmenu);
			this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, brighten);
			
			var p2config:TextField = new TextField();
			p2config.defaultTextFormat = new TextFormat('ImpactFont',30,0xc52d2d, true);
			p2config.text = "Player 2";
			p2config.selectable = false;
			p2config.autoSize = "left";
			p2config.embedFonts = true;
			p2config.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			p2config.x = stage.width / 2 - p2config.textWidth / 2;
			p2config.y = p1config.y + p1config.textHeight + 15;
			this.addChild(p2config);
			//this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.CLICK, configmenu);
			this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, brighten);
			
			var gameOpt:TextField = new TextField();
			gameOpt.defaultTextFormat = new TextFormat('ImpactFont',30,0xc52d2d, true);
			gameOpt.text = "Game Options";
			gameOpt.selectable = false;
			gameOpt.autoSize = "left";
			gameOpt.embedFonts = true;
			gameOpt.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			gameOpt.x = stage.width / 2 - gameOpt.textWidth / 2;
			gameOpt.y = p2config.y + p2config.textHeight + 15;
			this.addChild(gameOpt);
			//this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.CLICK, configmenu);
			this.getChildAt(this.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, brighten);
			
			/*var fonts:Array = Font.enumerateFonts(true);
			for each(var font:Font in fonts)
				trace(font.fontName + ":" + font.fontType);*/
		}
		
		private function configmenu(e:MouseEvent):void
		{
			
		}
		
		public function brighten (e:MouseEvent):void
		{
			e.target.removeEventListener(MouseEvent.MOUSE_OVER, brighten);
			var format:TextFormat = e.target.getTextFormat();
			var red:uint = ((int(format.color) & 0xFF0000) >> 16) / COLORMODIF;
			var green:uint = ((int(format.color) & 0xFF00) >> 8) / COLORMODIF;
			var blue:uint = (int(format.color) & 0xFF) / COLORMODIF;
			format.color = (red << 16) + (green << 8) + blue;
			e.target.setTextFormat(format);
			e.target.addEventListener(MouseEvent.MOUSE_OUT, darken);
		}
		
		public function darken (e:MouseEvent):void
		{
			e.target.removeEventListener(MouseEvent.MOUSE_OUT, darken);
			var format:TextFormat = e.target.getTextFormat();
			var red:uint = ((int(format.color) & 0xFF0000) >> 16) * COLORMODIF;
			var green:uint = ((int(format.color) & 0xFF00) >> 8) * COLORMODIF;
			var blue:uint = (int(format.color) & 0xFF) * COLORMODIF;
			format.color = (red << 16) + (green << 8) + blue;
			e.target.setTextFormat(format);
			e.target.addEventListener(MouseEvent.MOUSE_OVER, brighten);
		}
	}
	
}