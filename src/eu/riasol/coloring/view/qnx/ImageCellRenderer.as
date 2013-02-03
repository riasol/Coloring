package eu.riasol.coloring.view.qnx
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import flashprolib.util.DisplayUtils;
	
	import qnx.ui.display.Image;
	import qnx.ui.listClasses.CellRenderer;
	import qnx.utils.ImageCache;
	
	public class ImageCellRenderer extends CellRenderer
	{
		public static var cacheObject:ImageCache = new ImageCache();
		protected var img:Image;

		public function ImageCellRenderer()
		{
			super();
			label.visible = false;
			img = new Image();
			img.addEventListener(Event.COMPLETE, onComplete);
			img.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void{});
			img.smoothing = true;
			img.cache = cacheObject;
			addChild(img);
		}
		override public function set data(v:Object):void{
			super.data = v;
			if (data) {
				img.setImage(data.tbUrl);
			}
		}
		override public function setSize(w:Number, h:Number):void {
			super.setSize(w, h);
			if (stage) {
				layout();
			}
		}
		private function layout():void {
			onComplete(new Event(Event.COMPLETE));
		}
		private function onComplete(e:Event):void {
			//img.setSize(width , height );
			DisplayUtils.center(img,this)
		}



	}
}