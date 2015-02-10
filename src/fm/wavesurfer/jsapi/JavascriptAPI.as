package fm.wavesurfer.jsapi {
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
			var initOptions : InitOptions = InitOptions.fromFlashVars(options);
			waves.setup(initOptions);
		}

		public function destroy() : void {
			// TODO: Implement
		}

		public function empty() : void {
			// TODO: Implement
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

		public function loadBlob(url : String) : void {
			// Not implemented in Flash version
		}

		public function on(eventName : String, callback : String) : void {
			// TODO: Implement
		}

		public function un(eventName : String, callback : String) : void {
			// TODO: Implement
		}

		public function unAll() : void {
			// TODO: Implement
		}

		public function pause() : void {
			player.pause();
		}

		public function play(start : Number = 0, end : Number = Number.MAX_VALUE) : void {
			player.play(start);
		}

		public function playPause() : void {
			// TODO: Implement
		}

		public function seekAndCenter(progress : Number) : void {
			// TODO: Implement
		}

		public function seekTo(progress : Number) : void {
			player.seek(progress);
		}

		public function setFilter() : void {
			// Not implemented in Flash version
		}

		public function setPlaybackRate(rate : Number) : void {
			// TODO: Implement
		}

		public function setVolume(newVolume : Number) : void {
			// TODO: Implement
		}

		public function skip(offset : Number) : void {
			// TODO: Implement
		}

		public function skipBackward() : void {
			// TODO: Implement
		}

		public function skipForward() : void {
			// TODO: Implement
		}

		public function stop() : void {
			// TODO: Implement
		}

		public function toggleMute() : void {
			// TODO: Implement
		}

		public function toggleInteraction() : void {
			// TODO: Implement
		}

		public function toggleScroll() : void {
			// TODO: Implement
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
			ExternalInterface.addCallback('destroy', destroy);
			ExternalInterface.addCallback('empty', empty);
			ExternalInterface.addCallback('getCurrentTime', getCurrentTime);
			ExternalInterface.addCallback('getDuration', getDuration);
			ExternalInterface.addCallback('load', load);
			ExternalInterface.addCallback('loadBlob', loadBlob);
			ExternalInterface.addCallback('on', on);
			ExternalInterface.addCallback('un', un);
			ExternalInterface.addCallback('unAll', unAll);
			ExternalInterface.addCallback('pause', pause);
			ExternalInterface.addCallback('play', play);
			ExternalInterface.addCallback('playPause', playPause);
			ExternalInterface.addCallback('seekAndCenter', seekAndCenter);
			ExternalInterface.addCallback('seekTo', seekTo);
			ExternalInterface.addCallback('setFilter', setFilter);
			ExternalInterface.addCallback('setPlaybackRate', setPlaybackRate);
			ExternalInterface.addCallback('setVolume', setVolume);
			ExternalInterface.addCallback('skip', skip);
			ExternalInterface.addCallback('skipBackward', skipBackward);
			ExternalInterface.addCallback('skipForward', skipForward);
			ExternalInterface.addCallback('stop', stop);
			ExternalInterface.addCallback('toggleMute', toggleMute);
			ExternalInterface.addCallback('toggleInteraction', toggleInteraction);
			ExternalInterface.addCallback('toggleScroll', toggleScroll);

			// Callback to javascript
			ExternalInterface.call('wavesurfer.flash.onReady');
		}
	}
}
