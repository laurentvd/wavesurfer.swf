package fm.wavesurfer.waves {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author laurent
	 */
	public class WaveCanvas extends Sprite {
		
		private var left : Shape;
		private var right : Shape;

		/**
		 * 
		 */
		public function WaveCanvas() {
			left = new Shape();
			right = new Shape();

			addChild(left);
			addChild(right);
		}

		/**
		 * 
		 */
		public function draw(wave : Vector.<Point>, color : uint, verticalRange : int) : void {
			cacheAsBitmap = false;
			
			verticalRange = verticalRange / 2;
			
			left.graphics.clear();
			right.graphics.clear();
			left.graphics.lineStyle(1, color);
			right.graphics.lineStyle(1, color);
			left.y = verticalRange; 
			
			var p : Point;
			
			for (var i : int = 0; i < wave.length; i++) {
				
				p = wave[i];

				// Draw lines connecting the minimum and maximum values of the left and right channels
				// to their corresponding sprites.
				left.graphics.moveTo(i, 0);
				right.graphics.moveTo(i, verticalRange);
				left.graphics.lineTo(i, p.x * verticalRange);
				right.graphics.lineTo(i, verticalRange - p.y * verticalRange);	
			}
			
			cacheAsBitmap = true;			
		}
	}
}
