package fm.wavesurfer.waves {
	import flash.display.Sprite;

	/**
	 * @author laurent
	 */
	public class Cursor extends Sprite {

		public function draw(color : uint, pixelsPerSecond : int, height : int, time : Number = 0) : void {
			var pixel : int = Math.floor((time / 1000) * pixelsPerSecond);
			
			graphics.clear();
			graphics.lineStyle(1, color);
			graphics.moveTo(pixel, 0);
			graphics.lineTo(pixel, height);
		}
	}
}
