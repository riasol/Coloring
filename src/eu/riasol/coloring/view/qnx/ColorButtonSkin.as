package eu.riasol.coloring.view.qnx
{
	import flash.display.Sprite;
	
	import qnx.ui.core.UIComponent;
	
	public class ColorButtonSkin extends UIComponent
	{
		private var drawTarget:Sprite;
		public function ColorButtonSkin()
		{
			super();
			drawTarget=new Sprite()
		}
		override protected function onAdded():void {
			super.onAdded()
			addChild(drawTarget)
		}
		override protected function onRemoved():void {
			super.onRemoved()
			removeChild(drawTarget)
		}
		override public function drawNow():void{
		trace(this)
		}
	}
}