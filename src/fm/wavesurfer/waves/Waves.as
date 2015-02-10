package fm.wavesurfer.waves {
	import flash.display.Shape;
	import fm.wavesurfer.audio.AudioData;
	import fm.wavesurfer.audio.Player;
	import fm.wavesurfer.audio.events.LoadedEvent;
	import fm.wavesurfer.audio.events.ProgressEvent;
	import fm.wavesurfer.jsapi.InitOptions;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author laurent
	 */
	public class Waves extends Sprite {
		
		private var wave : WaveCanvas;
		private var progressWave : WaveCanvas;
		private var progressWaveMask : Shape;
		private var cursor : Cursor;
		private var player : Player;
		private var background : Background;
		
		private var waveData : Vector.<Point>;
		private var options : InitOptions;
		
		private var waveWidth : int;
		private var waveHeight : int;
		private var pixelsPerSecond : int;

		/**
		 * 
		 */
		public function Waves(player : Player) {
			this.player = player;
			this.player.addEventListener(LoadedEvent.TYPE, onAudioLoaded);
			this.player.addEventListener(ProgressEvent.TYPE, onProgress);

			setupVisuals();
		}

		/**
		 * 
		 */
		private function setupVisuals() : void {
			wave = new WaveCanvas();
			progressWave = new WaveCanvas();
			cursor = new Cursor();
			background = new Background();
			progressWaveMask = new Shape();
			
			addChild(background);
			addChild(wave);
			addChild(progressWave);
			addChild(progressWaveMask);
			addChild(cursor);
		}

		/**
		 * 
		 */
		public function setup(options : InitOptions) : void {
			
			waveWidth = stage.stageWidth;
			waveHeight = stage.stageHeight;
			stage.addEventListener(MouseEvent.CLICK, onStageClicked);
			
			this.options = options;
			
			background.draw(options.backgroundColor);
		}
		
		/**
		 * 
		 */
		public function loadAudio(audio : AudioData) : void {
			pixelsPerSecond = Math.ceil(waveWidth / (audio.getSound().length / 1000));
			waveData = audio.asWaveData(pixelsPerSecond);
			
			// Draw the mask using the wave data count as the width. Every item is a pixel.
			drawMask(waveData.length, waveHeight);
			
			wave.draw(waveData, options.waveColor, waveHeight);
			progressWave.draw(waveData, options.waveProgressColor, waveHeight);
			progressWave.mask = progressWaveMask;
			
			update(0);
		}

		/**
		 * 
		 */
		public function update(time : Number = 0) : void {
			progressWaveMask.width = time * pixelsPerSecond;
			cursor.draw(options.cursorColor, waveHeight, pixelsPerSecond, time);
		}
		
		/**
		 * 
		 */
		private function drawMask(width : Number, height : Number) : void {
			progressWaveMask.graphics.beginFill(0xff00ff);
			progressWaveMask.graphics.drawRect(0, 0, width, height);
			progressWaveMask.graphics.endFill();
		}
		
		/**
		 * 
		 */
		private function onAudioLoaded(event : LoadedEvent) : void {
			loadAudio(event.getAudio());
		}
		
		/**
		 * 
		 */
		private function onStageClicked(event : MouseEvent) : void {
			if (!waveData) {
				return;
			}
			var position : Number = Math.min(event.stageX, waveData.length);
			var percentage : Number = position / waveData.length;
			player.seek(percentage);
		}
		
		/**
		 * 
		 */
		private function onProgress(event : ProgressEvent) : void {
			update(event.getTime());
		}
	}
}
