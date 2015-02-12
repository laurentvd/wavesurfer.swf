package fm.wavesurfer.waves {
	import flash.display.Sprite;

	/**
	 * @author laurent
	 */
	public class Cursor extends Sprite {

		public function draw(color : uint, width : int, height : int, pixelsPerSecond : int, time : Number = 0) : void {
			var pixel : Number = time * pixelsPerSecond;
			
			graphics.clear();
			graphics.lineStyle(width, color);
			graphics.moveTo(pixel, 0);
			graphics.lineTo(pixel, height);
		}
	}
}
