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
		public function draw(wave : Vector.<Point>, defaultColor : uint, progressColor : uint, verticalRange : int, progress : int = 0) : void {
			
			left.graphics.lineStyle(1, progressColor);
			right.graphics.lineStyle(1, progressColor);
			
			var p : Point;
			
			for (var i : int = 0; i < wave.length; i++) {
				
				p = wave[i];
				
				if (i === progress) {
					left.graphics.lineStyle(1, defaultColor);
					right.graphics.lineStyle(1, defaultColor);
				}
								
				// draw lines connecting the minimum and maximum values of the left and right channels
				// to their corresponding sprites.
				left.graphics.moveTo(i, 0);
				right.graphics.moveTo(i, verticalRange);
				left.graphics.lineTo(i, p.x * verticalRange);
				right.graphics.lineTo(i, verticalRange - p.y * verticalRange);	
			}			
		}
	}
}
