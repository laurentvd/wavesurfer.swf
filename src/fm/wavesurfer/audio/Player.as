package fm.wavesurfer.audio {
	import fm.wavesurfer.audio.events.LoadProgressEvent;
	import fm.wavesurfer.audio.events.CompletedEvent;
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
			loader.addEventListener(LoadProgressEvent.TYPE, onAudioLoadProgress);
		}

		public function load(url : String, waveform : Array = null) : void {
			reset();
			loader.load(url, waveform);
		}

		public function play(startTime : Number = 0) : void {
			if (!audio) {
				return;
			}

			if (isPlaying()) {
				_stop();
			}

			// When no start time is supplied, check if we have a paused position
			startTime = startTime ? startTime : lastSoundChannelPosition;
			_play(startTime);

			// Reset to zero for the next time it will be paused
			lastSoundChannelPosition = 0;

			stage.addEventListener(Event.ENTER_FRAME, onProgressUpdate);
			dispatchEvent(new PlayEvent());
		}

		public function seek(progress : Number) : void {
			var time : Number = progress * getDuration();

			if (isPlaying()) {
				_stop();
				_play(time);
			} else {
				lastSoundChannelPosition = time;
			}

			dispatchEvent(new SeekEvent(time));
			dispatchProgressUpdate(time, getDuration());
		}

		public function pause() : void {
			if (!isPlaying()) {
				return;
			}

			stage.removeEventListener(Event.ENTER_FRAME, onProgressUpdate);

			lastSoundChannelPosition = getCurrentTime();
			_stop();

			dispatchEvent(new PauseEvent());
		}
		
		public function stop() : void {
			if (!isPlaying()) {
				return;
			}

			stage.removeEventListener(Event.ENTER_FRAME, onProgressUpdate);

			lastSoundChannelPosition = 0;
			_stop();
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
		
		public function setVolume(newVolume : Number) : void {
			currentSoundTransform.volume = newVolume;
		}
		
		public function getVolume() : Number {
			return currentSoundTransform.volume;
		}

		public function getAudio() : AudioData {
			return audio;
		}
		
		private function _play(time : Number = 0) : SoundChannel {
			var timeInMs : int = Math.round(time * 1000);
			
			currentSoundChannel = audio.getSound().play(timeInMs, 0, currentSoundTransform);
			currentSoundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundCompleted);
			return currentSoundChannel;
		}
		
		private function _stop() : void {
			if (!currentSoundChannel) {
				return;
			}

			currentSoundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundCompleted);
			currentSoundChannel.stop();
			currentSoundChannel = null;
		}

		private function dispatchProgressUpdate(time : Number, duration : Number) : void {
			dispatchEvent(new ProgressEvent(time, duration));
		}

		private function onAudioLoaded(event : LoadedEvent) : void {
			audio = event.getAudio();
			dispatchEvent(event);
		}
		
		private function onAudioLoadProgress(event : LoadProgressEvent) : void {
			dispatchEvent(event);
		}

		private function onAudioLoadError(event : LoadErrorEvent) : void {
			dispatchEvent(event);
		}

		private function onProgressUpdate(event : Event = null) : void {
			dispatchProgressUpdate(getCurrentTime(), getDuration());
		}
		
		private function onSoundCompleted(event : Event) : void {
			dispatchEvent(new CompletedEvent());
		}

		private function reset() : void {
			audio = null;
			_stop();
		}
	}
}
