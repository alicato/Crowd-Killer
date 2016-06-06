package 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.KeyboardEvent;
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @author Jito
	 */
	public class GameMenu extends Sprite
	{
		public var startButton:CustomText;
		private static var main:Main;
		private var actualButton:String;
		private	var	_rs:Number = 1.5;
		private var _crowdDisplay:Vector.<DisplayObject>;
		private var _crowdObject:Vector.<Personnage>;
		
		public function GameMenu(base:Main) 
		{
			GameMenu.main = base;
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xd68947, 1);
			border.graphics.drawRect(0, 0, 512, 384);
			border.graphics.endFill();
			base.addChild(border);
			
			
			_crowdObject = new Vector.<Personnage>();
			for (var i:int = 0; i < 10; ++i)
			{
				var tmp:PNJ = new PNJ(base);
				_crowdObject.push(tmp);
			}
			
			_crowdDisplay = new Vector.<DisplayObject>();
			for (i = 1; i < this.numChildren; i++)
				if (this.getChildAt(i) is DisplayObject)
					_crowdDisplay.push(this.getChildAt(i));
			
			var title:CustomText = new CustomText("Crowd Killer", 'Papyrus',44,0x890000, true, false);
			title.x = base.width / 2 - title.textWidth / 2;
			base.addChild(title);
			
			startButton = new CustomText("START GAME", 'ImpactFont', 30, 0xc52d2d);
			startButton.x = base.width / 2 - startButton.textWidth / 2;
			startButton.y = base.height / 2 - startButton.textHeight - 5;
			startButton.border = true;
			startButton.borderColor = 0x955f31;
			base.addChild(startButton);
			
			var configButton:CustomText = new CustomText("OPTIONS", 'ImpactFont',30,0xc52d2d);
			configButton.x = base.width / 2 - configButton.textWidth / 2;
			configButton.y = base.height / 2 + 5;
			configButton.border = true;
			configButton.borderColor = 0x955f31;
			base.addChild(configButton);
			
			configButton.addEventListener(MouseEvent.CLICK, config);
			
			base.addEventListener(Event.ENTER_FRAME, evtStageEnterFrame);
		}
		
		private function evtStageEnterFrame(ev:Event):void
		{
			_crowdDisplay.sort(main.sorty);
			
			for (var i:int = 0; i < _crowdDisplay.length; i++)
			{
				this.setChildIndex(_crowdDisplay[i], i);
			}
			
			var invert:Boolean = false;
			
			for (var n:int = 0; n < _crowdObject.length; ++n)
			{
				if (!invert && (_crowdObject[n].img.rotation >= Main.RANGLEMAX || _crowdObject[n].img.rotation <= -Main.RANGLEMAX))
				{
					invert = true;
					_rs = -_rs;
				}
				_crowdObject[n].move();						// Déplacement des personnages
				_crowdObject[n].img.rotation += _rs;		// Légère animation des personnages
			}
		}
		
		private function config(e:MouseEvent):void
		{
			GameMenu.main.removeChildren();
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xd68947, 1);
			border.graphics.drawRect(0, 0, 512, 384);
			border.graphics.endFill();
			GameMenu.main.addChild(border);
			
			var config:CustomText = new CustomText("Configuration", "ImpactFont",44,0x890000, true, false);
			config.x = GameMenu.main.stage.width / 2 - config.textWidth / 2;
			GameMenu.main.addChild(config);
			
			var back:CustomText = new CustomText("Back to menu", 'Verdana', 20, 0x303030, true);
			back.x = GameMenu.main.stage.width / 2 - back.textWidth / 2;
			back.y = GameMenu.main.stage.height - back.textHeight - 5;
			back.name = "Back";
			GameMenu.main.addChild(back);
			back.addEventListener(MouseEvent.CLICK, init);
			
			var p1config:CustomText = new CustomText("Player 1", "ImpactFont", 30, 0xc52d2d, true);
			p1config.x = GameMenu.main.stage.width / 2 - p1config.textWidth / 2;
			p1config.y = GameMenu.main.stage.height / 2 - p1config.textHeight - 50;
			GameMenu.main.addChild(p1config);
			p1config.addEventListener(MouseEvent.CLICK, configmenu);
			
			var p2config:CustomText = new CustomText("Player 2", 'ImpactFont',30,0xc52d2d, true);
			p2config.x = GameMenu.main.stage.width / 2 - p2config.textWidth / 2;
			p2config.y = p1config.y + p1config.textHeight + 15;
			GameMenu.main.addChild(p2config);
			p2config.addEventListener(MouseEvent.CLICK, configmenu);
			
			var gameOpt:CustomText = new CustomText("Game Options", 'ImpactFont', 30 , 0xc52d2d, true);
			gameOpt.x = GameMenu.main.stage.width / 2 - gameOpt.textWidth / 2;
			gameOpt.y = p2config.y + p2config.textHeight + 15;
			GameMenu.main.addChild(gameOpt);
			gameOpt.addEventListener(MouseEvent.CLICK, configmenu);
		}
		
		private function configmenu(e:MouseEvent):void
		{
			GameMenu.main.removeChildAt(GameMenu.main.numChildren - 1);
			GameMenu.main.removeChildAt(GameMenu.main.numChildren - 1);
			GameMenu.main.removeChildAt(GameMenu.main.numChildren - 1);
			if (e.target.text == "Player 1" || e.target.text == "Player 2")
			{
				var player:String = e.target.text.substr(0, 1) + e.target.text.substr(e.target.text.length - 1, 1);
				
				var pup:CustomText = new CustomText("Up", 'ImpactFont', 30 , 0xc52d2d, true);
				pup.x = GameMenu.main.stage.width / 2 - pup.textWidth / 2;
				pup.y = 80;
				pup.name = player + "UP";
				GameMenu.main.addChild(pup);
				pup.addEventListener(MouseEvent.CLICK, configButton);
				
				var pdown:CustomText = new CustomText("Down", 'ImpactFont', 30 , 0xc52d2d, true);
				pdown.x = GameMenu.main.stage.width / 2 - pdown.textWidth / 2;
				pdown.y = pup.y + pup.textHeight + 10;
				pdown.name = player + "DOWN";
				GameMenu.main.addChild(pdown);
				pdown.addEventListener(MouseEvent.CLICK, configButton);
				
				var pleft:CustomText = new CustomText("Left", 'ImpactFont', 30 , 0xc52d2d, true);
				pleft.x = GameMenu.main.stage.width / 2 - pleft.textWidth / 2;
				pleft.y = pdown.y + pdown.textHeight + 10;
				pleft.name = player + "LEFT";
				GameMenu.main.addChild(pleft);
				pleft.addEventListener(MouseEvent.CLICK, configButton);
				
				var pright:CustomText = new CustomText("Right", 'ImpactFont', 30 , 0xc52d2d, true);
				pright.x = GameMenu.main.stage.width / 2 - pright.textWidth / 2;
				pright.y = pleft.y + pleft.textHeight + 10;
				pright.name = player + "RIGHT";
				GameMenu.main.addChild(pright);
				pright.addEventListener(MouseEvent.CLICK, configButton);
				
				var patk:CustomText = new CustomText("Attack", 'ImpactFont', 30 , 0xc52d2d, true);
				patk.x = GameMenu.main.stage.width / 2 - patk.textWidth / 2;
				patk.y = pright.y + pright.textHeight + 10;
				patk.name = player + "ATK";
				GameMenu.main.addChild(patk);
				patk.addEventListener(MouseEvent.CLICK, configButton);
				
				var change:CustomText = new CustomText("Default", 'ImpactFont', 30 , 0xc52d2d, true, false);
				change.x = GameMenu.main.stage.width / 2 - change.textWidth / 2;
				change.y = GameMenu.main.stage.height / 2 - change.textHeight / 2;
				change.name = "Change";
				change.visible = false;
				GameMenu.main.addChild(change);
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
			GameMenu.main.getChildByName(str + "UP").visible = false;
			GameMenu.main.getChildByName(str + "DOWN").visible = false;
			GameMenu.main.getChildByName(str + "LEFT").visible = false;
			GameMenu.main.getChildByName(str + "RIGHT").visible = false;
			GameMenu.main.getChildByName(str + "ATK").visible = false;
			GameMenu.main.getChildByName("Back").visible = false;
			var change:CustomText = CustomText(GameMenu.main.getChildByName("Change"));
			change.visible = true;
			change.text = "Press Any Key to\rReplace " + actualButton;
			change.x = GameMenu.main.stage.width / 2 - change.textWidth / 2;
			change.y = GameMenu.main.stage.height / 2 - change.textHeight / 2;
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN, changeKey);
		}
		
		private function changeKey(e:KeyboardEvent):void
		{
			main.stage.removeEventListener(KeyboardEvent.KEY_DOWN, changeKey);
			GameMenu.main.getChildByName("Change").visible = false;
			var str:String = this.actualButton.substr(0, 2);
			GameMenu.main.getChildByName(str + "UP").visible = true;
			GameMenu.main.getChildByName(str + "DOWN").visible = true;
			GameMenu.main.getChildByName(str + "LEFT").visible = true;
			GameMenu.main.getChildByName(str + "RIGHT").visible = true;
			GameMenu.main.getChildByName(str + "ATK").visible = true;
			GameMenu.main.getChildByName("Back").visible = true;
			Player[actualButton] = e.keyCode;
		}
		
		public function endgame(p1:Boolean):void
		{
			main.removeListeners();
			var str:String = (p1) ? "Player 2 wins !" : "Player 1 wins !";
			
			var endscr:CustomText = new CustomText(str, 'ImpactFont', 44 , 0x453033, true, false);
			endscr.x = GameMenu.main.stage.width / 2 - endscr.textWidth / 2;
			endscr.y = GameMenu.main.stage.height / 2 - endscr.textHeight * 2;
			endscr.name = "EndMsg";
			GameMenu.main.addChild(endscr);
			
			var back:CustomText = new CustomText("Return to menu", 'ImpactFont', 30 , 0x453033, true);
			back.x = GameMenu.main.stage.width / 2 - back.textWidth / 2;
			back.y = GameMenu.main.stage.height / 2 + endscr.textHeight / 2 + 50;
			back.name = "EndBack";
			GameMenu.main.addChild(back);
			back.addEventListener(MouseEvent.CLICK, init);
		}
		
		private function init(e:MouseEvent):void
		{
			GameMenu.main.init();
		}
	}
	
}