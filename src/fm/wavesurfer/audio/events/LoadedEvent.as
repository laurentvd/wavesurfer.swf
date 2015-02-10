package fm.wavesurfer.audio.events {
	import fm.wavesurfer.audio.AudioData;

	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class LoadedEvent extends Event {
		
		public static const TYPE : String = "fm.wavesurfer.audio.events.LoadedEvent";
		
		private var audio : AudioData;

		public function LoadedEvent(audio : AudioData) {
			super(TYPE);

			this.audio = audio;
		}

		public function getAudio() : AudioData {
			return audio;
		}
	}
}
