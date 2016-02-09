# wavesurfer.swf
Flash fallback for wavesurfer.js

## Goal

The purpose of wavesurfer.swf is to bring as many [wavesurfer.js](https://github.com/katspaugh/wavesurfer.js/)
functionalities as possible to browser that do not support WebAudio or Canvas.
It does this by mimicking the js version in Flash, using the same API.

## Browser support

Any browser that runs Flash. It was originally built to support IE9 - IE11 which all
lack the required WebAudio support.

## Requirements

Wavesurfer.swf has no requirements apart from wavesurfer.js! However, we use SWFObject in
the demo to embed the SWF.

## How to use

Please refer to the demo folder for an example on how to implement wavesurfer.swf. Keep
in mind that you cannot view the Flash version when running from your local disk.
You need to run this demo on a webserver. This is a Flash security restriction.

The [API](#api) is similar to the js version, although not all methods and configuration options are
supported at the moment. Here's a very brief example:

```javascript
var wavesurfer = new WaveSurfer.Swf('myFlashContainerid');

// ... embed the SWF on the page using any method you like

// Wait for the swf to initialize
wavesurfer.on('init', function() {

    // Initialize with your own configuration object
    wavesurfer.init({
        waveColor: '#999999',
        ...
    });

    // And load the mp3 file
    wavesurfer.load('Rick_Astley.mp3');
});
```

For more examples, please refer to the readme of [wavesurfer.js](https://github.com/katspaugh/wavesurfer.js).

## API

Not all of the wavesurfer.js is currently supported. Below you'll find a list of everything that's supported.

### Supported WaveSurfer Options

| option | type | default | description |
| --- | --- | --- | --- |
| `cursorWidth` | integer | `1` | Measured in pixels. |
| `cursorColor` | string | `#333` | The fill color of the cursor indicating the playhead position. |
| `progressColor` | string | `#555` | The fill color of the part of the waveform behind the cursor. |
| `waveColor` | string | `#999` | The fill color of the waveform after the cursor. |
| `backgroundColor` | string | `#fff` | The fill color of background. |

### Supported WaveSurfer Methods

 * `init(options)` – Initializes with the options listed above.
 * `getCurrentTime()` – Returns current progress in seconds.
 * `getDuration()` – Returns the duration of an audio clip in seconds.
 * `isPlaying()` – Returns true if currently playing, false otherwise.
 * `getId()` – Get the id
 * `load(url)` – Loads audio from URL.
 * `on(eventName, callback)` – Subscribes to an event.  See [WaveSurfer Events](#supported-wavesurfer-events) section below for a list.
 * `un(eventName, callback)` – Unsubscribes from an event.
 * `unAll()` – Unsubscribes from all events.
 * `pause()` – Stops playback.
 * `play([start])` – Starts playback from the current position.
 * `playPause()` – Plays if paused, pauses if playing.
 * `seekTo(progress)` – Seeks to a progress `[0..1]` (0=beginning, 1=end).
 * `setVolume(newVolume)` – Sets the playback volume to a new value `[0..1]` (0 = silent, 1 = maximum).
 * `stop()` – Stops and goes to the beginning.
 * `toggleMute()` – Toggles the volume on and off.
 * `exportPCM([samples])` – Get the PCM wave data as an array.

### Supported WaveSurfer Events

 * `init` – The SWF has loaded and is ready to init.
 * `error` – Occurs on error.  Callback will receive (string) error message.
 * `finish` – When it finishes playing.
 * `loading` – Fires continuously when loading. Callback will receive (integer) loading progress in percents [0..100].
 * `pause` – When audio is paused.
 * `play` – When play starts.
 * `ready` – When audio is loaded, decoded and the waveform drawn.
 * `seek` – On seeking.  Callback will receive (float) progress [0..1].

## Credits

Original [Javascript version](https://github.com/katspaugh/wavesurfer.js/) by [katspaugh](https://github.com/katspaugh) and [others](https://github.com/katspaugh/wavesurfer.js/contributors)!