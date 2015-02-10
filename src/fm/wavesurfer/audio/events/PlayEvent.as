package fm.wavesurfer.audio.events {
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class PlayEvent extends Event {
		public static const TYPE : String = 'fm.wavesurfer.audio.events.PlayEvent';

		public function PlayEvent() {
			super(TYPE);
		}
	}
}
