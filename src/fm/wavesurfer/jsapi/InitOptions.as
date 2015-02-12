package fm.wavesurfer.jsapi {
	/**
	 * @author laurent
	 */
	public class InitOptions {
		
		public var waveColor : uint = 0x999999;
		
		public var cursorColor : uint = 0x333333;
		
		public var progressColor : uint = 0x555555;
		
		public var backgroundColor : uint = 0xffffff;
		
		public var cursorWidth : int = 1;
		
		public static function fromObject(vars : Object) : InitOptions {
			var options : InitOptions = new InitOptions();
			
			options.waveColor = vars['waveColor'] ? parseColor(vars['waveColor']) : options.waveColor;
			options.cursorColor = vars['cursorColor'] ? parseColor(vars['cursorColor']) : options.cursorColor;
			options.progressColor = vars['progressColor'] ? parseColor(vars['progressColor']) : options.progressColor;
			options.backgroundColor = vars['backgroundColor'] ? parseColor(vars['backgroundColor']) : options.backgroundColor;
			options.cursorWidth = vars['cursorWidth'] ? parseColor(vars['cursorWidth']) : options.cursorWidth;
			
			return options;
		}
		
		private static function parseColor(colorString : String) : uint {
			colorString = colorString.replace( /[^0-9A-Fa-f]/g, '');
			if (colorString.length === 3) {
				colorString = '';
				for each (var digit : String in colorString.split('')) {
					colorString += digit + digit;
				}
			}
			var color : uint = parseInt(colorString, 16);
			if (isNaN(color)) {
				return 0x0;
			}
			return color;
		}
	}
}
