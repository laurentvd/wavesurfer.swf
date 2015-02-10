package fm.wavesurfer.waves {
	import fm.wavesurfer.jsapi.InitOptions;
	import fm.wavesurfer.audio.Player;
	import fm.wavesurfer.audio.AudioData;

	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author laurent
	 */
	public class Waves extends Sprite {
		
		private var canvas : WaveCanvas;
		private var cursor : Cursor;
		private var player : Player;
		
		private var waveData : Vector.<Point>;
		private var options : InitOptions;

		/**
		 * 
		 */
		public function Waves(player : Player) {
			this.player = player;
			
			setupVisuals();
		}

		/**
		 * 
		 */
		private function setupVisuals() : void {
			canvas = new WaveCanvas();
			cursor = new Cursor();
			addChild(canvas);
			addChild(cursor);
		}

		/**
		 * 
		 */
		public function setup(audio : AudioData, options : InitOptions) : void {
			
			var pixelsPerSecond : int = Math.ceil(options.width / (audio.getSound().length / 1000));
			waveData = audio.asWaveData(pixelsPerSecond);
			this.options = options;
			
			drawWaves(waveData, options);
			drawCursor(pixelsPerSecond, options);
		}

		/**
		 * 
		 */
		public function update(progress : Number) : void {
//			cursor.setTime(this.channel.position);
		}

		/**
		 * 
		 */
		private function drawCursor(pixelsPerSecond : int, options : InitOptions, time : int = 0) : void {
			cursor.draw(options.cursorColor, pixelsPerSecond, options.height);
		}

		/**
		 * 
		 */
		private function drawWaves(data : Vector.<Point>, options : InitOptions, progress : int = 0) : void {
			canvas.draw(data, options.waveColor, options.waveProgressColor, options.height / 2, progress);
		}
	}
}
