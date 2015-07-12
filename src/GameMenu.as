package 
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Jito
	 */
	public class GameMenu extends Sprite
	{
		public var startButton:TextField;
		public var configButton:TextField;
		
		public function GameMenu(base:Main) 
		{
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xd68947, 1);
			border.graphics.drawRect(0, 0, 512, 384);
			border.graphics.endFill();
			base.addChild(border);
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat('Papyrus',44,0x890000, true);
			title.htmlText = "Crowd Killer";
			title.selectable = false;
			title.autoSize = "left";
			title.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			title.x = base.width / 2 - title.textWidth / 2;
			base.addChild(title);
			
			startButton = new TextField();
			startButton.defaultTextFormat = new TextFormat('ImpactFont',30,0xc52d2d);
			startButton.text = "START";
			startButton.selectable = false;
			startButton.autoSize = "left";
			startButton.embedFonts = true;
			startButton.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			startButton.x = base.width / 2 - startButton.textWidth / 2;
			startButton.y = base.height / 2 - startButton.textHeight - 5;
			base.addChild(startButton);
			base.getChildAt(base.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, base.brighten);
			
			configButton = new TextField();
			configButton.defaultTextFormat = new TextFormat('ImpactFont',30,0xc52d2d);
			configButton.text = "CONFIG";
			configButton.selectable = false;
			configButton.autoSize = "left";
			configButton.embedFonts = true;
			configButton.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			configButton.x = base.width / 2 - configButton.textWidth / 2;
			configButton.y = base.height / 2 + 5;
			base.addChild(configButton);
			base.getChildAt(base.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, base.brighten);
		}
	}
	
}