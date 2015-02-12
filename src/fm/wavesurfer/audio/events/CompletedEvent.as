package fm.wavesurfer.audio.events {
	
	import flash.events.Event;
	
	/**
	 * @author laurent
	 */
	public class CompletedEvent extends Event {
		
		public static const TYPE : String = 'fm.wavesurfer.audio.events.CompletedEvent';

		public function CompletedEvent() {
			super(TYPE);
		}
	}
}
