package fm.wavesurfer.jsapi {
	import fm.wavesurfer.audio.events.LoadProgressEvent;
	import fm.wavesurfer.audio.events.SeekEvent;
	import fm.wavesurfer.audio.events.PlayEvent;
	import fm.wavesurfer.audio.events.PauseEvent;
	import fm.wavesurfer.audio.events.CompletedEvent;
	import fm.wavesurfer.audio.events.LoadedEvent;
	import fm.wavesurfer.audio.AudioData;
	import fm.wavesurfer.audio.events.LoadErrorEvent;
	import fm.wavesurfer.debugmessage.DebugMessage;
	import fm.wavesurfer.audio.Player;
	import fm.wavesurfer.waves.Waves;

	import flash.external.ExternalInterface;
	import flash.system.Security;
	/**
	 * @author laurent
	 */
	public class JavascriptAPI {
		private var player : Player;
		private var waves : Waves;
		private var debugMessage : DebugMessage;

		public function JavascriptAPI(player : Player, waves : Waves, debugMessage : DebugMessage) {
			
			this.player = player;
			this.waves = waves;
			this.debugMessage = debugMessage;
			
			// Add listeners
			player.addEventListener(LoadErrorEvent.TYPE, onAudioLoadError);
			player.addEventListener(LoadProgressEvent.TYPE, onAudioLoadProgress);
			player.addEventListener(LoadedEvent.TYPE, onAudioLoaded);
			player.addEventListener(CompletedEvent.TYPE, onCompleted);
			player.addEventListener(PauseEvent.TYPE, onPaused);
			player.addEventListener(PlayEvent.TYPE, onPlayed);
			player.addEventListener(SeekEvent.TYPE, onSeeked);
			
			// Allow calls to the player from any domain
			Security.allowDomain('*');
			
			// Link to JS
			setupExternalInterface();
		}

		public function init(options : Object) : void {
			var initOptions : InitOptions = InitOptions.fromObject(options);
			waves.setup(initOptions);
		}

		public function getCurrentTime() : Number {
			return player.getCurrentTime();
		}

		public function getDuration() : Number {
			return player.getDuration();
		}

		public function load(url : String) : void {
			player.load(url);
		}
		
		public function pause() : void {
			player.pause();
		}

		public function play(start : Number = 0, end : Number = Number.MAX_VALUE) : void {
			end = 0; // End is ignored for now
			player.play(start);
		}
		
		public function exportPCM(samples : int) : Array {
			var audio : AudioData = player.getAudio();
			if (!audio) {
				return [];
			}
			
			return audio.asSimplifiedWaveData(samples / player.getDuration());
		}

		public function playPause() : void {
			if (player.isPlaying()) {
				player.pause();
				return;
			}
			player.play();
		}

		public function seekTo(progress : Number) : void {
			player.seek(progress);
		}

		public function setVolume(newVolume : Number) : void {
			player.setVolume(newVolume);
		}

		public function stop() : void {
			player.stop();
		}

		public function toggleMute() : void {
			if (player.getVolume() === 0) {
				player.setVolume(1);
				return;
			}
			player.setVolume(0);
		}
		
		
		private function triggerError(error : String) : void {
			debugMessage.error(error);
			fireEvent('error', error);
		}
		
		private function setupExternalInterface() : void {
			if (!ExternalInterface.available) {
				triggerError('ExternalInterface not available, cannot start.');
				return;
			}
			
			ExternalInterface.addCallback('init', init);
			ExternalInterface.addCallback('getCurrentTime', getCurrentTime);
			ExternalInterface.addCallback('getDuration', getDuration);
			ExternalInterface.addCallback('load', load);
			ExternalInterface.addCallback('pause', pause);
			ExternalInterface.addCallback('play', play);
			ExternalInterface.addCallback('playPause', playPause);
			ExternalInterface.addCallback('seekTo', seekTo);
			ExternalInterface.addCallback('setVolume', setVolume);
			ExternalInterface.addCallback('stop', stop);
			ExternalInterface.addCallback('toggleMute', toggleMute);
			ExternalInterface.addCallback('exportPCM', exportPCM);

			// Callback to javascript
			fireEvent('init');
		}
		
		private function fireEvent(name : String, data : * = null) : void {
			if (!ExternalInterface.available) {
				return;
			}
			ExternalInterface.call('WaveSurfer.Swf.fireEvent', name, data);
		}

		private function onSeeked(event : SeekEvent) : void {
			fireEvent('seek', event.getTime() / player.getDuration());
		}

		private function onPlayed(event : PlayEvent) : void {
			fireEvent('play');
		}

		private function onPaused(event : PauseEvent) : void {
			fireEvent('pause');
		}

		private function onCompleted(event : CompletedEvent) : void {
			fireEvent('finish');
		}

		private function onAudioLoaded(event : LoadedEvent) : void {
			fireEvent('ready');
		}

		private function onAudioLoadProgress(event : LoadProgressEvent) : void {
			fireEvent('loading', Math.round(100 * event.getProgress()));
		}
		
		private function onAudioLoadError(event : LoadErrorEvent) : void {
			triggerError('Cannot load the supplied URL "' + event.getUrl() + '".');
		}
	}
}
