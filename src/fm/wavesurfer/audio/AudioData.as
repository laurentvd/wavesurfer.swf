package fm.wavesurfer.audio {
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import flash.media.Sound;
	/**
	 * @author laurent
	 */
	public class AudioData {
		
		public static const SAMPLE_RATE : int = 44100;
		private var sound : Sound;
		private var cachedWaveData : Array;
		
		public function AudioData(sound : Sound) {
			this.sound = sound;
			this.cachedWaveData = new Array();
		}
		
		public function asByteArray() : ByteArray {
			var data : ByteArray = new ByteArray();
			sound.extract(data, Math.floor((sound.length / 1000) * SAMPLE_RATE));
			data.position = 0;
			return data;
		}
		
		public function asWaveData(samplesPerSecond : int) : Vector.<Point> {
			
			if (cachedWaveData[samplesPerSecond]) {
				return cachedWaveData[samplesPerSecond];
			}
					
			var bytesPerRead : int = SAMPLE_RATE / samplesPerSecond * 8;
			var xPos : uint = 0;
			var leftMax : Number;
			var rightMax : Number;
			
			var wavePoints : Vector.<Point> = new Vector.<Point>();
			var bytes : ByteArray = asByteArray();
			
			// Find the max values for both channels
			while (bytes.bytesAvailable > bytesPerRead) {
				leftMax = Number.MIN_VALUE;
				rightMax = Number.MIN_VALUE;
				
				for (var i : uint = 0; i < bytesPerRead / 8; i++)
				{
					// Read the next 4 bytes to get the left channel
					var leftChannel : Number = bytes.readFloat();
					// Read the next 4 bytes to get the right channel
					var rightChannel : Number = bytes.readFloat();

					// check if we have a new minumum or maximum values for the left or right channels
					leftMax = Math.max(leftMax, leftChannel);
					rightMax = Math.max(rightMax, rightChannel);
				}
				
				wavePoints.push(new Point(leftMax, rightMax));
				xPos++;
			}
		
			// Cache for later use 
			cachedWaveData[samplesPerSecond] = wavePoints;
			return wavePoints; 
		}
		
		/**
		 * The wave data is converted to mono to work with wavesurfer.js' exportPCM
		 */
		public function asSimplifiedWaveData(samplesPerSecond : int) : Array {
			var samples : Vector.<Point> = asWaveData(samplesPerSecond);
			var simplifiedSamples : Array = new Array();
			for each (var sample : Point in samples) {
				simplifiedSamples.push(Math.max(sample.x, sample.y));
			}
			return simplifiedSamples;
		}
	
		public function getSound() : Sound {
			return sound;		
		}
	}
}
