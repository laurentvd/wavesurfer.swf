package fm.wavesurfer.audio {
	import fm.wavesurfer.audio.events.LoadErrorEvent;
	import fm.wavesurfer.audio.events.LoadedEvent;

	import flash.events.EventDispatcher;
	import flash.media.SoundChannel;

	/**
	 * @author laurent
	 */
	public class Player extends EventDispatcher {
		
		private var loader : AudioLoader;
		private var audio : AudioData;
		private var currentSoundChannel : SoundChannel;
		private var lastSoundChannelPosition : Number = 0;

		public function Player() {
			loader = new AudioLoader();
			loader.addEventListener(LoadedEvent.TYPE, onAudioLoaded);
			loader.addEventListener(LoadErrorEvent.TYPE, onAudioLoadError);
		}
		
		public function load(url : String) : void {
			reset();
			loader.load(url);
		}

		public function play() : void {
			if (!audio) {
				return;
			}
			currentSoundChannel = audio.getSound().play(lastSoundChannelPosition);
			lastSoundChannelPosition = 0;
		}

		public function pause() : void {
			if (!currentSoundChannel) {
				return;
			}

			lastSoundChannelPosition = currentSoundChannel.position;
			currentSoundChannel.stop();
		}

		private function onAudioLoaded(event : LoadedEvent) : void {
			audio = event.getAudio();
			dispatchEvent(event);
		}

		private function onAudioLoadError(event : LoadErrorEvent) : void {
			dispatchEvent(event);
		}
		
		private function reset() : void {
			audio = null;
			if (currentSoundChannel) {
				currentSoundChannel.stop();
				currentSoundChannel = null;
			}
		}
	}
}
