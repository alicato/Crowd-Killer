package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.Font;
	
	/**
	 * ...
	 * @author Jito
	 */
	public class CustomText extends TextField 
	{
		[Embed(source="/../bin/Impact.ttf", fontName = "ImpactFont", mimeType = "application/x-font", advancedAntiAliasing="true", embedAsCFF="false")]
		private var impactFont:Class;
		
		static private const COLORMODIF:Number = 0.8;
		
		public function CustomText(str:String = "default", font:String = "Verdana", size:int = 20, color:uint = 0, bold:Boolean = false, mouseEffect:Boolean=true)
		{
			super();
			this.defaultTextFormat = new TextFormat(font, size, color, bold);
			this.text = str;
			if (font == "ImpactFont")
				this.embedFonts = true;
			this.selectable = false;
			this.autoSize = "left";
			this.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			if (mouseEffect)
				this.addEventListener(MouseEvent.MOUSE_OVER, brighten);
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