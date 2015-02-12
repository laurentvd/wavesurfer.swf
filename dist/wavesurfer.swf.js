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
		play: function(start, end) {
			start = start || 0;

			this.instance.play(start);
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
			this._notImplemented();
		},

		/**
		 *
		 */
		skipForward: function() {
			this._notImplemented();
		},

		/**
		 *
		 */
		skip: function() {
			this._notImplemented();
		},

		/**
		 *
		 */
		seekAndCenter: function() {
			this._notImplemented();
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
			this._notImplemented();
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
			this._notImplemented();
		},

		/**
		 *
		 */
		toggleInteraction: function() {
			this._notImplemented();
		},

		/**
		 * @param {String} url
		 */
		load: function(url) {
			this.instance.load(url);
		},

		/**
		 * @param {Number} samples
		 */
		exportPCM: function(samples) {
			samples = samples || this.instance.offsetWidth;
			return this.instance.exportPCM(samples);
		},

		/**
		 *
		 */
		empty: function() {
			this._notImplemented();
		},

		/**
		 *
		 */
		destroy: function() {
			this._notImplemented();
		},

		/**
		 *
		 * @private
		 */
		_notImplemented: function() {
			throw new Error('Not implemented in WaveSurfer.swf');
		}
	};

	// Enable event listener on WaveSurfer.Swf
	WaveSurfer.util.extend(WaveSurfer.Swf, WaveSurfer.Observer);
})();