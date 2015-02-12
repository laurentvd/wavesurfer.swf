package fm.wavesurfer.audio.events {
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	public class LoadProgressEvent extends Event {
		
		public static const TYPE : String = 'fm.wavesurfer.audio.events.LoadProgressEvent';
		
		private var progress : Number;

		public function LoadProgressEvent(progress : Number) {
			super(TYPE);

			this.progress = progress;
		}

		public function getProgress() : Number {
			return progress;
		}

		override public function clone() : Event {
			return new LoadProgressEvent(progress);
		}
	}
}
