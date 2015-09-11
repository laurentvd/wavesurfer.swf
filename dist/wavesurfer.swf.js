(function() {

	'use strict';

	/**
	 * @param {String} [id]
	 * @constructor
	 */
	WaveSurfer.Swf = function(id) {
		if (!id) {
			id = 'wavesurfer';
		}
		this.id = id;

		// Add this instance to the list so fireEvent can be directed to the correct instance
		WaveSurfer.Swf.instances[id] = this;
	};
	WaveSurfer.Swf.prototype = {

		/**
		 * Reference to the loaded swf file
		 *
		 * @type {Element}
		 */
		instance: null,

		/**
		 * The Id that was passed when creating this object
		 *
		 * @type {String}
		 */
		id: 'wavesurfer',

		/**
		 * @param {Object} options
		 */
		init: function(options) {
			options = options || {};

			// Clear container reference, causes Flash to hang
			options.container = null;

			if (!this.instance) {
				this.instance = document.getElementById(this.id);
			}
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
		isPlaying: function() {
			this.instance.isPlaying();
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
		 */
		getId: function() {
			return this.id;
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
	WaveSurfer.util.extend(WaveSurfer.Swf.prototype, WaveSurfer.Observer);

	/**
	 * Merge the 'static' properties to enable instance resolving
	 */
	WaveSurfer.util.extend(WaveSurfer.Swf, {

		/**
		 * Contains all WaveSurfer.Swf instances
		 */
		instances: {},

		/**
		 * @return {Boolean}
		 * @private
		 */
		supportsAudioContext: function() {
			return !!(window.AudioContext || window.webkitAudioContext);
		},

		/**
		 * @returns {boolean}
		 * @private
		 */
		supportsCanvas: function() {
			var elem = document.createElement('canvas');
			return !!(elem.getContext && elem.getContext('2d'));
		},

		/**
		 *
		 * @param {String} id
		 * @return {WaveSurfer.Swf}
		 */
		getInstanceById: function(id) {
			return WaveSurfer.Swf.instances[id];
		},

		/**
		 * Fire an event on the instance with the supplied id
		 * @param {String} id
		 * @param {String} eventName
		 */
		fireEvent: function(id, eventName) {
			var args = Array.prototype.slice.call(arguments, 1);
			var instance = WaveSurfer.Swf.getInstanceById(id);

			//console.log(instance);
			WaveSurfer.Observer.fireEvent.apply(instance, args);
		}
	});

})();