package fm.wavesurfer.jsapi {
	/**
	 * @author laurent
	 */
	public class FlashVarOptions {
		
		public var id : String = 'wavesurfer';
		
		public static function fromObject(vars : Object = null) : FlashVarOptions {
			if ( ! vars) {
				vars = new Object();
			}
			
			var options : FlashVarOptions = new FlashVarOptions();

			options.id = vars['id'] ? vars['id'] : options.id;
			
			return options;
		}
	}
}
