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
		
		public function GameMenu(base:Sprite) 
		{
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xFF0000, 1);
			border.graphics.drawRect(0, 0, 512, 384);
			border.graphics.endFill();
			base.addChild(border);
			
			var title:TextField = new TextField();
			title.defaultTextFormat = new TextFormat('Verdana',44,0x333300, true);
			title.htmlText = "<u>Crowd Killer</u>";
			title.selectable = false;
			title.autoSize = "left";
			title.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			title.x = base.width / 2 - title.textWidth / 2;
			base.addChild(title);
			
			startButton = new TextField();
			startButton.defaultTextFormat = new TextFormat('Verdana',30,0x333300, true);
			startButton.text = "START";
			startButton.selectable = false;
			startButton.autoSize = "left";
			startButton.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			startButton.x = base.width / 2 - startButton.textWidth / 2;
			startButton.y = base.height / 2 - startButton.textHeight / 2;
			base.addChild(startButton);
			base.getChildAt(base.numChildren - 1).addEventListener(MouseEvent.MOUSE_OVER, brighten);
		}
		
		private function brighten (e:MouseEvent):void
		{
			startButton.removeEventListener(MouseEvent.MOUSE_OVER, brighten);
			this.startButton.setTextFormat(new TextFormat('Verdana', 30, 0x888800, true));
			startButton.addEventListener(MouseEvent.MOUSE_OUT, darken);
		}
		
		private function darken (e:MouseEvent):void
		{
			startButton.removeEventListener(MouseEvent.MOUSE_OUT, darken);
			this.startButton.setTextFormat(new TextFormat('Verdana', 30, 0x333300, true));
			startButton.addEventListener(MouseEvent.MOUSE_OVER, brighten);
		}
	}
	
}