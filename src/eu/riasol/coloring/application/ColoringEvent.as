package eu.riasol.coloring.application
{
	import flash.events.Event;
	
	public class ColoringEvent extends Event
	{
		public static const EVENT_APPLY_FILTER:String='EVENT_APPLY_FILTER'
		public static const EVENT_REMOVE_FILTER:String='EVENT_REMOVE_FILTER'
		public static const EVENT_COLOR_SELECT:String='EVENT_COLOR_SELECT'
		public static const EVENT_BRUSH_SIZE_SELECT:String='EVENT_BRUSH_SIZE_SELECT'
		public static const EVENT_IMAGE_SELECT:String='EVENT_IMAGE_SELECT'
			public var data:Object
		public function ColoringEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}