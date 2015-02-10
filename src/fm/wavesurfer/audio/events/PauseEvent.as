package fm.wavesurfer.audio.events {
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class PauseEvent extends Event {
		public static const TYPE : String = 'fm.wavesurfer.audio.events.PauseEvent';

		public function PauseEvent() {
			super(TYPE);
		}
	}
}
