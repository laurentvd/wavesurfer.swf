(function() {

	'use strict';

	var WaveSurferSwf = {
		reference: null,

		/**
		 * Invoked by the SWF once it has loaded and inited
		 */
		swfIsReady: function() {

		},

		init: function(options) {
			if (options.onReady) {
				this.onReady = options.onReady;
			}
			this.embed();
		},
		embed: function() {

		}
	}

	// Copy to the global scope
	WaveSurfer.swf = WaveSurferSwf;
})();