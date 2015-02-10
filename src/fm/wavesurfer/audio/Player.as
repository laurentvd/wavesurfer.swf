package fm.wavesurfer.audio {
	import flash.media.SoundChannel;
	import fm.wavesurfer.audio.events.LoadedEvent;

	/**
	 * @author laurent
	 */
	public class Player {
		private var loader : AudioLoader;
		private var audio : AudioData;
		private var currentSoundChannel : SoundChannel;
		private var lastSoundChannelPosition : Number = 0;

		public function Player() {
			loader = new AudioLoader();
			loader.addEventListener(LoadedEvent.TYPE, onAudioLoaded);
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
