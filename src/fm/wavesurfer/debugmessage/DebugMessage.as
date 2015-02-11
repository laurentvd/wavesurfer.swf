package fm.wavesurfer.debugmessage {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author laurent
	 */
	public class DebugMessage extends Sprite {
		
		private var textfield : TextField;
		
		public function DebugMessage() {
		}
		
		public function error(message : String) : void {
			getTextField().appendText(message + "\n");
			getTextField().setTextFormat(getTextFormat());
			trace(this, message);
		}
		
		private function getTextField() : TextField {
			if (textfield) {
				return textfield;
			}
			textfield = new TextField();
			textfield.multiline = true;
			textfield.width = stage.stageWidth;
			textfield.height = stage.stageHeight;
			textfield.background = true;
			addChild(textfield);
			return textfield;
		}
		
		private function getTextFormat() : TextFormat {
			var format : TextFormat = new TextFormat();
			format.size = 16;
			format.font = 'Arial';
			return format;
		}
	}
}
