package fm.wavesurfer {
	import fm.wavesurfer.audio.Player;
	import fm.wavesurfer.debugmessage.DebugMessage;
	import fm.wavesurfer.jsapi.JavascriptAPI;
	import fm.wavesurfer.waves.Waves;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * @author laurent
	 */
	[SWF(backgroundColor="#ffffff", frameRate="31", width="700", height="128")]
	public class WaveSurfer extends Sprite {
		
		private var waves : Waves;
		private var player : Player;
		private var api : JavascriptAPI;
		private var debugMessage : DebugMessage;
		
		public function WaveSurfer() {
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}

		private function init() : void {
			
			// Config stage
			stage.showDefaultContextMenu = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Create elements
			player = new Player(stage);
			waves = new Waves(player);
			debugMessage = new DebugMessage();
			addChild(waves);
			addChild(debugMessage);
			
			api = new JavascriptAPI(player, waves, debugMessage);
		}
	}
}
