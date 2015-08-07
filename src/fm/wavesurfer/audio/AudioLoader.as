package fm.wavesurfer.audio {
	import fm.wavesurfer.audio.events.LoadProgressEvent;
	import flash.events.ProgressEvent;
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
			sound.addEventListener(ProgressEvent.PROGRESS, onSoundLoadProgress);
		}

		public function load(url : String) : void {
			this.url = url;

			var loadPolicyFile : Boolean = true;
			sound.load(new URLRequest(url), new SoundLoaderContext(1000, loadPolicyFile));
		}

		private function onSoundLoaded(event : Event) : void {
			var audio : AudioData = new AudioData(sound);
			dispatchEvent(new LoadedEvent(audio));
		}

		private function onSoundLoadError(event : IOErrorEvent) : void {
			dispatchEvent(new LoadErrorEvent(url));
		}
		
		private function onSoundLoadProgress(event : ProgressEvent) : void {
			var total : Number = event.bytesTotal ? event.bytesTotal : 1;
			dispatchEvent(new LoadProgressEvent(Math.min(1, event.bytesLoaded / total)));
		}	
	}
}
