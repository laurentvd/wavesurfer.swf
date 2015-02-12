(function() {

	'use strict';

	// Hook into the existing WaveSurfer object
	window.WaveSurfer = WaveSurfer || {};
	WaveSurfer.Swf = {

		/**
		 * Reference to the loaded swf file
		 */
		instance: null,

		/**
		 * @param {Node} instance
		 */
		setInstance: function(instance) {
			this.instance = instance;
		},

		/**
		 * @param {Object} options
		 */
		init: function(options) {
			options = options || {};

			// Clear container reference, causes Flash to hang
			options.container = null;

			this.instance.init(options);
		},

		/**
		 * @return {Number}
		 */
		getDuration: function() {
			return this.instance.getDuration();
		},

		/**
		 * @return {Number}
		 */
		getCurrentTime: function() {
			return this.instance.getCurrentTime();
		},

		/**
		 *
		 */
		play: function() {
			this.instance.play();
		},

		/**
		 *
		 */
		pause: function() {
			this.instance.pause();
		},

		/**
		 *
		 */
		playPause: function() {
			this.instance.playPause();
		},

		/**
		 *
		 */
		skipBackward: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 *
		 */
		skipForward: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 *
		 */
		skip: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 *
		 */
		seekAndCenter: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 * @param {Number} progress - Between 0 and 1
		 */
		seekTo: function(progress) {
			this.instance.seekTo(progress);
		},

		/**
		 *
		 */
		stop: function() {
			this.instance.stop();
		},

		/**
		 * @param {Number} volume - Between 0 and 1
		 */
		setVolume: function(volume) {
			this.instance.setVolume(volume);
		},

		/**
		 *
		 */
		setPlaybackRate: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 *
		 */
		toggleMute: function() {
			this.instance.toggleMute();
		},

		/**
		 *
		 */
		toggleScroll: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 *
		 */
		toggleInteraction: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 * @param {String} url
		 */
		load: function(url) {
			this.instance.load(url);
		},

		/**
		 *
		 */
		exportPCM: function() {
			return this.instance.exportPCM();
		},

		/**
		 *
		 */
		empty: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		},

		/**
		 *
		 */
		destroy: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		}
	};

	// Enable event listener on WaveSurfer.Swf
	WaveSurfer.util.extend(WaveSurfer.Swf, WaveSurfer.Observer);
})();