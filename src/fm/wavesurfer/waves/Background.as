package fm.wavesurfer.waves {
	import flash.display.Shape;

	/**
	 * @author laurent
	 */
	public class Background extends Shape {
		public function Background() {
		}
		
		public function draw(color : uint) : void {
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
		}
	}
}
