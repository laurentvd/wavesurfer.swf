package fm.wavesurfer.audio {
	import fm.wavesurfer.audio.events.ProgressEvent;
	import flash.events.Event;
	import flash.display.Stage;
	import fm.wavesurfer.audio.events.SeekEvent;
	import fm.wavesurfer.audio.events.PauseEvent;
	import fm.wavesurfer.audio.events.PlayEvent;
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
		
		/**
		 * The stage is used to attach the enter frame listener to
		 */
		private var stage : Stage;
		
		private var lastSoundChannelPosition : Number = 0;

		public function Player(stage : Stage) {
			
			this.stage = stage;
			
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
			
			if (currentSoundChannel) {
				currentSoundChannel.stop();
			}
			
			// When no start time is supplied, check if we have a paused position
			startTime = startTime ? startTime : lastSoundChannelPosition;
			currentSoundChannel = audio.getSound().play(startTime);
			
			// Reset to zero for the next time it will be paused
			lastSoundChannelPosition = 0;
			
			stage.addEventListener(Event.ENTER_FRAME, onProgressUpdate);
			dispatchEvent(new PlayEvent());
		}
		
		public function seek(progress : Number) : void {
			var time : Number = progress * getDuration();
			
			if (currentSoundChannel) {
				currentSoundChannel = audio.getSound().play(time);	
			}

			dispatchEvent(new SeekEvent(time));
			dispatchProgressUpdate(time, getDuration());
		}

		public function pause() : void {
			if (!currentSoundChannel) {
				return;
			}
			
			stage.removeEventListener(Event.ENTER_FRAME, onProgressUpdate);

			lastSoundChannelPosition = currentSoundChannel.position;
			currentSoundChannel.stop();

			dispatchEvent(new PauseEvent());
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
			return audio.getSound().length;
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
