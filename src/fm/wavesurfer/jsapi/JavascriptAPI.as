package fm.wavesurfer.jsapi {
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
			player.addEventListener(LoadErrorEvent.TYPE, onLoadError);
			
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
		
		public function exportPCM(samples : int = 1000) : Array {
			var audio : AudioData = player.getAudio();
			if (!audio) {
				return [];
			}
			
			return audio.asSimplifiedWaveData(samples);
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
		
		private function onLoadError(event : LoadErrorEvent) : void {
			debugMessage.error('Cannot load the supplied URL "' + event.getUrl() + '".');
		}
		
		private function setupExternalInterface() : void {
			if (!ExternalInterface.available) {
				debugMessage.error('ExternalInterface not available, cannot start.');
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
			ExternalInterface.call('WaveSurfer.Swf.fireEvent', 'init');
		}
	}
}
