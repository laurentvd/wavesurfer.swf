package fm.wavesurfer.waves {
	import fm.wavesurfer.audio.events.LoadedEvent;
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
		private var background : Background;
		
		private var waveData : Vector.<Point>;
		private var options : InitOptions;
		
		private var waveWidth : int;
		private var waveHeight : int;

		/**
		 * 
		 */
		public function Waves(player : Player) {
			this.player = player;
			this.player.addEventListener(LoadedEvent.TYPE, onAudioLoaded);

			setupVisuals();
		}

		/**
		 * 
		 */
		private function setupVisuals() : void {
			canvas = new WaveCanvas();
			cursor = new Cursor();
			background = new Background();
			
			addChild(background);
			addChild(canvas);
			addChild(cursor);
		}

		/**
		 * 
		 */
		public function setup(options : InitOptions) : void {
			
			waveWidth = stage.stageWidth;
			waveHeight = stage.stageHeight;
			
			this.options = options;
			
			background.draw(options.backgroundColor);
		}
		
		/**
		 * 
		 */
		public function loadAudio(audio : AudioData) : void {
			var pixelsPerSecond : int = Math.ceil(waveWidth / (audio.getSound().length / 1000));
			waveData = audio.asWaveData(pixelsPerSecond);
			
			trace(waveData.length);
			
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
			cursor.draw(options.cursorColor, pixelsPerSecond, waveHeight);
		}

		/**
		 * 
		 */
		private function drawWaves(data : Vector.<Point>, options : InitOptions, progress : int = 0) : void {
			canvas.draw(data, options.waveColor, options.waveProgressColor, waveHeight, progress);
		}
		
		/**
		 * 
		 */
		private function onAudioLoaded(event : LoadedEvent) : void {
			loadAudio(event.getAudio());
		}
	}
}
