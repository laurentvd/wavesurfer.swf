package fm.wavesurfer.jsapi {
	import fm.wavesurfer.audio.Player;
	import flash.external.ExternalInterface;
	/**
	 * @author laurent
	 */
	public class JavascriptAPI {
		
		private var player : Player;
		
		public function JavascriptAPI(player : Player) {
			if (!ExternalInterface.available) {
				return;
			}
			
			this.player = player;
			
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
		}

		public function init(options : Object) : void {
			// TODO: Implement
		}

		public function destroy() : void {
			// TODO: Implement
		}

		public function empty() : void {
			// TODO: Implement
		}

		public function getCurrentTime() : void {
			// TODO: Implement
		}

		public function getDuration() : void {
			// TODO: Implement
		}

		public function load(url : String) : void {
			// TODO: Implement
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
			// TODO: Implement
		}

		public function play(start : Number = 0, end : Number = Number.MAX_VALUE) : void {
			// TODO: Implement
		}

		public function playPause() : void {
			// TODO: Implement
		}

		public function seekAndCenter(progress : Number) : void {
			// TODO: Implement
		}

		public function seekTo(progress : Number) : void {
			// TODO: Implement
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
	}
}
