package fm.wavesurfer.audio {
	import fm.wavesurfer.audio.events.LoadErrorEvent;
	import flash.events.IOErrorEvent;
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
		private var url : String;

		public function AudioLoader() {
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, onSoundLoaded);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onSoundLoadError);
		}

		/**
		 * 
		 */
		public function load(url : String) : void {
			this.url = url;
			sound.load(new URLRequest(url), new SoundLoaderContext());
		}

		/**
		 * 
		 */
		private function onSoundLoaded(event : Event) : void {
			var audio : AudioData = new AudioData(sound);
			dispatchEvent(new LoadedEvent(audio));
		}
		
		/**
		 * 
		 */
		private function onSoundLoadError(event : IOErrorEvent) : void {
			dispatchEvent(new LoadErrorEvent(url));
		}		
	}
}
