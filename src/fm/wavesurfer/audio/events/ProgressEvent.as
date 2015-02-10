package fm.wavesurfer.audio.events {
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class ProgressEvent extends Event {
		public static const TYPE : String = 'fm.wavesurfer.audio.events.ProgressEvent';
		
		private var duration : Number;
		private var time : Number;

		public function ProgressEvent(time : Number, duration : Number) {
			super(TYPE);
			
			this.time = time;
			this.duration = duration;
		}
		
		public function getTime() : Number {
			return time;
		}
		
		public function getDuration() : Number {
			return duration;
		}
	}
}
