package fm.wavesurfer.audio {
	import fm.wavesurfer.audio.events.LoadErrorEvent;
	import fm.wavesurfer.audio.events.LoadedEvent;
	import fm.wavesurfer.audio.events.PauseEvent;
	import fm.wavesurfer.audio.events.PlayEvent;
	import fm.wavesurfer.audio.events.ProgressEvent;
	import fm.wavesurfer.audio.events.SeekEvent;

	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author laurent
	 */
	public class Player extends EventDispatcher {
		private var loader : AudioLoader;
		private var audio : AudioData;
		private var currentSoundChannel : SoundChannel;
		private var currentSoundTransform : SoundTransform;
		
		/**
		 * The stage is used to attach the enter frame listener to
		 */
		private var stage : Stage;
		private var lastSoundChannelPosition : Number = 0; // seconds

		public function Player(stage : Stage) {
			this.stage = stage;
			
			currentSoundTransform = new SoundTransform();

			loader = new AudioLoader();
			loader.addEventListener(LoadedEvent.TYPE, onAudioLoaded);
			loader.addEventListener(LoadErrorEvent.TYPE, onAudioLoadError);
		}

		public function load(url : String) : void {
			reset();
			loader.load(url);
		}

		public function play(startTime : Number = 0) : void {
			if (!audio) {
				return;
			}

			if (isPlaying()) {
				currentSoundChannel.stop();
			}

			// When no start time is supplied, check if we have a paused position
			startTime = startTime ? startTime : lastSoundChannelPosition;
			currentSoundChannel = playFrom(startTime);

			// Reset to zero for the next time it will be paused
			lastSoundChannelPosition = 0;

			stage.addEventListener(Event.ENTER_FRAME, onProgressUpdate);
			dispatchEvent(new PlayEvent());
		}

		public function seek(progress : Number) : void {
			var time : Number = progress * getDuration();

			if (isPlaying()) {
				currentSoundChannel.stop();
				currentSoundChannel = playFrom(time);
			} else {
				lastSoundChannelPosition = time;
			}

			dispatchEvent(new SeekEvent(time));
			dispatchProgressUpdate(time, getDuration());
		}
		
		public function setVolume(newVolume : Number) : void {
			currentSoundTransform.volume = newVolume;
		}
		
		public function getVolume() : Number {
			return currentSoundTransform.volume;
		}

		public function pause() : void {
			if (!isPlaying()) {
				return;
			}

			stage.removeEventListener(Event.ENTER_FRAME, onProgressUpdate);

			lastSoundChannelPosition = getCurrentTime();
			currentSoundChannel.stop();
			currentSoundChannel = null;

			dispatchEvent(new PauseEvent());
		}
		
		public function stop() : void {
			if (!isPlaying()) {
				return;
			}

			stage.removeEventListener(Event.ENTER_FRAME, onProgressUpdate);

			lastSoundChannelPosition = 0;
			currentSoundChannel.stop();
		}

		public function isPlaying() : Boolean {
			return !!currentSoundChannel;
		}

		public function getCurrentTime() : Number {
			if (!currentSoundChannel) {
				return 0;
			}
			return currentSoundChannel.position / 1000;
		}

		public function getDuration() : Number {
			if (!audio) {
				return 0;
			}
			return audio.getSound().length / 1000;
		}

		public function getAudio() : AudioData {
			return audio;
		}
		
		private function playFrom(time : Number = 0) : SoundChannel {
			var timeInMs : int = Math.round(time * 1000);
			return audio.getSound().play(timeInMs, 0, currentSoundTransform);
		}

		private function dispatchProgressUpdate(time : Number, duration : Number) : void {
			dispatchEvent(new ProgressEvent(time, duration));
		}

		private function onAudioLoaded(event : LoadedEvent) : void {
			audio = event.getAudio();
			dispatchEvent(event);
		}

		private function onAudioLoadError(event : LoadErrorEvent) : void {
			dispatchEvent(event);
		}

		private function onProgressUpdate(event : Event = null) : void {
			dispatchProgressUpdate(getCurrentTime(), getDuration());
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
