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
		
		public function AudioData(sound : Sound) {
			this.sound = sound;
		}
		
		public function asByteArray() : ByteArray {
			var data : ByteArray = new ByteArray();
			sound.extract(data, Math.floor((sound.length / 1000) * SAMPLE_RATE));
			data.position = 0;
			return data;
		}
		
		public function asWaveData(pixelsPerSecond : int) : Vector.<Point> {
					
			var bytesPerRead : int = SAMPLE_RATE / pixelsPerSecond * 8;
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
		
			return wavePoints; 
		}
	
		public function getSound() : Sound {
			return sound;		
		}
	}
}
