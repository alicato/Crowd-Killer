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
		static private const COLORMODIF:Number = 0.8;
		public var startButton:TextField;
		public var configButton:TextField;
		
		public function GameMenu(base:Sprite) 
		{
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xd68947, 1);
			border.graphics.drawRect(0, 0, 512, 384);
			border.graphics.endFill();
			base.addChild(border);
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat('Verdana',44,0x890000, true);
			title.htmlText = "Crowd Killer";
			title.selectable = false;
			title.autoSize = "left";
			title.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			title.x = base.width / 2 - title.textWidth / 2;
			base.addChild(title);
			
			startButton = new TextField();
			startButton.defaultTextFormat = new TextFormat('Verdana',30,0xc52d2d, true);
			startButton.text = "START";
			startButton.selectable = false;
			startButton.autoSize = "left";
			startButton.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			startButton.x = base.width / 2 - startButton.textWidth / 2;
			startButton.y = base.height / 2 - startButton.textHeight - 5;
			base.addChild(startButton);
			base.getChildAt(base.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, brighten);
			
			configButton = new TextField();
			configButton.defaultTextFormat = new TextFormat('Verdana',30,0xc52d2d, true);
			configButton.text = "CONFIG";
			configButton.selectable = false;
			configButton.autoSize = "left";
			configButton.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			configButton.x = base.width / 2 - configButton.textWidth / 2;
			configButton.y = base.height / 2 + 5;
			base.addChild(configButton);
			base.getChildAt(base.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, brighten);
		}
		
		private function brighten (e:MouseEvent):void
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
		
		private function darken (e:MouseEvent):void
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