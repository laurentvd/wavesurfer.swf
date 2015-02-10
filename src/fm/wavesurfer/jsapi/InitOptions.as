package fm.wavesurfer.jsapi {
	/**
	 * @author laurent
	 */
	public class InitOptions {
		
		public var waveColor : uint = 0x666666;
		
		public var cursorColor : uint = 0xff0000;
		
		public var waveProgressColor : uint = 0x0;
		
		public var backgroundColor : uint = 0xffffff;
		
		public var width : int = 900;
		
		public var height : int = 128;
		
		public static function fromFlashVars(vars : Object) : InitOptions {
			var options : InitOptions = new InitOptions();
			return options;
		}
		
		private static function parseColor(colorString : String) : uint {
			colorString = colorString.replace( /[^0-9A-Fa-f]/g, '');
			var color : uint = parseInt(colorString, 16);
			if (isNaN(color)) {
				return 0x0;
			}
			return color;
		}
	}
}
