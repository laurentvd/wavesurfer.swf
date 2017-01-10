package fm.wavesurfer.audio {
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.ByteArray;

	/**
	 * @author laurent
	 */
	public class AudioData {
		/**
		 * Whatever the actual sample rate of the mp3, flash will always convert it to 44.1Khz
		 */
		public static const SAMPLE_RATE : int = 44100;
		private var sound : Sound;
		private var byteArray : ByteArray;

		public function AudioData(sound : Sound, prerendered : Array = null) {
			this.sound = sound;

			this.byteArray = prerendered ? this.generateBytesFromPrerenderedData(prerendered) : this.extractByteArrayFromSound();
		}

		private function generateBytesFromPrerenderedData(prerendered : Array) : ByteArray {
			var totalBytes : uint = sound.length / 1000 * SAMPLE_RATE;
			var bytesPerStep : uint = totalBytes / prerendered.length;

			var byteArray : ByteArray = new ByteArray();
			var value : Number = 0;
			for (var i : uint = 0; i < totalBytes; i++) {
				value = prerendered[Math.floor(i / bytesPerStep)];

				// Write the same value to the left channel
				byteArray.writeFloat(value);
				byteArray.writeFloat(value);
			}

			byteArray.position = 0;

			return byteArray;
		}

		private function extractByteArrayFromSound() : ByteArray {
			var bytes : ByteArray = new ByteArray();
			sound.extract(bytes, Math.floor((sound.length / 1000) * SAMPLE_RATE));
			bytes.position = 0;

			return bytes;
		}

		public function asWaveData(samplesPerSecond : int) : Vector.<Point> {
			var bytesPerRead : int = SAMPLE_RATE / samplesPerSecond * 8;
			var xPos : uint = 0;
			var leftMax : Number;
			var rightMax : Number;

			var wavePoints : Vector.<Point> = new Vector.<Point>();

			// Find the max values for both channels
			while (byteArray.bytesAvailable > bytesPerRead) {
				leftMax = Number.MIN_VALUE;
				rightMax = Number.MIN_VALUE;

				for (var i : uint = 0; i < bytesPerRead / 8; i++) {
					// Read the next 4 bytes to get the left channel
					var leftChannel : Number = byteArray.readFloat();
					// Read the next 4 bytes to get the right channel
					var rightChannel : Number = byteArray.readFloat();

					// check if we have a new minumum or maximum values for the left or right channels
					leftMax = Math.max(leftMax, leftChannel);
					rightMax = Math.max(rightMax, rightChannel);
				}

				wavePoints.push(new Point(leftMax, rightMax));
				xPos++;
			}

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
