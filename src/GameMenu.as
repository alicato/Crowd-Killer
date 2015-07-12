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
		public var startButton:CustomText;
		public var configButton:CustomText;
		
		public function GameMenu(base:Main) 
		{
			var border:Shape = new Shape();
			
			border.graphics.beginFill(0xd68947, 1);
			border.graphics.drawRect(0, 0, 512, 384);
			border.graphics.endFill();
			base.addChild(border);
			
			var title:CustomText = new CustomText("Crowd Killer", 'Papyrus',44,0x890000, true, false);
			title.x = base.width / 2 - title.textWidth / 2;
			base.addChild(title);
			
			startButton = new CustomText("START", 'ImpactFont', 30, 0xc52d2d);
			startButton.x = base.width / 2 - startButton.textWidth / 2;
			startButton.y = base.height / 2 - startButton.textHeight - 5;
			base.addChild(startButton);
			
			configButton = new CustomText("CONFIG", 'ImpactFont',30,0xc52d2d);
			configButton.x = base.width / 2 - configButton.textWidth / 2;
			configButton.y = base.height / 2 + 5;
			base.addChild(configButton);
		}
	}
	
}