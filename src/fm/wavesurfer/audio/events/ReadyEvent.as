package fm.wavesurfer.audio.events {
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class ReadyEvent extends Event {
		public static const TYPE : String = 'fm.wavesurfer.audio.events.ReadyEvent';

		public function ReadyEvent() {
			super(TYPE);
		}
	}
}
