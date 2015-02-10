package fm.wavesurfer.audio {
	import fm.wavesurfer.audio.events.LoadedEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;

	/**
	 * @author laurent
	 */
	public class AudioLoader extends EventDispatcher {
		
		private var sound : Sound;

		public function AudioLoader() {
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, onSoundLoaded);
		}

		/**
		 * 
		 */
		public function load(url : String) : void {
			sound.load(new URLRequest(url), new SoundLoaderContext());
		}

		/**
		 * 
		 */
		private function onSoundLoaded(event : Event) : void {
			var audio : AudioData = new AudioData(sound);
			dispatchEvent(new LoadedEvent(audio));
		}
		
	}
}
