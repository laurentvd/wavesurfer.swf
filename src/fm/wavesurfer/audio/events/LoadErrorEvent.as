package fm.wavesurfer.audio.events {
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class LoadErrorEvent extends Event {
		public static const TYPE : String = 'fm.wavesurfer.audio.events.LoadErrorEvent';
		
		private var url : String;

		public function LoadErrorEvent(url : String) {
			super(TYPE);

			this.url = url;
		}

		public function getUrl() : String {
			return url;
		}

		override public function clone() : Event {
			return new LoadErrorEvent(url);
		}
	}
}
