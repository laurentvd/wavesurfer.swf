package fm.wavesurfer.audio.events {
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class SeekEvent extends Event {
		public static const TYPE : String = 'fm.wavesurfer.audio.events.SeekEvent';
		
		private var time : Number;

		public function SeekEvent(time : Number) {
			super(TYPE);

			this.time = time;
		}

		public function getTime() : Number {
			return time;
		}
	}
}
