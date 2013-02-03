package eu.riasol.coloring.application
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ColoringEventDispatcher extends EventDispatcher
	{
		private static var _instance:ColoringEventDispatcher

		public static function get instance():ColoringEventDispatcher
		{
			if(_instance==null){
				_instance=new ColoringEventDispatcher()
			}
			return _instance;
		}

		public function ColoringEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}