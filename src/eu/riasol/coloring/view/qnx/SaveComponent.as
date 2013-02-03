package eu.riasol.coloring.view.qnx {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.net.FileReference;

	import mx.graphics.codec.PNGEncoder;

	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;

	public class SaveComponent extends Container {
		public var saveDrawable:DisplayObject
		public function SaveComponent(s:Number=100, su:String="percent") {
			super(s, su);
			var b:LabelButton=new LabelButton()
				b.width=100
			b.label='save'
			b.addEventListener(MouseEvent.CLICK, onClick)
			addChild(b)
		}
		private function onClick(e:MouseEvent):void {
			var bd:BitmapData=new BitmapData(saveDrawable.width, saveDrawable.height)
			bd.draw(saveDrawable)
			var png:PNGEncoder=new PNGEncoder()

			var fr:FileReference=new FileReference()
			fr.save(png.encode(bd), 'my coloring.png')
		}
	}
}