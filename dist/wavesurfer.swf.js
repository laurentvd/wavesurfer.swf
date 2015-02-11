(function() {

	'use strict';

	// Hook into the existing WaveSurfer object
	WaveSurfer.Swf = {

		/**
		 * Invoked by the SWF once it has loaded and inited
		 *
		 * @return {void}
		 */
		swfIsReady: function() {
			this.fireEvent('ready');
		},

		init: function(options) {
		}
	};

	// Enable event listener on WaveSurfer.Swf
	WaveSurfer.util.extend(WaveSurfer.Swf, WaveSurfer.Observer);
})();