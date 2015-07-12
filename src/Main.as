package
{
	import flash.display.ActionScriptVersion;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.*;
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
		private var actualButton:String;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyboardUp);
			stage.removeEventListener(Event.ENTER_FRAME, evtStageEnterFrame);
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
			switch(event.keyCode) {
				case (Keyboard.ESCAPE):
					init();
					break;
				default:
					_p1.updateMoveDown(event);
					_p2.updateMoveDown(event);
					break;
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
			for (var i:int = 2; i < _crowdDisplay.length; i++)
			{ //USELESS FOR NOW
				this.setChildIndex(_crowdDisplay[i], i);
			}
			for (var n:int = 0; n < _crowdObject.length; ++n)
			{
				_crowdObject[n].move();
				_crowdObject[n].moveShuriken();
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
			
			var config:CustomText = new CustomText("Configuration", "ImpactFont",44,0x890000, true, false);
			config.x = stage.width / 2 - config.textWidth / 2;
			this.addChild(config);
			
			var back:CustomText = new CustomText("Back to menu", 'Verdana', 20, 0x303030, true);
			back.x = stage.width / 2 - back.textWidth / 2;
			back.y = stage.height - back.textHeight - 5;
			back.name = "Back";
			this.addChild(back);
			back.addEventListener(MouseEvent.CLICK, init);
			
			var p1config:CustomText = new CustomText("Player 1", "ImpactFont", 30, 0xc52d2d, true);
			p1config.x = stage.width / 2 - p1config.textWidth / 2;
			p1config.y = stage.height / 2 - p1config.textHeight - 50;
			this.addChild(p1config);
			p1config.addEventListener(MouseEvent.CLICK, configmenu);
			
			var p2config:CustomText = new CustomText("Player 2", 'ImpactFont',30,0xc52d2d, true);
			p2config.x = stage.width / 2 - p2config.textWidth / 2;
			p2config.y = p1config.y + p1config.textHeight + 15;
			this.addChild(p2config);
			p2config.addEventListener(MouseEvent.CLICK, configmenu);
			
			var gameOpt:CustomText = new CustomText("Game Options", 'ImpactFont', 30 , 0xc52d2d, true);
			gameOpt.x = stage.width / 2 - gameOpt.textWidth / 2;
			gameOpt.y = p2config.y + p2config.textHeight + 15;
			this.addChild(gameOpt);
			gameOpt.addEventListener(MouseEvent.CLICK, configmenu);
		}
		
		private function configmenu(e:MouseEvent):void
		{
			this.removeChildAt(this.numChildren - 1);
			this.removeChildAt(this.numChildren - 1);
			this.removeChildAt(this.numChildren - 1);
			if (e.target.text == "Player 1" || e.target.text == "Player 2")
			{
				var player:String = e.target.text.substr(0, 1) + e.target.text.substr(e.target.text.length - 1, 1);
				
				var pup:CustomText = new CustomText("Up", 'ImpactFont', 30 , 0xc52d2d, true);
				pup.x = stage.width / 2 - pup.textWidth / 2;
				pup.y = 80;
				pup.name = player + "UP";
				this.addChild(pup);
				pup.addEventListener(MouseEvent.CLICK, configButton);
				
				var pdown:CustomText = new CustomText("Down", 'ImpactFont', 30 , 0xc52d2d, true);
				pdown.x = stage.width / 2 - pdown.textWidth / 2;
				pdown.y = pup.y + pup.textHeight + 10;
				pdown.name = player + "DOWN";
				this.addChild(pdown);
				pdown.addEventListener(MouseEvent.CLICK, configButton);
				
				var pleft:CustomText = new CustomText("Left", 'ImpactFont', 30 , 0xc52d2d, true);
				pleft.x = stage.width / 2 - pleft.textWidth / 2;
				pleft.y = pdown.y + pdown.textHeight + 10;
				pleft.name = player + "LEFT";
				this.addChild(pleft);
				pleft.addEventListener(MouseEvent.CLICK, configButton);
				
				var pright:CustomText = new CustomText("Right", 'ImpactFont', 30 , 0xc52d2d, true);
				pright.x = stage.width / 2 - pright.textWidth / 2;
				pright.y = pleft.y + pleft.textHeight + 10;
				pright.name = player + "RIGHT";
				this.addChild(pright);
				pright.addEventListener(MouseEvent.CLICK, configButton);
				
				var patk:CustomText = new CustomText("Attack", 'ImpactFont', 30 , 0xc52d2d, true);
				patk.x = stage.width / 2 - patk.textWidth / 2;
				patk.y = pright.y + pright.textHeight + 10;
				patk.name = player + "ATK";
				this.addChild(patk);
				patk.addEventListener(MouseEvent.CLICK, configButton);
				
				var change:CustomText = new CustomText("Default", 'ImpactFont', 30 , 0xc52d2d, true, false);
				change.x = stage.width / 2 - change.textWidth / 2;
				change.y = stage.height / 2 - change.textHeight / 2;
				change.name = "Change";
				change.visible = false;
				this.addChild(change);
			}
			else
			{
				trace("gameoptions");
			}
		}
		
		private function configButton(e:MouseEvent):void
		{
			this.actualButton = e.target.name;
			var str:String = e.target.name.substr(0, 2);
			this.getChildByName(str + "UP").visible = false;
			this.getChildByName(str + "DOWN").visible = false;
			this.getChildByName(str + "LEFT").visible = false;
			this.getChildByName(str + "RIGHT").visible = false;
			this.getChildByName(str + "ATK").visible = false;
			this.getChildByName("Back").visible = false;
			var change:CustomText = CustomText(this.getChildByName("Change"));
			change.visible = true;
			change.text = "Press Any Key to\rReplace " + actualButton;
			change.x = stage.width / 2 - change.textWidth / 2;
			change.y = stage.height / 2 - change.textHeight / 2;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, changeKey);
		}
		
		private function changeKey(e:KeyboardEvent):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, changeKey);
			this.getChildByName("Change").visible = false;
			var str:String = this.actualButton.substr(0, 2);
			this.getChildByName(str + "UP").visible = true;
			this.getChildByName(str + "DOWN").visible = true;
			this.getChildByName(str + "LEFT").visible = true;
			this.getChildByName(str + "RIGHT").visible = true;
			this.getChildByName(str + "ATK").visible = true;
			this.getChildByName("Back").visible = true;
			Player[actualButton] = e.keyCode;
		}
	}
	
}